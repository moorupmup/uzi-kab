use rusqlite::{params, Connection, OpenFlags};
use serde::Deserialize;
use serde_json::{json,Value};
use std::{path::PathBuf, time::Duration};

pub struct Database { pub(crate) path: PathBuf }
#[derive(Deserialize)]
#[serde(rename_all="camelCase")]
pub struct PatientInput { pub id: Option<i64>, pub revision: Option<i64>, pub name: String, pub gender: String, pub birthdate: String, pub city: String, pub street: String, pub house: String, pub flat: String }
#[derive(Deserialize)]
#[serde(rename_all="camelCase")]
pub struct StudyInput { pub id: Option<i64>, pub revision: Option<i64>, pub patient_id:i64, pub template_id:i64, pub doctor_id:i64, pub date:String, pub conclusion:String, pub addition:String, pub fields:Value, pub status:String, pub template_version:Option<String> }

pub(crate) fn err(e: impl std::fmt::Display)->String { e.to_string() }
fn search(s:&str)->String { s.trim().to_lowercase().replace('ё',"е") }
fn like(s:&str)->String { format!("%{}%", search(s).replace('\\',"\\\\").replace('%',"\\%").replace('_',"\\_")) }
fn valid_date(s:&str)->bool { chrono::NaiveDate::parse_from_str(s,"%Y-%m-%d").is_ok() }
pub(crate) fn rows(c:&Connection, sql:&str, args:impl rusqlite::Params)->Result<Vec<Value>,String> {
    let mut st=c.prepare(sql).map_err(err)?;
    let names=st.column_names().iter().map(|s|s.to_string()).collect::<Vec<_>>();
    let result=st.query_map(args,|r| {
        let mut obj=serde_json::Map::new();
        for (i,name) in names.iter().enumerate() {
            use rusqlite::types::ValueRef;
            let v=match r.get_ref(i)? { ValueRef::Null=>Value::Null,ValueRef::Integer(n)=>json!(n),ValueRef::Real(n)=>json!(n),ValueRef::Text(s)=>json!(String::from_utf8_lossy(s)),ValueRef::Blob(_)=>Value::Null };
            obj.insert(name.clone(),v);
        }
        Ok(Value::Object(obj))
    }).map_err(err)?.collect::<Result<Vec<_>,_>>().map_err(err)?;
    Ok(result)
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::sync::atomic::{AtomicU64,Ordering};
    static NEXT:AtomicU64=AtomicU64::new(0);
    fn fixture()->Database {
        let folder=std::env::temp_dir().join(format!("uzi-test-{}-{}",std::process::id(),NEXT.fetch_add(1,Ordering::Relaxed)));
        std::fs::create_dir_all(&folder).unwrap();
        let db=Database::new(folder.join("uzi.db"));
        let c=Connection::open(&db.path).unwrap();
        c.execute_batch(include_str!("../schema.sql")).unwrap();
        c.execute_batch("PRAGMA user_version=1; INSERT INTO doctors VALUES(1,'Тестовый врач',0); INSERT INTO templates VALUES(1,'Тестовый протокол','test'); INSERT INTO patients(id,name,search_name,gender,birthdate) VALUES(1,'Тест Ёлкин','тест елкин','M','2000-01-01');").unwrap();
        db
    }
    fn study()->StudyInput { StudyInput{id:None,revision:None,patient_id:1,template_id:1,doctor_id:1,date:"2026-11-06".into(),conclusion:"Тестовое заключение".into(),addition:"".into(),fields:json!({"description":{"value":"Тестовый текст","type":"text"}}),status:"draft".into(),template_version:Some("1".into())} }
    fn clean(db:Database){std::fs::remove_dir_all(db.path.parent().unwrap()).unwrap()}
    #[test] fn cyrillic_search_and_wildcards_are_literal(){let db=fixture();assert_eq!(db.patients("ЁЛКИН","",0,30,"name","asc").unwrap()["total"],1);assert_eq!(db.patients("%","",0,30,"name","asc").unwrap()["total"],0);clean(db)}
    #[test] fn study_roundtrip_and_stale_revision(){let db=fixture();let id=db.save_study(study()).unwrap();let saved=db.study(id).unwrap();assert_eq!(saved["fields"]["description"]["value"],"Тестовый текст");assert_eq!(saved["legacy_version"],"1");let mut update=study();update.id=Some(id);update.revision=Some(0);assert!(db.save_study(update).is_err());assert_eq!(db.study(id).unwrap()["revision"],1);clean(db)}
    #[test] fn archive_edit_keeps_previous_values_and_new_study_requires_patient(){let db=fixture();let id=db.save_study(study()).unwrap();db.open().unwrap().execute("UPDATE studies SET origin='legacy' WHERE id=?",[id]).unwrap();let mut edit=study();edit.id=Some(id);edit.revision=Some(1);edit.conclusion="Исправленное заключение".into();db.save_study(edit).unwrap();let saved=db.study(id).unwrap();assert_eq!(saved["conclusion"],"Исправленное заключение");assert_eq!(saved["origin"],"legacy");assert_eq!(saved["legacy_version"],"1");let prior:String=db.open().unwrap().query_row("SELECT previous_json FROM audit WHERE entity='study' AND entity_id=?",[id],|r|r.get(0)).unwrap();assert!(prior.contains("Тестовое заключение"));let mut orphan=study();orphan.patient_id=999;assert!(db.save_study(orphan).is_err());clean(db)}
    #[test] fn legacy_unknown_references_and_raw_fields_survive_edit(){
        let db=fixture();let c=db.open().unwrap();c.execute_batch("PRAGMA foreign_keys=OFF;CREATE TABLE legacy_protocol(id,var_part);INSERT INTO legacy_protocol VALUES(99,'original raw');INSERT INTO studies(id,patient_id,date,template_id,doctor_id,title,conclusion,addition,fields_json,legacy_version,origin,status) VALUES(99,0,'2001-01-01',0,0,'Исходное название','','','{}','0','legacy','legacy:0');").unwrap();drop(c);
        let mut input=study();input.id=Some(99);input.revision=Some(1);input.patient_id=0;input.template_id=0;input.doctor_id=0;input.template_version=Some("0".into());input.fields=json!({"old_unknown":{"type":"select","value":"123"}});db.save_study(input).unwrap();let saved=db.study(99).unwrap();assert_eq!(saved["title"],"Исходное название");assert_eq!(saved["patient_id"],0);assert_eq!(saved["legacy_version"],"0");assert_eq!(saved["fields"]["old_unknown"]["value"],"123");assert_eq!(db.open().unwrap().query_row("SELECT var_part FROM legacy_protocol WHERE id=99",[],|r|r.get::<_,String>(0)).unwrap(),"original raw");
        let mut stale=study();stale.id=Some(99);stale.revision=Some(1);stale.patient_id=0;stale.template_id=0;stale.doctor_id=0;assert!(db.save_study(stale).unwrap_err().contains("изменилось"));clean(db)
    }
    #[test] fn patient_sorting_covers_all_rows_dates_filters_and_stable_pages(){
        let db=fixture();let c=db.open().unwrap();
        for (id,name,birth) in [(2,"Анна",Some("1990-01-01")),(3,"Борис",Some("1980-02-01")),(4,"Вера",None),(5,"Галина",Some("0000-00-00")),(6,"Дина",Some("")),(7,"Елена",Some("2000-01-01"))]{c.execute("INSERT INTO patients(id,name,search_name,gender,birthdate) VALUES(?,?,?,'F',?)",params![id,name,search(name),birth]).unwrap();}
        for (id,patient,date) in [(1,1,"2026-11-06"),(2,2,"2020-01-01"),(3,2,"2025-01-01"),(4,3,"2025-01-01"),(5,4,"2001-01-01"),(6,6,"0000-00-00")]{c.execute("INSERT INTO studies(id,patient_id,date,template_id,doctor_id,title,conclusion,addition,fields_json,origin,status) VALUES(?,?,?,1,1,'Test','','','{}','native','draft')",params![id,patient,date]).unwrap();}drop(c);
        let ids=|sort:&str,direction:&str,page:i64,size:i64|db.patients("","",page,size,sort,direction).unwrap()["items"].as_array().unwrap().iter().map(|p|p["id"].as_i64().unwrap()).collect::<Vec<_>>();
        assert_eq!(ids("name","asc",0,50),vec![2,3,4,5,6,7,1]);assert_eq!(ids("name","desc",0,50),vec![1,7,6,5,4,3,2]);
        assert_eq!(&ids("birthdate","asc",0,50)[..4],&[3,2,7,1]);assert_eq!(&ids("birthdate","desc",0,50)[..4],&[7,1,2,3]);
        assert_eq!(&ids("lastStudy","asc",0,50)[..4],&[4,2,3,1]);assert_eq!(&ids("lastStudy","desc",0,50)[..4],&[1,2,3,4]);
        for key in ["name","birthdate","lastStudy"]{for direction in ["asc","desc"]{let full=ids(key,direction,0,50);let paged=(0..4).flat_map(|page|ids(key,direction,page,2)).collect::<Vec<_>>();assert_eq!(full,paged);}}
        let filtered=db.patients("а","F",0,50,"birthdate","desc").unwrap();assert!(filtered["items"].as_array().unwrap().iter().all(|p|p["gender"]=="F"));assert_eq!(filtered["items"][0]["id"],7);
        assert!(db.patients("","",0,50,"name;DROP TABLE patients","asc").is_err());assert!(db.patients("","",0,50,"name","DESC;DELETE").is_err());assert_eq!(db.patients("","",0,50,"name","asc").unwrap()["total"],7);clean(db)
    }
    #[test] fn page_size_controls_limits_and_offsets(){let db=fixture();let c=db.open().unwrap();for id in 2..=620{c.execute("INSERT INTO patients(id,name,search_name,gender,birthdate) VALUES(?1,?2,?2,'F','2000-01-01')",params![id,format!("Пациент {:03}",id)]).unwrap();}let first=db.patients("","",0,15,"name","asc").unwrap();let second=db.patients("","",1,15,"name","asc").unwrap();assert_eq!(first["items"].as_array().unwrap().len(),15);assert_eq!(second["items"].as_array().unwrap().len(),15);for row in first["items"].as_array().unwrap(){assert!(!second["items"].as_array().unwrap().iter().any(|r|r["id"]==row["id"]));}assert_eq!(db.patients("","",0,1000,"name","asc").unwrap()["items"].as_array().unwrap().len(),500);drop(c);for _ in 0..32{db.save_study(study()).unwrap();}assert_eq!(db.studies("",0,15).unwrap()["items"].as_array().unwrap().len(),15);assert_eq!(db.studies("",2,15).unwrap()["items"].as_array().unwrap().len(),2);clean(db)}
    #[test] fn incomplete_measurements_allow_completion_without_stale_results(){let db=fixture();let mut input=study();input.fields["_calculation_pending"]=json!({"type":"meta","value":"1"});let id=db.save_study(input).unwrap();assert_eq!(db.study(id).unwrap()["fields"]["_calculation_pending"]["value"],"1");let mut final_input=study();final_input.status="final".into();final_input.fields["_calculation_pending"]=json!({"type":"meta","value":"1"});let final_id=db.save_study(final_input).unwrap();assert_eq!(db.study(final_id).unwrap()["status"],"final");clean(db)}
    #[test] fn backup_can_be_opened_independently(){let db=fixture();db.save_study(study()).unwrap();let path=db.backup().unwrap();let c=Connection::open(path).unwrap();assert_eq!(c.query_row("SELECT count(*) FROM studies",[],|r|r.get::<_,i64>(0)).unwrap(),1);drop(c);clean(db)}
}
const STUDIES:&str="SELECT s.id,s.patient_id AS patientId,s.date,s.title,s.origin,s.status,s.revision,s.template_id AS templateId,s.doctor_id AS doctorId,COALESCE(d.name,'Врач не указан') AS doctor FROM studies s LEFT JOIN doctors d ON d.id=s.doctor_id";
const PATIENTS:&str="SELECT p.id,p.name,p.gender,p.birthdate,p.city,p.street,p.house,p.flat,p.revision,(SELECT count(*) FROM studies s WHERE s.patient_id=p.id) AS studyCount,(SELECT max(s.date) FROM studies s WHERE s.patient_id=p.id) AS lastStudy FROM patients p";

impl Database {
    pub fn new(path:PathBuf)->Self { Self{path} }
    pub(crate) fn open(&self)->Result<Connection,String> {
        if !self.path.is_file(){ return Err("Файл uzi.db не найден. Положите базу рядом с программой.".into()); }
        let c=Connection::open_with_flags(&self.path,OpenFlags::SQLITE_OPEN_READ_WRITE).map_err(err)?;
        c.busy_timeout(Duration::from_secs(5)).map_err(err)?;
        c.pragma_update(None,"foreign_keys","ON").map_err(err)?;
        c.pragma_update(None,"trusted_schema","OFF").map_err(err)?;
        let version:i64=c.pragma_query_value(None,"user_version",|r|r.get(0)).map_err(err)?;
        if ![1,2].contains(&version) {return Err("Версия базы не поддерживается этой программой.".into())}
        Ok(c)
    }
    pub fn info(&self)->Result<Value,String> {
        let c=self.open()?;
        Ok(json!({"path":self.path.to_string_lossy(),"patients":c.query_row("SELECT count(*) FROM patients WHERE hidden=0",[],|r|r.get::<_,i64>(0)).map_err(err)?,"studies":c.query_row("SELECT count(*) FROM studies",[],|r|r.get::<_,i64>(0)).map_err(err)?,"templates":rows(&c,"SELECT * FROM templates ORDER BY name",[])?,"doctors":rows(&c,"SELECT id,name FROM doctors WHERE hidden=0 ORDER BY name",[])?,"migration":c.query_row("SELECT value FROM metadata WHERE key='migration'",[],|r|r.get::<_,String>(0)).map_err(err)?}))
    }
    pub fn patients(&self,q:&str,gender:&str,page:i64,page_size:i64,sort:&str,direction:&str)->Result<Value,String> {
        let direction=match direction{"asc"=>"ASC","desc"=>"DESC",_=>return Err("Неизвестное направление сортировки".into())};
        let order=match sort{
            "name"=>format!("p.search_name {direction},p.id ASC"),
            "birthdate"=>format!("CASE WHEN p.birthdate IS NULL OR p.birthdate='' OR p.birthdate LIKE '0000%' THEN 1 ELSE 0 END ASC,p.birthdate {direction},p.search_name ASC,p.id ASC"),
            "lastStudy"=>format!("CASE WHEN lastStudy IS NULL OR lastStudy='' OR lastStudy LIKE '0000%' THEN 1 ELSE 0 END ASC,lastStudy {direction},p.search_name ASC,p.id ASC"),
            _=>return Err("Неизвестная колонка сортировки".into())
        };
        let c=self.open()?; let pattern=like(q); let page_size=page_size.clamp(1,500); let offset=page.clamp(0,100000)*page_size;
        let filter=" WHERE p.hidden=0 AND (COALESCE(p.search_name,'') LIKE ?1 ESCAPE '\\' OR CAST(p.id AS TEXT)=?2) AND (?3='' OR p.gender=?3)";
        let count:i64=c.query_row(&format!("SELECT count(*) FROM patients p{filter}"),params![pattern,q.trim(),gender],|r|r.get(0)).map_err(err)?;
        Ok(json!({"total":count,"items":rows(&c,&format!("{PATIENTS}{filter} ORDER BY {order} LIMIT ?5 OFFSET ?4"),params![pattern,q.trim(),gender,offset,page_size])?}))
    }
    pub fn patient(&self,id:i64)->Result<Value,String> {
        let c=self.open()?;
        let patient=rows(&c,&format!("{PATIENTS} WHERE p.id=?1 AND p.hidden=0"),[id])?.pop().ok_or("Пациент не найден")?;
        let studies=rows(&c,&format!("{STUDIES} WHERE s.patient_id=?1 ORDER BY s.date DESC,s.id DESC"),[id])?;
        Ok(json!({"patient":patient,"studies":studies}))
    }
    pub fn studies(&self,q:&str,page:i64,page_size:i64)->Result<Value,String> {
        let c=self.open()?;
        let filter=" LEFT JOIN patients p ON p.id=s.patient_id WHERE (p.hidden=0 OR p.id IS NULL) AND (COALESCE(p.search_name,'') LIKE ?1 ESCAPE '\\' OR CAST(s.id AS TEXT)=?2)";
        let count:i64=c.query_row(&format!("SELECT count(*) FROM studies s{filter}"),params![like(q),q.trim()],|r|r.get(0)).map_err(err)?;
        let sql=format!("SELECT s.id,s.patient_id AS patientId,p.name AS patientName,s.date,s.title,s.origin,s.status,s.revision,s.template_id AS templateId,s.doctor_id AS doctorId,COALESCE(d.name,'Врач не указан') AS doctor FROM studies s LEFT JOIN doctors d ON d.id=s.doctor_id {filter} ORDER BY s.date DESC,s.id DESC LIMIT ?4 OFFSET ?3");
        Ok(json!({"total":count,"items":rows(&c,&sql,params![like(q),q.trim(),page.clamp(0,100000)*page_size.clamp(1,500),page_size.clamp(1,500)])?}))
    }
    pub fn study(&self,id:i64)->Result<Value,String> {
        let c=self.open()?;
        let mut value=rows(&c,"SELECT s.*,d.name AS doctor,COALESCE(p.name,'Без карточки пациента') AS patientName,p.birthdate AS patientBirthdate,t.code AS templateCode FROM studies s LEFT JOIN patients p ON p.id=s.patient_id LEFT JOIN doctors d ON d.id=s.doctor_id LEFT JOIN templates t ON t.id=s.template_id WHERE s.id=?1",[id])?.pop().ok_or("Исследование не найдено")?;
        value["fields"]=serde_json::from_str(value["fields_json"].as_str().unwrap_or("{}")).map_err(err)?;
        value.as_object_mut().unwrap().remove("fields_json");
        Ok(value)
    }
    pub fn save_patient(&self,input:PatientInput)->Result<i64,String> {
        if input.name.trim().len()<3 || input.name.len()>255 {return Err("Укажите ФИО пациента (3–255 символов).".into())}
        if !["M","F"].contains(&input.gender.as_str()) {return Err("Выберите пол пациента.".into())}
        if !input.birthdate.is_empty() && !valid_date(&input.birthdate) {return Err("Укажите корректную дату рождения.".into())}
        if input.birthdate>chrono::Local::now().format("%Y-%m-%d").to_string() {return Err("Дата рождения не может быть в будущем.".into())}
        let mut c=self.open()?; let tx=c.transaction().map_err(err)?;
        let id=if let Some(id)=input.id {
            let previous=rows(&tx,"SELECT * FROM patients WHERE id=?1",[id])?.pop().ok_or("Пациент не найден")?;
            let changed=tx.execute("UPDATE patients SET name=?1,search_name=?2,gender=?3,birthdate=?4,city=?5,street=?6,house=?7,flat=?8,revision=revision+1 WHERE id=?9 AND revision=?10",params![input.name.trim(),search(&input.name),input.gender,input.birthdate,input.city,input.street,input.house,input.flat,id,input.revision]).map_err(err)?;
            if changed!=1 {return Err("Карточка изменилась. Откройте её заново перед сохранением.".into())}
            tx.execute("INSERT INTO audit(entity,entity_id,previous_json,saved_at) VALUES('patient',?1,?2,datetime('now'))",params![id,previous.to_string()]).map_err(err)?; id
        } else {
            tx.execute("INSERT INTO patients(name,search_name,gender,birthdate,city,street,house,flat) VALUES(?,?,?,?,?,?,?,?)",params![input.name.trim(),search(&input.name),input.gender,input.birthdate,input.city,input.street,input.house,input.flat]).map_err(err)?;
            tx.last_insert_rowid()
        };
        crate::security::audit(&tx,"save_patient",id)?;
        tx.commit().map_err(err)?; Ok(id)
    }
    pub fn save_study(&self,input:StudyInput)->Result<i64,String> {
        if !valid_date(&input.date) {return Err("Укажите корректную дату исследования.".into())}
        if !["draft","final"].contains(&input.status.as_str()){return Err("Неизвестный статус исследования.".into())}
        if input.status=="final" && input.conclusion.trim().is_empty(){return Err("Заполните заключение перед завершением.".into())}
        if !input.fields.is_object() || input.fields.to_string().len()>1_000_000 || input.conclusion.len()>100_000 || input.addition.len()>100_000 {return Err("Некорректные данные исследования.".into())}
        if input.fields.as_object().unwrap().values().any(|field|field.get("value").and_then(Value::as_str).is_none()||field.get("type").and_then(Value::as_str).is_none()){return Err("Параметры исследования должны содержать строковое значение и тип.".into())}
        if let Some(version)=input.template_version.as_ref(){if version.is_empty()||version.len()>20||!version.chars().all(|c|c.is_ascii_digit()){return Err("Некорректная версия шаблона.".into())}}
        let mut c=self.open()?; let tx=c.transaction().map_err(err)?;
        let previous=if let Some(id)=input.id{Some(rows(&tx,"SELECT * FROM studies WHERE id=?1",[id])?.pop().ok_or("Исследование не найдено")?)}else{None};
        let legacy=previous.as_ref().is_some_and(|p|p["origin"]=="legacy");
        let title:String=if legacy&&previous.as_ref().unwrap()["template_id"]==input.template_id{previous.as_ref().unwrap()["title"].as_str().unwrap_or("").into()}else{tx.query_row("SELECT name FROM templates WHERE id=?1",[input.template_id],|r|r.get(0)).map_err(|_|"Выберите вид исследования".to_string())?};
        let doctor_count:i64=tx.query_row("SELECT count(*) FROM doctors WHERE id=?1 AND hidden=0",[input.doctor_id],|r|r.get(0)).map_err(err)?;
        if doctor_count!=1&&!(legacy&&previous.as_ref().unwrap()["doctor_id"]==input.doctor_id){return Err("Выберите врача.".into())}
        let id=if let Some(id)=input.id {
            let prev=previous.unwrap();
            if prev["patient_id"]!=input.patient_id {return Err("Пациент исследования не совпадает.".into())}
            let changed=tx.execute("UPDATE studies SET date=?1,template_id=?2,doctor_id=?3,title=?4,conclusion=?5,addition=?6,fields_json=?7,status=?8,revision=revision+1,updated_at=datetime('now'),legacy_version=COALESCE(?11,legacy_version) WHERE id=?9 AND revision=?10",params![input.date,input.template_id,input.doctor_id,title,input.conclusion,input.addition,input.fields.to_string(),input.status,id,input.revision,input.template_version]).map_err(err)?;
            if changed!=1 {return Err("Исследование изменилось. Откройте его заново.".into())}
            tx.execute("INSERT INTO audit(entity,entity_id,previous_json,saved_at) VALUES('study',?1,?2,datetime('now'))",params![id,prev.to_string()]).map_err(err)?; id
        } else {
            tx.execute("INSERT INTO studies(patient_id,date,template_id,doctor_id,title,conclusion,addition,fields_json,origin,status,updated_at,legacy_version) VALUES(?,?,?,?,?,?,?,?,'native',?,datetime('now'),?)",params![input.patient_id,input.date,input.template_id,input.doctor_id,title,input.conclusion,input.addition,input.fields.to_string(),input.status,input.template_version]).map_err(err)?;
            tx.last_insert_rowid()
        };
        crate::security::audit(&tx,"save_study",id)?;
        tx.commit().map_err(err)?; Ok(id)
    }
    pub fn backup(&self)->Result<String,String> {
        let c=self.open()?;
        let folder=self.path.parent().ok_or("Не удалось определить папку базы")?.join("backups");
        std::fs::create_dir_all(&folder).map_err(err)?;
        let path=folder.join(format!("uzi-{}.db",chrono::Local::now().format("%Y-%m-%d-%H%M%S-%f")));
        c.backup("main",&path,None).map_err(err)?;
        let check=Connection::open_with_flags(&path,OpenFlags::SQLITE_OPEN_READ_ONLY).map_err(err)?;
        let integrity:String=check.query_row("PRAGMA integrity_check",[],|r|r.get(0)).map_err(err)?;
        if integrity!="ok" {return Err("Проверка резервной копии не пройдена.".into())}
        Ok(path.to_string_lossy().into_owned())
    }
}
