#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]
mod repository;
mod maintenance;
mod security;
mod records;
mod template_tree;
mod catalog_settings;
mod form_revisions;
mod lifecycle;
mod doctors;
mod reports;
mod decisions;
mod instance;
mod updater;
use updater::{check_update,install_update};
use repository::{Database,PatientInput,StudyInput,err};
use security::{Security,Permission,AccountInput,User,ActorScope};
use serde_json::{Value,json};
use tauri::{State,Manager};
use tauri_plugin_dialog::DialogExt;

fn read<T>(db:&Database,s:&Security,f:impl FnOnce()->Result<T,String>)->Result<T,String>{s.require(db,Permission::Read)?;f()}
fn write<T>(db:&Database,s:&Security,permission:Permission,f:impl FnOnce(User)->Result<T,String>)->Result<T,String>{s.require(db,permission)?;db.automatic_backup()?;let _lock=maintenance::MAINTENANCE.lock().map_err(err)?;let user=s.require(db,permission)?;let _actor=ActorScope::new(user.id);f(user)}
fn own_study(db:&Database,user:&User,id:i64)->Result<(),String>{if user.role=="doctor"{let study=db.study(id)?;if study["origin"]!="legacy"&&study["doctor_id"].as_i64()!=user.doctor_id{return Err("Врач может изменять только свои исследования.".into())}}Ok(())}
#[tauri::command]async fn auth_status(db:State<'_,Database>,s:State<'_,Security>)->Result<Value,String>{db.ensure_schema()?;s.status(&db)}
#[tauri::command]async fn setup_admin(db:State<'_,Database>,s:State<'_,Security>,input:AccountInput)->Result<User,String>{db.ensure_schema()?;let _lock=maintenance::MAINTENANCE.lock().map_err(err)?;s.setup(&db,input)}
#[tauri::command]async fn auth_login(db:State<'_,Database>,s:State<'_,Security>,username:String,password:String)->Result<User,String>{let _lock=maintenance::MAINTENANCE.lock().map_err(err)?;s.login(&db,&username,&password)}
#[tauri::command]async fn auth_logout(s:State<'_,Security>)->Result<(),String>{s.logout();Ok(())}
#[tauri::command]async fn list_users(db:State<'_,Database>,s:State<'_,Security>)->Result<Value,String>{s.require(&db,Permission::Admin)?;db.users()}
#[tauri::command]async fn save_user(db:State<'_,Database>,s:State<'_,Security>,input:AccountInput)->Result<i64,String>{write(&db,&s,Permission::Admin,|u|db.save_account(input,u.id))}
#[tauri::command]async fn change_password(db:State<'_,Database>,s:State<'_,Security>,old_password:String,new_password:String)->Result<(),String>{let u=s.require(&db,Permission::Read)?;db.automatic_backup()?;let _lock=maintenance::MAINTENANCE.lock().map_err(err)?;db.change_password(u.id,&old_password,&new_password)?;s.logout();Ok(())}
#[tauri::command]async fn database_info(db:State<'_,Database>,s:State<'_,Security>)->Result<Value,String>{read(&db,&s,||db.info())}
#[tauri::command]async fn list_patients(db:State<'_,Database>,s:State<'_,Security>,query:String,gender:String,page:i64,page_size:i64,sort:Option<String>,direction:Option<String>)->Result<Value,String>{let sort=sort.as_deref().unwrap_or("lastStudy");let direction=direction.as_deref().unwrap_or(if sort=="lastStudy"{"desc"}else{"asc"});read(&db,&s,||db.patients(&query,&gender,page,page_size,sort,direction))}
#[tauri::command]async fn patient_detail(db:State<'_,Database>,s:State<'_,Security>,id:i64)->Result<Value,String>{read(&db,&s,||db.patient(id))}
#[tauri::command]async fn mutate_template_tree(db:State<'_,Database>,s:State<'_,Security>,input:template_tree::TreeInput)->Result<Value,String>{write(&db,&s,Permission::Write,|_|db.mutate_template_tree(input))}
#[tauri::command]async fn create_user_template(db:State<'_,Database>,s:State<'_,Security>,template_id:i64,parent_id:i64,text:String)->Result<Value,String>{write(&db,&s,Permission::Write,|_|db.create_user_template(template_id,parent_id,&text))}
#[tauri::command]async fn save_user_template(db:State<'_,Database>,s:State<'_,Security>,id:i64,revision:i64,text:String,deleted:bool)->Result<Value,String>{write(&db,&s,Permission::Write,|_|db.save_user_template(id,revision,&text,deleted))}
#[tauri::command]async fn sync_catalog_sections(db:State<'_,Database>,s:State<'_,Security>)->Result<(),String>{write(&db,&s,Permission::Admin,|_|db.sync_catalog_sections())}
#[tauri::command]async fn catalog_settings(db:State<'_,Database>,s:State<'_,Security>)->Result<Value,String>{s.require(&db,Permission::Admin)?;db.catalog_settings()}
#[tauri::command]async fn save_catalog_settings(db:State<'_,Database>,s:State<'_,Security>,input:catalog_settings::CatalogInput)->Result<Value,String>{write(&db,&s,Permission::Admin,|_|db.save_catalog_settings(input))}
#[tauri::command]async fn user_templates(db:State<'_,Database>,s:State<'_,Security>)->Result<Value,String>{read(&db,&s,||db.user_templates())}
#[tauri::command]async fn study_detail(db:State<'_,Database>,s:State<'_,Security>,id:i64)->Result<Value,String>{read(&db,&s,||db.study(id))}
#[tauri::command]async fn save_patient(db:State<'_,Database>,s:State<'_,Security>,input:PatientInput)->Result<i64,String>{write(&db,&s,Permission::Write,|_|db.save_patient(input))}
#[tauri::command]async fn save_study(db:State<'_,Database>,s:State<'_,Security>,input:StudyInput)->Result<i64,String>{write(&db,&s,Permission::Write,|u|{let legacy=if let Some(id)=input.id{db.study(id)?["origin"]=="legacy"}else{false};if u.role=="doctor"&&!legacy&&u.doctor_id!=Some(input.doctor_id){return Err("Вы можете сохранять исследования только от своего имени.".into())}if let Some(id)=input.id{own_study(&db,&u,id)?}db.save_study(input)})}
#[tauri::command]async fn list_studies(db:State<'_,Database>,s:State<'_,Security>,query:String,page:i64,page_size:i64,status:Option<String>)->Result<Value,String>{read(&db,&s,||db.studies_filtered(&query,page,page_size,status.as_deref().unwrap_or("active")))}
#[tauri::command]async fn set_study_deleted(db:State<'_,Database>,s:State<'_,Security>,id:i64,revision:i64,deleted:bool)->Result<(),String>{write(&db,&s,Permission::Write,|u|{let study=db.study(id)?;if u.role=="doctor"&&study["doctor_id"].as_i64()!=u.doctor_id{return Err("Врач может удалять и восстанавливать только свои исследования.".into())}db.set_study_deleted(id,revision,deleted)})}
#[tauri::command]async fn set_bundle_deleted(db:State<'_,Database>,s:State<'_,Security>,id:i64,revision:i64,deleted:bool)->Result<(),String>{write(&db,&s,Permission::Write,|u|{let detail=db.bundle(id)?;if u.role=="doctor"&&detail["bundle"]["actor_id"]!=u.id{return Err("Врач может удалять и восстанавливать только созданные им комплекты.".into())}db.set_bundle_deleted(id,revision,deleted)})}
#[tauri::command]async fn validate_bundle_print(db:State<'_,Database>,s:State<'_,Security>,id:i64,revision:i64,expected:Vec<[i64;2]>)->Result<(),String>{read(&db,&s,||db.validate_bundle_print(id,revision,expected))}

#[tauri::command]async fn create_backup(db:State<'_,Database>,s:State<'_,Security>)->Result<String,String>{s.require(&db,Permission::Admin)?;let _lock=maintenance::MAINTENANCE.lock().map_err(err)?;db.backup()}
#[tauri::command]async fn list_backups(db:State<'_,Database>,s:State<'_,Security>)->Result<Value,String>{s.require(&db,Permission::Admin)?;db.backups()}
#[tauri::command]async fn restore_backup(db:State<'_,Database>,s:State<'_,Security>,name:String,password:String)->Result<Value,String>{let user=s.require(&db,Permission::Admin)?;s.login(&db,&user.username,&password)?;s.require(&db,Permission::Admin)?;s.logout();match db.restore_backup(&name,user.id){Ok(safety)=>{s.logout();Ok(json!({"safetyCopy":safety}))},Err(e)=>Err(format!("AUTH_REQUIRED: Восстановление не выполнено: {e}"))}}
#[tauri::command]async fn import_backup(db:State<'_,Database>,s:State<'_,Security>,path:String)->Result<String,String>{s.require(&db,Permission::Admin)?;db.import_backup(&path)}
#[tauri::command]async fn list_audit(db:State<'_,Database>,s:State<'_,Security>)->Result<Value,String>{s.require(&db,Permission::Admin)?;db.audit_log()}
#[tauri::command]async fn hidden_patients(db:State<'_,Database>,s:State<'_,Security>)->Result<Value,String>{s.require(&db,Permission::Admin)?;db.hidden_patients()}
#[tauri::command]async fn set_patient_hidden(db:State<'_,Database>,s:State<'_,Security>,id:i64,revision:i64,hidden:bool)->Result<(),String>{write(&db,&s,Permission::Admin,|u|db.set_patient_hidden(id,revision,hidden,u.id))}
#[tauri::command]async fn decision_options(db:State<'_,Database>,s:State<'_,Security>)->Result<Value,String>{read(&db,&s,||db.decision_options())}
#[tauri::command]async fn statistics_options(db:State<'_,Database>,s:State<'_,Security>)->Result<Value,String>{read(&db,&s,||db.statistics_options())}
#[tauri::command]async fn statistics(db:State<'_,Database>,s:State<'_,Security>,from:String,to:String,filters:Option<reports::ReportFilter>)->Result<Value,String>{read(&db,&s,||db.statistics_filtered(&from,&to,&filters.unwrap_or_default()))}
#[tauri::command]async fn statistics_details(db:State<'_,Database>,s:State<'_,Security>,from:String,to:String,filters:Option<reports::ReportFilter>,page:i64,page_size:i64)->Result<Value,String>{read(&db,&s,||db.statistics_details(&from,&to,&filters.unwrap_or_default(),page,page_size))}
#[tauri::command]async fn export_statistics(db:State<'_,Database>,s:State<'_,Security>,path:String,from:String,to:String,filters:Option<reports::ReportFilter>)->Result<(),String>{read(&db,&s,||db.export_statistics_filtered(&path,&from,&to,&filters.unwrap_or_default()))}
#[tauri::command]async fn export_statistics_details(db:State<'_,Database>,s:State<'_,Security>,path:String,from:String,to:String,filters:Option<reports::ReportFilter>)->Result<(),String>{read(&db,&s,||db.export_statistics_details(&path,&from,&to,&filters.unwrap_or_default()))}
#[tauri::command]async fn create_bundle(db:State<'_,Database>,s:State<'_,Security>,patient_id:i64,name:String,ids:Vec<i64>)->Result<i64,String>{write(&db,&s,Permission::Write,|u|db.create_bundle(patient_id,&name,ids,u.id))}
#[tauri::command]async fn patient_bundles(db:State<'_,Database>,s:State<'_,Security>,patient_id:i64)->Result<Value,String>{read(&db,&s,||db.patient_bundles(patient_id))}
#[tauri::command]async fn bundle_detail(db:State<'_,Database>,s:State<'_,Security>,id:i64)->Result<Value,String>{read(&db,&s,||db.bundle(id))}
#[tauri::command]async fn list_attachments(db:State<'_,Database>,s:State<'_,Security>,study_id:i64)->Result<Value,String>{read(&db,&s,||db.attachments(study_id))}
#[tauri::command]async fn import_attachment(db:State<'_,Database>,s:State<'_,Security>,study_id:i64,path:String)->Result<i64,String>{write(&db,&s,Permission::Write,|u|{own_study(&db,&u,study_id)?;db.import_attachment(study_id,&path,u.id)})}
#[tauri::command]async fn remove_attachment(db:State<'_,Database>,s:State<'_,Security>,id:i64)->Result<(),String>{write(&db,&s,Permission::Write,|u|{own_study(&db,&u,db.attachment_study(id)?)?;db.remove_attachment(id,u.id)})}
#[tauri::command]async fn export_attachment(db:State<'_,Database>,s:State<'_,Security>,id:i64,path:String)->Result<(),String>{read(&db,&s,||db.export_attachment(id,&path))}
#[tauri::command]async fn list_doctors(db:State<'_,Database>,s:State<'_,Security>)->Result<Value,String>{s.require(&db,Permission::Admin)?;db.doctors()}
#[tauri::command]async fn save_doctor(db:State<'_,Database>,s:State<'_,Security>,name:String,id:Option<i64>,revision:Option<i64>,hidden:Option<bool>)->Result<i64,String>{write(&db,&s,Permission::Admin,|_|db.save_doctor(id,revision,&name,hidden.unwrap_or(false)))}


fn main(){
 if updater::helper_entry(){return}
 let path=if cfg!(debug_assertions){std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("../data/uzi.db")}else{std::env::current_exe().expect("Application path").with_file_name("uzi.db")};
 tauri::Builder::default().plugin(tauri_plugin_dialog::init()).manage(Database::new(path)).manage(Security::default())
 .setup(|app|{let db=app.state::<Database>();match instance::DatabaseLock::acquire(&db.path){Ok(lock)=>{app.manage(lock);Ok(())},Err(e)=>{app.dialog().message("Не удалось открыть папку базы для работы. Возможно, эта база уже открыта в другом окне. Закройте прежнюю программу и проверьте права на папку.").title("Кабинет УЗИ").blocking_show();Err(e.into())}}})
 .register_uri_scheme_protocol("uzi-media",|context,request|{
  let app=context.app_handle();let db=app.state::<Database>();let security=app.state::<Security>();
  let result=(||{security.require(&db,Permission::Read)?;let id=request.uri().path().trim_start_matches('/').parse::<i64>().map_err(err)?;db.attachment_response(id,request.headers().get("range").and_then(|h|h.to_str().ok()))})();
  match result{Ok((body,mime,status,range,total))=>{let mut response=tauri::http::Response::builder().status(status).header("Content-Type",mime).header("Accept-Ranges","bytes").header("Cache-Control","no-store").header("X-Content-Type-Options","nosniff").header("Access-Control-Allow-Origin","http://tauri.localhost").header("Content-Length",body.len());if let Some(range)=range{response=response.header("Content-Range",range)}else{let _=total;}response.body(body).unwrap()},Err(_)=>tauri::http::Response::builder().status(403).header("Cache-Control","no-store").body(Vec::new()).unwrap()}
 })
 .invoke_handler(tauri::generate_handler![check_update,install_update,auth_status,setup_admin,auth_login,auth_logout,list_users,save_user,change_password,database_info,sync_catalog_sections,catalog_settings,save_catalog_settings,list_patients,patient_detail,study_detail,user_templates,mutate_template_tree,create_user_template,save_user_template,save_patient,save_study,list_studies,set_study_deleted,set_bundle_deleted,validate_bundle_print,create_backup,list_backups,restore_backup,import_backup,list_audit,hidden_patients,set_patient_hidden,decision_options,statistics_options,statistics,statistics_details,export_statistics,export_statistics_details,create_bundle,patient_bundles,bundle_detail,list_attachments,import_attachment,remove_attachment,export_attachment,list_doctors,save_doctor])
 .run(tauri::generate_context!()).expect("Unable to start application");
}

