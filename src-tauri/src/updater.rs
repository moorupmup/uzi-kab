use crate::repository::{err, Database};
use reqwest::blocking::Client;
use semver::Version;
use serde::{Deserialize, Serialize};
use sha2::{Digest, Sha256};
use std::{fs, io::{Read, Write}, path::{Path, PathBuf}, process::Command, sync::Mutex, time::Duration};
use tauri::{Emitter, Manager};

const ENDPOINT: &str = "https://api.github.com/repos/moorupmup/uzi-kab/releases/latest";
const PREFIX: &str = "https://github.com/moorupmup/uzi-kab/releases/download/";
const MAX_BYTES: u64 = 250 * 1024 * 1024;
static INSTALLING: Mutex<()> = Mutex::new(());
#[derive(Deserialize)]
struct Release { tag_name: String, draft: bool, prerelease: bool, assets: Vec<Asset> }
#[derive(Clone, Deserialize)]
struct Asset { name: String, browser_download_url: String, size: u64, digest: Option<String> }
#[derive(Serialize)]
pub struct UpdateInfo { current: String, version: Option<String>, error: Option<String> }
fn version(value: &str) -> Result<Version, String> {
    let value = value.trim().trim_start_matches('v');
    Version::parse(&if value.split('.').count() == 2 { format!("{value}.0") } else { value.into() }).map_err(err)
}
fn client(timeout: u64) -> Result<Client, String> {
    Client::builder().user_agent(concat!("uzi-kab/", env!("CARGO_PKG_VERSION"))).https_only(true)
        .connect_timeout(Duration::from_secs(10)).timeout(Duration::from_secs(timeout)).build().map_err(err)
}
fn select(release: Release, current: &str) -> Result<Option<(String, Asset)>, String> {
    let next = version(&release.tag_name)?;
    if release.draft || release.prerelease || !next.pre.is_empty() || next <= version(current)? { return Ok(None); }
    let mut assets: Vec<_> = release.assets.into_iter().filter(|a| a.name.to_lowercase().ends_with(".exe")).collect();
    if assets.len() != 1 { return Err("В релизе должен быть один готовый EXE программы.".into()); }
    let asset = assets.remove(0);
    if !asset.browser_download_url.starts_with(PREFIX) || asset.size == 0 || asset.size > MAX_BYTES { return Err("Некорректный файл обновления.".into()); }
    let digest = asset.digest.as_deref().and_then(|s| s.strip_prefix("sha256:")).unwrap_or("");
    if digest.len() != 64 || !digest.bytes().all(|b| b.is_ascii_hexdigit()) { return Err("GitHub ещё не подготовил контрольную сумму обновления. Попробуйте позже.".into()); }
    Ok(Some((next.to_string(), asset)))
}
fn latest() -> Result<Option<(String, Asset)>, String> {
    let response = client(20)?.get(ENDPOINT).header("Accept", "application/vnd.github+json").send().map_err(|_| "Не удалось проверить обновления. Проверьте подключение к интернету.".to_string())?;
    if response.status() == 404 { return Ok(None); }
    select(response.error_for_status().map_err(err)?.json::<Release>().map_err(err)?, env!("CARGO_PKG_VERSION"))
}
#[tauri::command]
pub async fn check_update() -> Result<UpdateInfo, String> {
    tauri::async_runtime::spawn_blocking(|| {
        let error_path = std::env::current_exe().map_err(err)?.with_extension("update-error.txt");
        let error = fs::read_to_string(&error_path).ok();
        // A helper exits just after launching the app; retry cleanup at the hourly check if still locked.
        if let Ok(_guard) = INSTALLING.try_lock() { cleanup_staging(); }
        let version = latest()?.map(|v|v.0);
        if error.is_some() { let _ = fs::remove_file(error_path); }
        Ok(UpdateInfo {current: env!("CARGO_PKG_VERSION").into(), version, error})
    }).await.map_err(err)?
}
fn cleanup_staging() {
    let Ok(target) = std::env::current_exe() else { return };
    let Some(parent) = target.parent() else { return };
    let Ok(entries) = fs::read_dir(parent) else { return };
    for entry in entries.flatten() {
        let folder = entry.path();
        if !entry.file_name().to_string_lossy().starts_with(".uzi-update-") || entry.file_type().map(|t| !t.is_dir() || t.is_symlink()).unwrap_or(true) { continue; }
        if entry.metadata().and_then(|m|m.modified()).ok().and_then(|t|t.elapsed().ok()).is_none_or(|age|age < Duration::from_secs(120)) { continue; }
        let plan = fs::read(folder.join("plan.json")).ok().and_then(|b|serde_json::from_slice::<Plan>(&b).ok());
        if plan.is_some_and(|p|p.target == target && p.ready == folder.join("ready") && p.staged == folder.join("new.exe")) { let _ = fs::remove_dir_all(folder); }
    }
}
fn download(asset: &Asset, path: &Path, progress: impl Fn(u64)) -> Result<(), String> {
    let result = (|| {
        let mut response = client(300)?.get(&asset.browser_download_url).send().map_err(err)?.error_for_status().map_err(err)?;
        let mut file = fs::OpenOptions::new().write(true).create_new(true).open(path).map_err(err)?;
        let mut hash = Sha256::new(); let mut count = 0u64; let mut buffer = [0u8; 64 * 1024];
        let mut last_percent = 101;
        loop {
            let n = response.read(&mut buffer).map_err(err)?; if n == 0 { break; }
            count += n as u64;
            if count > asset.size || count > MAX_BYTES { return Err("Размер обновления не совпал. Текущая программа сохранена.".into()); }
            hash.update(&buffer[..n]); file.write_all(&buffer[..n]).map_err(err)?;
            let percent = count * 100 / asset.size;
            if percent != last_percent { progress(percent); last_percent = percent; }
        }
        file.sync_all().map_err(err)?;
        if count != asset.size || Some(format!("sha256:{:x}", hash.finalize()).as_str()) != asset.digest.as_deref() { return Err("Проверка целостности обновления не пройдена. Повторите скачивание.".into()); }
        let mut header = [0u8;2]; fs::File::open(path).map_err(err)?.read_exact(&mut header).map_err(err)?;
        if header != *b"MZ" { return Err("Скачанный файл не является программой Windows.".into()); }
        Ok(())
    })();
    if result.is_err() { let _ = fs::remove_file(path); } result
}
#[derive(Serialize, Deserialize)]
struct Plan { pid: u32, target: PathBuf, staged: PathBuf, backup: PathBuf, ready: PathBuf }
#[tauri::command]
pub async fn install_update(app: tauri::AppHandle, expected_version: String) -> Result<(), String> {
    tauri::async_runtime::spawn_blocking(move || {
        let _install = INSTALLING.try_lock().map_err(|_| "Обновление уже выполняется".to_string())?;
        if cfg!(debug_assertions) { return Err("Замена EXE доступна только в готовой сборке программы.".into()); }
        app.state::<crate::security::Security>().require(&app.state::<Database>(), crate::security::Permission::Read)?;
        let (next, asset) = latest()?.ok_or("Новая версия больше не доступна.")?;
        if next != expected_version { return Err("Релиз изменился. Перезапустите программу для новой проверки.".into()); }
        let target = std::env::current_exe().map_err(err)?;
        let parent = target.parent().ok_or("Не найдена папка программы")?;
        let id = format!("{}-{}", std::process::id(), chrono::Utc::now().timestamp_millis());
        let folder = parent.join(format!(".uzi-update-{id}"));
        fs::create_dir(&folder).map_err(|_| "Нет разрешения на запись в папку программы.".to_string())?;
        let prepare = (|| {
            let staged = folder.join("new.exe");
            download(&asset, &staged, |percent| { let _ = app.emit("update-progress", percent); })?;
            let _maintenance = crate::maintenance::MAINTENANCE.lock().map_err(err)?;
            app.state::<Database>().update_backup()?;
            let helper = folder.join("helper.exe"); fs::copy(&target, &helper).map_err(err)?;
            let plan = Plan {pid: std::process::id(), target: target.clone(), staged, backup: parent.join(format!("{}.before-update-{id}.bak", target.file_name().unwrap().to_string_lossy())), ready: folder.join("ready")};
            let plan_path = folder.join("plan.json"); fs::write(&plan_path, serde_json::to_vec(&plan).map_err(err)?).map_err(err)?;
            hidden_command(&helper).arg("--uzi-update-helper").arg(&plan_path).spawn().map_err(err)?;
            for _ in 0..100 {
                if plan.ready.exists() { fs::write(folder.join("commit"), b"commit").map_err(err)?; app.exit(0); return Ok(()); }
                std::thread::sleep(Duration::from_millis(50));
            }
            Err("Не удалось запустить замену файла. Текущая программа сохранена.".into())
        })();
        if prepare.is_err() { let _ = fs::remove_dir_all(&folder); } prepare
    }).await.map_err(err)?
}
fn hidden_command(exe: &Path) -> Command {
    let mut command = Command::new(exe);
    #[cfg(windows)] { use std::os::windows::process::CommandExt; command.creation_flags(0x08000000); } command
}
// Run before Tauri/SQLite initialization; the helper must not take the database lock.
pub fn helper_entry() -> bool {
    let args: Vec<_> = std::env::args_os().collect();
    if args.get(1).and_then(|s|s.to_str()) != Some("--uzi-update-helper") { return false; }
    if let Some(path) = args.get(2) {
        let result = (|| {
            let plan: Plan = serde_json::from_slice(&fs::read(path).map_err(err)?).map_err(err)?;
            wait_parent(&plan)?;
            if !plan.ready.with_file_name("commit").exists() { return Ok(()); }
            let result = replace(&plan);
            if let Err(ref error) = result { let _ = fs::write(plan.target.with_extension("update-error.txt"), error); }
            result
        })();
        if let Err(error) = result { eprintln!("Update failed: {error}"); }
    } true
}
#[cfg(windows)]
fn wait_parent(plan: &Plan) -> Result<(), String> {
    use std::ffi::c_void;
    #[link(name="kernel32")]
    extern "system" {
        fn OpenProcess(access: u32, inherit: i32, pid: u32) -> *mut c_void;
        fn WaitForSingleObject(handle: *mut c_void, millis: u32) -> u32;
        fn CloseHandle(handle: *mut c_void) -> i32;
    }
    unsafe {
        let handle = OpenProcess(0x00100000, 0, plan.pid);
        if handle.is_null() { return Err("Не удалось дождаться закрытия программы.".into()); }
        let ready = fs::write(&plan.ready, b"ready").map_err(err);
        let status = if ready.is_ok() { WaitForSingleObject(handle, 60000) } else { u32::MAX };
        CloseHandle(handle); ready?;
        if status != 0 { return Err("Программа не завершилась вовремя. Обновление отменено.".into()); }
    } Ok(())
}
#[cfg(not(windows))]
fn wait_parent(_: &Plan) -> Result<(), String> { Err("Обновление поддерживается только в Windows.".into()) }
fn replace(plan: &Plan) -> Result<(), String> {
    // Antivirus may briefly hold the executable after the parent exits.
    let mut moved = false;
    for _ in 0..100 {
        if fs::rename(&plan.target, &plan.backup).is_ok() { moved = true; break; }
        std::thread::sleep(Duration::from_millis(100));
    }
    if !moved { let _ = hidden_command(&plan.target).spawn(); return Err("Не удалось заменить EXE. Прежний файл сохранён.".into()); }
    if let Err(error) = fs::rename(&plan.staged, &plan.target) {
        fs::rename(&plan.backup, &plan.target).map_err(err)?; let _ = hidden_command(&plan.target).spawn(); return Err(err(error));
    }
    if let Err(error) = hidden_command(&plan.target).spawn() {
        fs::rename(&plan.target, &plan.staged).map_err(err)?; fs::rename(&plan.backup, &plan.target).map_err(err)?;
        let _ = hidden_command(&plan.target).spawn(); return Err(err(error));
    } Ok(())
}
#[cfg(test)]
mod tests {
    use super::*;
    fn release(tag: &str) -> Release { Release {tag_name: tag.into(),draft:false,prerelease:false,assets:vec![Asset {name:"Кабинет УЗИ.exe".into(),browser_download_url:format!("{PREFIX}{tag}/app.exe"),size:123,digest:Some(format!("sha256:{}", "a".repeat(64)))}]} }
    #[test] fn compares_versions_numerically() {
        assert!(select(release("v0.10.0"), "0.9.0").unwrap().is_some());
        assert!(select(release("v0.1.0"), "0.1.0").unwrap().is_none());
        assert!(select(release("v0.0.9"), "0.1.0").unwrap().is_none());
        assert!(select(release("v1.2"), "0.1.0").unwrap().is_some());
        assert!(select(release("v2.0.0-beta.1"), "0.1.0").unwrap().is_none());
    }
    #[test] fn rejects_ambiguous_or_unverified_assets() {
        let mut r=release("v1.2.0"); r.assets.push(r.assets[0].clone()); assert!(select(r,"0.1.0").is_err());
        let mut r=release("v1.2.0"); r.assets[0].digest=None; assert!(select(r,"0.1.0").is_err());
        let mut r=release("v1.2.0"); r.assets[0].browser_download_url="https://example.com/app.exe".into(); assert!(select(r,"0.1.0").is_err());
    }
    #[test] fn failed_replacement_restores_original() {
        let folder=std::env::temp_dir().join(format!("uzi-update-test-{}",std::process::id())); fs::create_dir_all(&folder).unwrap();
        let target=folder.join("original.exe"); fs::write(&target,b"original").unwrap();
        let plan=Plan{pid:0,target:target.clone(),staged:folder.join("missing.exe"),backup:folder.join("old.bak"),ready:folder.join("ready")};
        assert!(replace(&plan).is_err()); assert_eq!(fs::read(&target).unwrap(),b"original"); assert!(!plan.backup.exists());
        fs::write(&plan.staged,b"invalid executable").unwrap();
        assert!(replace(&plan).is_err()); assert_eq!(fs::read(&target).unwrap(),b"original"); assert!(!plan.backup.exists());
        fs::remove_dir_all(folder).unwrap();
    }
}
