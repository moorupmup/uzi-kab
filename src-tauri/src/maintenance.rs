use crate::repository::{Database,err,rows};
use rusqlite::{Connection,OpenFlags,OptionalExtension,params};
use serde_json::{Value,json};
use std::{path::{Path,Component},sync::Mutex};

pub static MAINTENANCE:Mutex<()>=Mutex::new(());
impl Database {
    pub fn ensure_schema(&self)->Result<(),String>{
        let _lock=MAINTENANCE.lock().map_err(err)?;
        let c=self.open()?;
        let version:i64=c.pragma_query_value(None,"user_version",|r|r.get(0)).map_err(err)?;
        if version==1{
            // The first upgrade is reversible before any feature tables are created.
            self.backup_named(&format!("before-upgrade-{}.db",chrono::Local::now().format("%Y%m%d-%H%M%S-%f")))?;
            let tx=c.unchecked_transaction().map_err(err)?;
            tx.execute_batch(include_str!("../extended.sql")).map_err(err)?;
            tx.pragma_update(None,"user_version",2).map_err(err)?;tx.commit().map_err(err)?;
        }
        self.cleanup_empty_orphans(&c)?;
        Ok(())
    }
    fn cleanup_empty_orphans(&self,c:&Connection)->Result<(),String>{
        let done:Option<String>=c.query_row("SELECT value FROM metadata WHERE key='empty_orphan_cleanup_v1'",[],|r|r.get(0)).optional().map_err(err)?;
        if done.is_some(){return Ok(())}
        // Retain the exclusive lock across the verified snapshot and deletion.
        c.pragma_update(None,"locking_mode","EXCLUSIVE").map_err(err)?;
        c.execute_batch("BEGIN EXCLUSIVE; COMMIT;").map_err(err)?;
        let ids=c.prepare(include_str!("../empty-orphan-candidates.sql")).map_err(err)?.query_map([],|r|r.get::<_,i64>(0)).map_err(err)?.collect::<Result<Vec<_>,_>>().map_err(err)?;
        let backup=if ids.is_empty(){None}else{Some(self.backup_from(c,&format!("before-empty-cleanup-{}.db",chrono::Local::now().format("%Y%m%d-%H%M%S-%f")))?)};
        let report=json!({"removed":ids.len(),"backup":backup,"date":chrono::Utc::now().to_rfc3339()});
        let tx=c.unchecked_transaction().map_err(err)?;
        for id in &ids{tx.execute("DELETE FROM studies WHERE id=?",[id]).map_err(err)?;}
        tx.execute("INSERT INTO metadata(key,value) VALUES('empty_orphan_cleanup_v1',?)",[report.to_string()]).map_err(err)?;
        if !ids.is_empty(){tx.execute("INSERT INTO access_audit(action,details) VALUES('cleanup_empty_orphans',?)",[report.to_string()]).map_err(err)?;}
        tx.commit().map_err(err)?;Ok(())
    }
    fn backup_folder(&self)->Result<std::path::PathBuf,String>{let p=self.path.parent().ok_or("Папка базы не найдена")?.join("backups");std::fs::create_dir_all(&p).map_err(err)?;Ok(p)}
    fn backup_named(&self,name:&str)->Result<String,String>{
        let c=self.open()?;self.backup_from(&c,name)
    }
    fn backup_from(&self,c:&Connection,name:&str)->Result<String,String>{
        let path=self.backup_folder()?.join(name);let temporary=path.with_extension("pending");
        if path.exists()||temporary.exists(){return Err("Файл резервной копии уже существует".into())}
        c.backup("main",&temporary,None).map_err(err)?;
        Self::validate_backup(&temporary)?;
        std::fs::rename(&temporary,&path).map_err(err)?;
        Ok(path.to_string_lossy().into_owned())
    }
    fn validate_backup(path:&Path)->Result<(),String>{
        let c=Connection::open_with_flags(path,OpenFlags::SQLITE_OPEN_READ_ONLY).map_err(err)?;
        c.pragma_update(None,"trusted_schema","OFF").map_err(err)?;
        let active_schema:i64=c.query_row("SELECT count(*) FROM sqlite_master WHERE type IN('trigger','view')",[],|r|r.get(0)).map_err(err)?;if active_schema!=0{return Err("Копия содержит неподдерживаемые триггеры или представления".into())}
        let integrity:String=c.query_row("PRAGMA integrity_check",[],|r|r.get(0)).map_err(err)?;
        let version:i64=c.pragma_query_value(None,"user_version",|r|r.get(0)).map_err(err)?;
        if integrity!="ok"||![1,2].contains(&version){return Err("Копия повреждена или имеет неподдерживаемый формат".into())}
        c.prepare("SELECT p.id,p.name,s.id,s.fields_json,s.legacy_version FROM patients p LEFT JOIN studies s ON s.patient_id=p.id LIMIT 0").map_err(|_|"Файл не является базой Кабинета УЗИ".to_string())?;
        c.prepare("SELECT key,value FROM metadata LIMIT 0").map_err(err)?;
        Ok(())
    }
    pub fn automatic_backup(&self)->Result<(),String>{
        let _lock=MAINTENANCE.lock().map_err(err)?;
        let name=format!("auto-{}.db",chrono::Local::now().format("%Y-%m-%d"));
        if !self.backup_folder()?.join(&name).exists(){self.backup_named(&name).map_err(|e|format!("Не удалось создать ежедневную копию. Сохранение отменено: {e}"))?;}
        Ok(())
    }
    pub fn backups(&self)->Result<Value,String>{
        let mut result=Vec::new();
        for entry in std::fs::read_dir(self.backup_folder()?).map_err(err)?{
            let entry=entry.map_err(err)?;let path=entry.path();
            if path.extension().and_then(|s|s.to_str())!=Some("db")||!path.is_file(){continue}
            let meta=entry.metadata().map_err(err)?;
            result.push(json!({"name":entry.file_name().to_string_lossy(),"bytes":meta.len(),"modified":meta.modified().ok().map(chrono::DateTime::<chrono::Utc>::from).map(|t|t.to_rfc3339())}));
        }
        result.sort_by(|a,b|b["modified"].as_str().cmp(&a["modified"].as_str()));Ok(json!(result))
    }
    pub fn import_backup(&self,path:&str)->Result<String,String>{
        let _lock=MAINTENANCE.lock().map_err(err)?;let source_path=Path::new(path);Self::validate_backup(source_path)?;
        let name=format!("imported-{}.db",chrono::Local::now().format("%Y%m%d-%H%M%S-%f"));let target=self.backup_folder()?.join(&name);let pending=target.with_extension("pending");
        let source=Connection::open_with_flags(source_path,OpenFlags::SQLITE_OPEN_READ_ONLY).map_err(err)?;source.backup("main",&pending,None).map_err(err)?;Self::validate_backup(&pending)?;std::fs::rename(pending,target).map_err(err)?;Ok(name)
    }
    pub fn restore_backup(&self,name:&str,actor:i64)->Result<String,String>{
        let _lock=MAINTENANCE.lock().map_err(err)?;
        let components=Path::new(name).components().collect::<Vec<_>>();
        if components.len()!=1||!matches!(components[0],Component::Normal(_))||name.contains(['/', '\\'])||!name.ends_with(".db"){return Err("Недопустимое имя копии".into())}
        let folder=self.backup_folder()?.canonicalize().map_err(err)?;let path=folder.join(name).canonicalize().map_err(err)?;
        if !path.starts_with(&folder){return Err("Копия должна находиться в папке backups".into())}
        Self::validate_backup(&path)?;
        let source=Connection::open_with_flags(&path,OpenFlags::SQLITE_OPEN_READ_ONLY).map_err(err)?;
        let mut destination=self.open()?;
        destination.pragma_update(None,"locking_mode","EXCLUSIVE").map_err(err)?;
        destination.execute_batch("BEGIN EXCLUSIVE; COMMIT;").map_err(err)?;
        let safety=self.backup_from(&destination,&format!("before-restore-{}.db",chrono::Local::now().format("%Y%m%d-%H%M%S-%f")))?;
        {let backup=rusqlite::backup::Backup::new(&source,&mut destination).map_err(err)?;backup.run_to_completion(256,std::time::Duration::from_millis(10),None).map_err(err)?;}
        destination.execute_batch(include_str!("../extended.sql")).map_err(err)?;
        destination.pragma_update(None,"user_version",2).map_err(err)?;
        destination.execute("INSERT INTO access_audit(actor_id,action,details) VALUES(?,'restore',?)",params![actor,name]).map_err(err)?;
        Ok(safety)
    }
    pub fn audit_event(&self,actor:i64,action:&str,entity:Option<i64>,details:&str)->Result<(),String>{
        self.open()?.execute("INSERT INTO access_audit(actor_id,action,entity_id,details) VALUES(?,?,?,?)",params![actor,action,entity,details]).map_err(err)?;Ok(())
    }
    pub fn audit_log(&self)->Result<Value,String>{Ok(json!(rows(&self.open()?,"SELECT a.id,a.action,a.entity_id AS entityId,a.details,a.created_at AS createdAt,u.display_name AS actor FROM access_audit a LEFT JOIN app_users u ON u.id=a.actor_id ORDER BY a.id DESC LIMIT 300",[])?))}
}

#[cfg(test)]
mod tests{
    use super::*;
    fn cleanup_fixture()->Database{
        let folder=std::env::temp_dir().join(format!("uzi-cleanup-{}-{}",std::process::id(),chrono::Utc::now().timestamp_nanos_opt().unwrap()));std::fs::create_dir_all(&folder).unwrap();let db=Database::new(folder.join("uzi.db"));let c=Connection::open(&db.path).unwrap();c.execute_batch(include_str!("../schema.sql")).unwrap();c.execute_batch(include_str!("../extended.sql")).unwrap();c.execute_batch("PRAGMA foreign_keys=OFF;PRAGMA user_version=2;CREATE TABLE legacy_protocol(id INTEGER,var_part TEXT);INSERT INTO legacy_protocol VALUES(1,'original empty form');INSERT INTO patients(id,name,search_name,gender) VALUES(1,'Synthetic','synthetic','M');INSERT INTO studies(id,patient_id,date,template_id,doctor_id,title,conclusion,addition,fields_json,origin,status) VALUES(1,0,'2001-01-01',0,1,'Empty','','','{}','legacy','legacy:0');").unwrap();drop(c);db
    }
    #[test]fn cleanup_removes_only_untouched_empty_stubs_and_keeps_a_verified_copy(){
        let db=cleanup_fixture();let c=db.open().unwrap();c.pragma_update(None,"foreign_keys","OFF").unwrap();
        for id in 2..=19{c.execute("INSERT INTO studies(id,patient_id,date,template_id,doctor_id,title,conclusion,addition,fields_json,origin,status) VALUES(?,0,'2001-01-01',0,1,'Stub','','','{}','legacy','legacy:0')",[id]).unwrap();}
        for (id,fields) in [(2,r#"{"f":{"value":"clinical","type":"text"}}"#),(3,r#"{"f":{"value":"0"}}"#),(4,"[]"),(5,"bad-json"),(6,r#"{"f":{"type":"text"}}"#),(15,r#"{"f":{"value":" "}}"#),(18,r#"{"f":{"value":null}}"#),(19,r#"{"description":{"value":"","type":"text"}}"#)]{c.execute("UPDATE studies SET fields_json=? WHERE id=?",params![fields,id]).unwrap();}
        c.execute_batch("UPDATE studies SET conclusion='Content' WHERE id=7;UPDATE studies SET addition='Content' WHERE id=8;UPDATE studies SET revision=2 WHERE id=10;UPDATE studies SET status='draft' WHERE id=11;UPDATE studies SET patient_id=1 WHERE id=12;UPDATE studies SET template_id=1 WHERE id=13;INSERT INTO attachments(study_id,name,mime,content,sha256) VALUES(9,'test','image/png',X'00','test'),(17,'removed','image/png',X'00','test');UPDATE attachments SET deleted=1 WHERE study_id=17;INSERT INTO audit(entity,entity_id,saved_at) VALUES('study',14,'2001-01-01');INSERT INTO study_bundles(id,patient_id,name) VALUES(1,1,'Protected');INSERT INTO bundle_items VALUES(1,16,0);").unwrap();drop(c);
        db.ensure_schema().unwrap();db.ensure_schema().unwrap();let c=db.open().unwrap();assert_eq!(c.query_row("SELECT count(*) FROM studies",[],|r|r.get::<_,i64>(0)).unwrap(),17);assert_eq!(c.query_row("SELECT count(*) FROM studies WHERE id IN(1,19)",[],|r|r.get::<_,i64>(0)).unwrap(),0);assert_eq!(c.query_row("SELECT var_part FROM legacy_protocol WHERE id=1",[],|r|r.get::<_,String>(0)).unwrap(),"original empty form");let report:String=c.query_row("SELECT value FROM metadata WHERE key='empty_orphan_cleanup_v1'",[],|r|r.get(0)).unwrap();let report:Value=serde_json::from_str(&report).unwrap();assert_eq!(report["removed"],2);let backup=Connection::open(report["backup"].as_str().unwrap()).unwrap();assert_eq!(backup.query_row("SELECT count(*) FROM studies",[],|r|r.get::<_,i64>(0)).unwrap(),19);assert_eq!(db.backups().unwrap().as_array().unwrap().len(),1);drop(backup);drop(c);std::fs::remove_dir_all(db.path.parent().unwrap()).unwrap();
    }
    #[test]fn cleanup_does_not_delete_without_a_backup(){
        let db=cleanup_fixture();std::fs::write(db.path.parent().unwrap().join("backups"),"blocked path").unwrap();assert!(db.ensure_schema().is_err());let c=db.open().unwrap();assert_eq!(c.query_row("SELECT count(*) FROM studies",[],|r|r.get::<_,i64>(0)).unwrap(),1);assert_eq!(c.query_row("SELECT count(*) FROM metadata WHERE key='empty_orphan_cleanup_v1'",[],|r|r.get::<_,i64>(0)).unwrap(),0);drop(c);std::fs::remove_dir_all(db.path.parent().unwrap()).unwrap();
    }
    #[test]fn restore_keeps_a_safety_copy_and_rejects_traversal(){
        let root=std::env::temp_dir().join(format!("uzi-restore-{}",std::process::id()));std::fs::create_dir_all(&root).unwrap();let db=Database::new(root.join("uzi.db"));let c=Connection::open(&db.path).unwrap();c.execute_batch(include_str!("../schema.sql")).unwrap();c.execute_batch("PRAGMA user_version=1;INSERT INTO patients(id,name,search_name,gender) VALUES(1,'Test','test','M');").unwrap();drop(c);db.ensure_schema().unwrap();let p=db.backup_named("test.db").unwrap();db.open().unwrap().execute("UPDATE patients SET name='Changed'",[]).unwrap();assert!(db.restore_backup("../test.db",1).is_err());let safety=db.restore_backup(Path::new(&p).file_name().unwrap().to_str().unwrap(),1).unwrap();assert!(Path::new(&safety).exists());assert_eq!(db.open().unwrap().query_row("SELECT name FROM patients",[],|r|r.get::<_,String>(0)).unwrap(),"Test");std::fs::remove_dir_all(root).unwrap();
    }
}
