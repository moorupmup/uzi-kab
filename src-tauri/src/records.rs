use crate::repository::{Database,rows,err};
use rusqlite::{params,OptionalExtension};
use serde_json::{Value,json};
use sha2::{Digest,Sha256};
use std::{io::{Read,Write},path::Path};

fn sniff(data:&[u8])->Option<&'static str>{
    if data.starts_with(b"\x89PNG\r\n\x1a\n"){Some("image/png")}
    else if data.starts_with(b"\xff\xd8\xff"){Some("image/jpeg")}
    else if data.len()>12&&&data[..4]==b"RIFF"&&&data[8..12]==b"WEBP"{Some("image/webp")}
    else if data.len()>12&&&data[4..8]==b"ftyp"{Some("video/mp4")}
    else if data.starts_with(&[0x1a,0x45,0xdf,0xa3]){Some("video/webm")}
    else if data.len()>12&&&data[..4]==b"RIFF"&&&data[8..12]==b"AVI "{Some("video/x-msvideo")}
    else{None}
}
impl Database{
    pub fn hidden_patients(&self)->Result<Value,String>{Ok(json!(rows(&self.open()?,"SELECT id,name,birthdate,revision FROM patients WHERE hidden=1 ORDER BY search_name",[])?))}
    pub fn set_patient_hidden(&self,id:i64,revision:i64,hidden:bool,actor:i64)->Result<(),String>{
        let mut c=self.open()?;let tx=c.transaction().map_err(err)?;
        let previous=rows(&tx,"SELECT * FROM patients WHERE id=?",[id])?.pop().ok_or("Пациент не найден")?;
        if tx.execute("UPDATE patients SET hidden=?,revision=revision+1 WHERE id=? AND revision=?",params![hidden,id,revision]).map_err(err)?!=1{return Err("Карточка изменилась. Откройте её заново.".into())}
        tx.execute("INSERT INTO audit(entity,entity_id,previous_json,saved_at) VALUES('patient',?,?,datetime('now'))",params![id,previous.to_string()]).map_err(err)?;
        tx.execute("INSERT INTO access_audit(actor_id,action,entity_id) VALUES(?,?,?)",params![actor,if hidden{"hide_patient"}else{"restore_patient"},id]).map_err(err)?;tx.commit().map_err(err)?;Ok(())
    }
    #[cfg(test)]
    pub fn statistics(&self,from:&str,to:&str)->Result<Value,String>{self.statistics_filtered(from,to,&crate::reports::ReportFilter::default())}
    #[cfg(test)]
    pub fn export_statistics(&self,path:&str,from:&str,to:&str)->Result<(),String>{self.export_statistics_filtered(path,from,to,&crate::reports::ReportFilter::default())}
    pub fn create_bundle(&self,patient:i64,name:&str,ids:Vec<i64>,actor:i64)->Result<i64,String>{
        if name.trim().is_empty()||name.len()>200||ids.len()<2||ids.len()>20{return Err("Укажите название и от 2 до 20 исследований одного пациента".into())}
        let unique=ids.iter().collect::<std::collections::HashSet<_>>();if unique.len()!=ids.len(){return Err("Исследования не должны повторяться".into())}
        let mut c=self.open()?;let tx=c.transaction().map_err(err)?;
        for id in &ids{let owner:Option<(i64,String)>=tx.query_row("SELECT patient_id,status FROM studies WHERE id=?",[id],|r|Ok((r.get(0)?,r.get(1)?))).optional().map_err(err)?;if !matches!(owner,Some((p,ref status)) if p==patient&&p!=0&&["final","legacy:1"].contains(&status.as_str())){return Err("Объединять можно только завершённые исследования одного пациента".into())}}
        crate::lifecycle::tables(&tx)?;
        tx.execute("INSERT INTO study_bundles(patient_id,name,actor_id) VALUES(?,?,?)",params![patient,name.trim(),actor]).map_err(err)?;let id=tx.last_insert_rowid();
        for (index,study) in ids.iter().enumerate(){tx.execute("INSERT INTO bundle_items VALUES(?,?,?)",params![id,study,index as i64]).map_err(err)?;}
        tx.execute("INSERT INTO bundle_state(bundle_id) VALUES(?)",[id]).map_err(err)?;
        tx.execute("INSERT INTO bundle_item_revisions SELECT i.bundle_id,i.study_id,s.revision FROM bundle_items i JOIN studies s ON s.id=i.study_id WHERE i.bundle_id=?",[id]).map_err(err)?;
        tx.execute("INSERT INTO access_audit(actor_id,action,entity_id) VALUES(?,'create_bundle',?)",params![actor,id]).map_err(err)?;tx.commit().map_err(err)?;Ok(id)
    }
    pub fn patient_bundles(&self,patient:i64)->Result<Value,String>{let c=self.open()?;let mut bundles=rows(&c,"SELECT b.id,b.name,b.created_at AS createdAt,(SELECT count(*) FROM bundle_items i WHERE i.bundle_id=b.id) AS count FROM study_bundles b WHERE b.patient_id=? ORDER BY b.id DESC",[patient])?;for b in &mut bundles{let state=Self::bundle_state(&c,b["id"].as_i64().unwrap())?;for (key,value) in state.as_object().unwrap(){b[key]=value.clone()}}Ok(json!(bundles))}
    pub fn bundle(&self,id:i64)->Result<Value,String>{
        let c=self.open()?;let mut bundle=rows(&c,"SELECT b.*,p.name AS patientName FROM study_bundles b JOIN patients p ON p.id=b.patient_id WHERE b.id=?",[id])?.pop().ok_or("Объединённый протокол не найден")?;
        let state=Self::bundle_state(&c,id)?;for (key,value) in state.as_object().unwrap(){bundle[key]=value.clone()}
        let ids=rows(&c,"SELECT study_id AS id FROM bundle_items WHERE bundle_id=? ORDER BY position,study_id",[id])?;let mut issues=Vec::new();let mut studies=Vec::new();let mut can_print=bundle["deleted"]!=true&&!ids.is_empty();
        for row in ids{let study_id=row["id"].as_i64().unwrap();match self.study(study_id){Ok(s)=>{
         if s["patient_id"]!=bundle["patient_id"]{can_print=false;issues.push(json!({"studyId":study_id,"message":"Пациент исследования не совпадает с пациентом комплекта."}))}
         let status=s["status"].as_str().unwrap_or("");if crate::lifecycle::deleted(status){can_print=false;issues.push(json!({"studyId":study_id,"message":"Исследование удалено. Для печати восстановите его либо создайте другой комплект."}))}else if !["final","legacy:1"].contains(&status){if bundle["origin"]!="legacy"{can_print=false}issues.push(json!({"studyId":study_id,"message":"Исследование не завершено. Архивный состав сохранён; документ имеет отметку черновика."}))}
         if crate::lifecycle::exists(&c,"bundle_item_revisions")?{let original=c.query_row("SELECT revision FROM bundle_item_revisions WHERE bundle_id=? AND study_id=?",params![id,study_id],|r|r.get::<_,i64>(0)).optional().map_err(err)?;if original.is_some_and(|v|s["revision"]!=v){issues.push(json!({"studyId":study_id,"message":"Исследование изменено после формирования комплекта. Проверьте текущий документ."}))}}
         studies.push(s)
        },Err(e)=>{can_print=false;issues.push(json!({"studyId":study_id,"message":format!("Документ не удалось открыть: {e}")}))}}}
        Ok(json!({"bundle":bundle,"studies":studies,"issues":issues,"canPrint":can_print}))
    }
    pub fn attachments(&self,study:i64)->Result<Value,String>{Ok(json!(rows(&self.open()?,"SELECT id,name,mime,length(content) AS bytes,created_at AS createdAt FROM attachments WHERE study_id=? AND deleted=0 ORDER BY id",[study])?))}
    pub fn import_attachment(&self,study:i64,path:&str,actor:i64)->Result<i64,String>{
        let path=Path::new(path);let mut bytes=Vec::new();std::fs::File::open(path).map_err(err)?.take(250*1024*1024+1).read_to_end(&mut bytes).map_err(err)?;
        if bytes.len()>250*1024*1024{return Err("Максимальный размер файла — 250 МБ".into())}
        let mime=sniff(&bytes).ok_or("Поддерживаются PNG, JPEG, WebP, MP4, WebM и AVI. Содержимое файла не соответствует этим форматам.")?;
        if mime.starts_with("image/")&&bytes.len()>25*1024*1024{return Err("Максимальный размер снимка — 25 МБ".into())}
        let name=path.file_name().ok_or("Имя файла не найдено")?.to_string_lossy().to_string();let hash=format!("{:x}",Sha256::digest(&bytes));
        let mut c=self.open()?;let tx=c.transaction().map_err(err)?;let _:i64=tx.query_row("SELECT id FROM studies WHERE id=?",[study],|r|r.get(0)).map_err(err)?;
        tx.execute("INSERT INTO attachments(study_id,name,mime,content,sha256,actor_id) VALUES(?,?,?,?,?,?)",params![study,name,mime,bytes,hash,actor]).map_err(err)?;let id=tx.last_insert_rowid();tx.execute("INSERT INTO access_audit(actor_id,action,entity_id) VALUES(?,'attach_file',?)",params![actor,id]).map_err(err)?;tx.commit().map_err(err)?;Ok(id)
    }
    pub fn remove_attachment(&self,id:i64,actor:i64)->Result<(),String>{let c=self.open()?;c.execute("UPDATE attachments SET deleted=1 WHERE id=?",[id]).map_err(err)?;self.audit_event(actor,"hide_attachment",Some(id),"")}
    pub fn attachment_study(&self,id:i64)->Result<i64,String>{self.open()?.query_row("SELECT study_id FROM attachments WHERE id=? AND deleted=0",[id],|r|r.get(0)).map_err(err)}
    pub fn attachment_response(&self,id:i64,range:Option<&str>)->Result<(Vec<u8>,String,u16,Option<String>,i64),String>{
        let c=self.open()?;let (mime,total):(String,i64)=c.query_row("SELECT mime,length(content) FROM attachments WHERE id=? AND deleted=0",[id],|r|Ok((r.get(0)?,r.get(1)?))).map_err(err)?;
        if total==0{return Err("Пустое вложение".into())}
        let mut partial=false;let (start,end)=if let Some(range)=range{
            let values=range.strip_prefix("bytes=").ok_or("Некорректный диапазон")?.split_once('-').ok_or("Некорректный диапазон")?;
            let start=values.0.parse::<i64>().map_err(err)?;if start<0||start>=total{return Err("Диапазон за пределами файла".into())}
            let end=if values.1.is_empty(){total-1}else{values.1.parse::<i64>().map_err(err)?.min(total-1)};if end<start{return Err("Некорректный диапазон".into())}partial=true;(start,end.min(start+8*1024*1024-1))
        }else if mime.starts_with("video/"){partial=true;(0,(total-1).min(8*1024*1024-1))}else{(0,total-1)};
        let data:Vec<u8>=c.query_row("SELECT substr(content,?,?) FROM attachments WHERE id=? AND deleted=0",params![start+1,end-start+1,id],|r|r.get(0)).map_err(err)?;
        Ok((data,mime,if partial{206}else{200},if partial{Some(format!("bytes {start}-{end}/{total}"))}else{None},total))
    }
    pub fn export_attachment(&self,id:i64,path:&str)->Result<(),String>{
        let mut c=self.open()?;let tx=c.transaction().map_err(err)?;
        let (total,expected):(i64,String)=tx.query_row("SELECT length(content),sha256 FROM attachments WHERE id=? AND deleted=0",[id],|r|Ok((r.get(0)?,r.get(1)?))).map_err(err)?;
        let mut file=std::fs::OpenOptions::new().write(true).create_new(true).open(path).map_err(|e|format!("Выберите новое имя файла: {e}"))?;let mut digest=Sha256::new();let mut start=0;
        while start<total{let data:Vec<u8>=tx.query_row("SELECT substr(content,?,?) FROM attachments WHERE id=?",params![start+1,256*1024,id],|r|r.get(0)).map_err(err)?;if data.is_empty(){return Err("Вложение повреждено".into())}file.write_all(&data).map_err(err)?;digest.update(&data);start+=data.len() as i64;}
        file.sync_all().map_err(err)?;if format!("{:x}",digest.finalize())!=expected{return Err("Контрольная сумма вложения не совпала".into())}Ok(())
    }
}

#[cfg(test)]mod tests{
    use super::*;
    fn fixture()->Database{let root=std::env::temp_dir().join(format!("uzi-records-{}-{}",std::process::id(),chrono::Utc::now().timestamp_nanos_opt().unwrap()));std::fs::create_dir_all(&root).unwrap();let db=Database::new(root.join("uzi.db"));let c=rusqlite::Connection::open(&db.path).unwrap();c.execute_batch(include_str!("../schema.sql")).unwrap();c.execute_batch(include_str!("../extended.sql")).unwrap();c.execute_batch("PRAGMA foreign_keys=OFF;PRAGMA user_version=2;INSERT INTO patients(id,name,search_name,gender) VALUES(1,'One','one','F'),(2,'Two','two','M');INSERT INTO doctors VALUES(1,'=Doctor',0);INSERT INTO templates VALUES(1,'Test','test');INSERT INTO studies(id,patient_id,date,template_id,doctor_id,title,conclusion,addition,fields_json,origin,status) VALUES(1,1,'2026-11-06',1,1,'Test','ok','','{}','native','final'),(2,1,'2026-11-06 12:00:00',1,1,'Test','ok','','{}','legacy','legacy:1'),(3,2,'2026-11-06',1,1,'Test','ok','','{}','native','final'),(4,0,'2026-11-06',0,1,'Unknown','','','{}','legacy','legacy:0'),(5,1,'2026-11-06',1,1,'Test','','','{}','legacy','legacy:2'),(6,1,'2026-11-06',1,1,'Test','','','{}','native','draft');CREATE TABLE legacy_protocol(id,pacient_id);INSERT INTO legacy_protocol VALUES(4,0);").unwrap();drop(c);db}
    fn clean(db:Database){std::fs::remove_dir_all(db.path.parent().unwrap()).unwrap()}
    #[test]fn media_sniff_does_not_trust_extension(){assert!(sniff(b"<script>alert(1)</script>").is_none());assert_eq!(sniff(b"\x89PNG\r\n\x1a\n"),Some("image/png"));}
    #[test]fn bundles_cannot_mix_patients_drafts_or_duplicate_items(){let db=fixture();assert!(db.create_bundle(1,"Mixed",vec![1,3],77).is_err());assert!(db.create_bundle(1,"Draft",vec![1,6],77).is_err());assert!(db.create_bundle(1,"Duplicate",vec![1,1],77).is_err());let id=db.create_bundle(1,"Combined",vec![2,1],77).unwrap();let result=db.bundle(id).unwrap();assert_eq!(result["studies"][0]["id"],2);assert_eq!(result["studies"].as_array().unwrap().len(),2);clean(db)}
    #[test]fn report_counts_only_completed_and_includes_date_without_time(){let db=fixture();let stats=db.statistics("2026-11-06","2026-11-06").unwrap();assert_eq!(stats["summary"]["studies"],3);assert_eq!(stats["summary"]["patients"],2);let path=db.path.with_file_name("report.csv");db.export_statistics(path.to_str().unwrap(),"2026-11-06","2026-11-06").unwrap();assert!(std::fs::read_to_string(&path).unwrap().contains("'=Doctor"));assert!(db.export_statistics(path.to_str().unwrap(),"2026-11-06","2026-11-06").is_err());clean(db)}
    #[test]fn attachments_roundtrip_ranges_and_soft_deletion(){let db=fixture();let path=db.path.with_file_name("test.png");let bytes=b"\x89PNG\r\n\x1a\nsynthetic-fixture";std::fs::write(&path,bytes).unwrap();let id=db.import_attachment(1,path.to_str().unwrap(),77).unwrap();let legacy_id=db.import_attachment(2,path.to_str().unwrap(),77).unwrap();assert_eq!(db.attachment_study(legacy_id).unwrap(),2);let data=db.attachment_response(id,Some("bytes=0-7")).unwrap();assert_eq!(data.0,&bytes[..8]);assert_eq!(data.2,206);assert!(db.attachment_response(id,Some("bytes=999-")).is_err());let exported=db.path.with_file_name("export.png");db.export_attachment(id,exported.to_str().unwrap()).unwrap();assert_eq!(std::fs::read(exported).unwrap(),bytes);db.remove_attachment(id,77).unwrap();assert_eq!(db.attachments(1).unwrap().as_array().unwrap().len(),0);assert_eq!(db.open().unwrap().query_row("SELECT count(*) FROM attachments WHERE id=?",[id],|r|r.get::<_,i64>(0)).unwrap(),1);clean(db)}
    #[test]fn hiding_a_card_does_not_remove_its_history(){let db=fixture();db.set_patient_hidden(1,1,true,77).unwrap();assert!(db.patient(1).is_err());assert_eq!(db.open().unwrap().query_row("SELECT count(*) FROM studies WHERE patient_id=1",[],|r|r.get::<_,i64>(0)).unwrap(),4);db.set_patient_hidden(1,2,false,77).unwrap();assert!(db.patient(1).is_ok());clean(db)}
}


// The migration retained source strings as Windows-1251 BLOBs.
pub(crate) fn book_text(value:rusqlite::types::ValueRef<'_>)->String {
    match value {
        rusqlite::types::ValueRef::Text(v)=>String::from_utf8_lossy(v).into_owned(),
        rusqlite::types::ValueRef::Blob(v)=>v.iter().map(|b|if *b<128{*b as char}else{CP1251.chars().nth((*b-128) as usize).unwrap()}).collect(),
        _=>String::new()
    }
}
const CP1251:&str="ЂЃ‚ѓ„…†‡€‰Љ‹ЊЌЋЏђ‘’“”•–—�™љ›њќћџ ЎўЈ¤Ґ¦§Ё©Є«¬­®Ї°±Ііґµ¶·ё№є»јЅѕїАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдежзийклмнопрстуфхцчшщъыьэюя";
impl Database {
    pub fn user_templates(&self)->Result<Value,String>{Ok(json!(Self::user_templates_from(&self.open()?)?))}
    pub(crate) fn source_user_templates_from(c:&rusqlite::Connection)->Result<Vec<Value>,String>{
        let exists:i64=c.query_row("SELECT count(*) FROM sqlite_master WHERE type='table' AND name='legacy_book_users'",[],|r|r.get(0)).map_err(err)?;
        let entries=if exists==0{vec![]}else{
        let mut st=c.prepare("SELECT id,research_id,name,key_name,level_id,position,status_hidden,status_root,value FROM legacy_book_users ORDER BY position,id").map_err(err)?;
        let entries=st.query_map([],|r|Ok(json!({"id":r.get::<_,i64>(0)?,"templateId":r.get::<_,i64>(1)?,"name":book_text(r.get_ref(2)?),"key":book_text(r.get_ref(3)?),"parentId":r.get::<_,i64>(4)?,"position":r.get::<_,i64>(5)?,"hidden":r.get::<_,i64>(6)?!=0,"folder":r.get::<_,i64>(7)?!=0,"value":book_text(r.get_ref(8)?),"revision":0,"deleted":false}))).map_err(err)?.collect::<Result<Vec<_>,_>>().map_err(err)?;
        entries
        };
        Ok(entries)
    }
    pub(crate) fn user_templates_from(c:&rusqlite::Connection)->Result<Vec<Value>,String>{
        let mut entries=Self::source_user_templates_from(c)?;
        let native:i64=c.query_row("SELECT count(*) FROM sqlite_master WHERE type='table' AND name='user_template_entries'",[],|r|r.get(0)).map_err(err)?;
        if native!=0 {
            let mut added=rows(&c,"SELECT n.id,n.template_id AS templateId,n.parent_id AS parentId,c.text AS name,c.text AS value,c.revision,c.deleted,'' AS key,0 AS hidden,0 AS folder FROM user_template_entries n JOIN user_template_changes c ON c.id=n.id ORDER BY n.id",[])?;
            for entry in &mut added{entry["hidden"]=json!(false);entry["folder"]=json!(false);entry["deleted"]=json!(entry["deleted"]==1);}
            added.extend(entries);entries=added;
        }
        let overrides:i64=c.query_row("SELECT count(*) FROM sqlite_master WHERE type='table' AND name='user_template_changes'",[],|r|r.get(0)).map_err(err)?;
        if overrides!=0 {
            for change in rows(&c,"SELECT * FROM user_template_changes",[])? {
                if let Some(entry)=entries.iter_mut().find(|e|e["id"]==change["id"]){entry["value"]=change["text"].clone();entry["deleted"]=json!(change["deleted"]==1);entry["revision"]=change["revision"].clone();}
            }
        }
        let has_tree:i64=c.query_row("SELECT count(*) FROM sqlite_master WHERE type='table' AND name='user_template_tree'",[],|r|r.get(0)).map_err(err)?;
        if has_tree!=0 {for change in rows(c,"SELECT node_json FROM user_template_tree",[])?{let node:Value=serde_json::from_str(change["node_json"].as_str().ok_or("Повреждена запись справочника")?).map_err(err)?;if let Some(e)=entries.iter_mut().find(|e|e["id"]==node["id"]){*e=node}else{entries.push(node)}}}
        entries.sort_by_key(|e|(e["position"].as_i64().unwrap_or(0),e["id"].as_i64().unwrap_or(0)));
        Ok(entries)
    }
    pub fn create_user_template(&self,template_id:i64,parent_id:i64,text:&str)->Result<Value,String>{
        let result=self.mutate_template_tree(crate::template_tree::TreeInput{action:"create".into(),id:None,revision:None,parent_id:Some(parent_id),template_id:Some(template_id),text:Some(text.into()),folder:Some(false),direction:None,deleted:None})?;
        Ok(result["entry"].clone())
    }
    pub fn save_user_template(&self,id:i64,revision:i64,text:&str,deleted:bool)->Result<Value,String>{
        let entries=Self::user_templates_from(&self.open()?)?;
        let node=entries.iter().find(|e|e["id"]==id).ok_or("Заготовка не найдена")?;
        if node["folder"]==true{return Err("Разделы изменяются в управлении разделами.".into())}
        let result=self.mutate_template_tree(crate::template_tree::TreeInput{action:"edit".into(),id:Some(id),revision:Some(revision),parent_id:None,template_id:None,text:Some(text.into()),folder:None,direction:None,deleted:Some(deleted)})?;
        Ok(json!({"id":id,"text":result["entry"]["value"],"deleted":result["entry"]["deleted"],"revision":result["entry"]["revision"]}))
    }

}

#[cfg(test)]mod template_tests {
    use super::*;
    #[test]fn source_dictionary_decodes_cyrillic_and_preserves_hidden_hierarchy(){
        let root=std::env::temp_dir().join(format!("uzi-templates-{}",chrono::Utc::now().timestamp_nanos_opt().unwrap()));
        std::fs::create_dir_all(&root).unwrap();let db=Database::new(root.join("uzi.db"));
        let c=rusqlite::Connection::open(&db.path).unwrap();c.execute_batch(include_str!("../schema.sql")).unwrap();
        c.pragma_update(None,"user_version",1).unwrap();
        assert_eq!(db.user_templates().unwrap(),json!([]));
        c.execute_batch("CREATE TABLE legacy_book_users(id,research_id,name,key_name,level_id,position,status_hidden,status_root,value); INSERT INTO legacy_book_users VALUES(1,80,X'CFE5F7E5EDFC','',0,1,0,1,''),(2,80,'Текст заготовки','',1,2,1,0,'');").unwrap();
        let entries=db.user_templates().unwrap();assert_eq!(entries[0]["name"],"Печень");assert_eq!(entries[1]["name"],"Текст заготовки");assert_eq!(entries[1]["parentId"],1);assert_eq!(entries[1]["hidden"],true);
        assert_eq!(c.query_row("SELECT hex(name) FROM legacy_book_users WHERE id=1",[],|r|r.get::<_,String>(0)).unwrap(),"CFE5F7E5EDFC");
        assert!(db.save_user_template(1,0,"Раздел",false).is_err());
        assert!(db.save_user_template(999,0,"Нет записи",false).is_err());
        assert!(db.save_user_template(2,0," ",false).is_err());
        let first=db.save_user_template(2,0,"Новый текст\nВторая строка",false).unwrap();assert_eq!(first["revision"],1);
        assert!(db.save_user_template(2,0,"Затереть новую правку",false).unwrap_err().contains("изменилась"));
        let reopened=db.user_templates().unwrap();assert_eq!(reopened[1]["value"],"Новый текст\nВторая строка");assert_eq!(reopened[1]["revision"],1);
        db.save_user_template(2,1,"Новый текст\nВторая строка",true).unwrap();assert_eq!(db.user_templates().unwrap()[1]["deleted"],true);
        db.save_user_template(2,2,"Новый текст\nВторая строка",false).unwrap();assert_eq!(db.user_templates().unwrap()[1]["deleted"],false);
        assert_eq!(c.query_row("SELECT name FROM legacy_book_users WHERE id=2",[],|r|r.get::<_,String>(0)).unwrap(),"Текст заготовки");
        assert_eq!(c.query_row("SELECT count(*) FROM audit WHERE entity='user_template'",[],|r|r.get::<_,i64>(0)).unwrap(),3);
        let backup=db.backup().unwrap();let copy=rusqlite::Connection::open(backup).unwrap();assert_eq!(copy.query_row("SELECT text FROM user_template_changes WHERE id=2",[],|r|r.get::<_,String>(0)).unwrap(),"Новый текст\nВторая строка");drop(copy);
        c.execute_batch("INSERT INTO templates VALUES(80,'Тестовое УЗИ','test'),(18,'Другое УЗИ','other');").unwrap();
        assert!(db.create_user_template(999,1,"Текст").is_err());assert!(db.create_user_template(80,2,"Текст").is_err());assert!(db.create_user_template(18,1,"Текст").is_err());assert!(db.create_user_template(80,1," ").is_err());
        let created=db.create_user_template(80,1,"Новая заготовка").unwrap();assert_eq!(created["id"],-1);assert_eq!(created["parentId"],1);
        let second=db.create_user_template(80,1,"Вторая заготовка").unwrap();assert_eq!(second["id"],-2);
        let reopened=db.user_templates().unwrap();assert_eq!(reopened[0]["id"],-2);assert_eq!(reopened[1]["value"],"Новая заготовка");
        db.save_user_template(-1,1,"Новая после правки",false).unwrap();db.save_user_template(-1,2,"Новая после правки",true).unwrap();assert_eq!(db.user_templates().unwrap()[1]["deleted"],true);
        db.save_user_template(-1,3,"Новая после правки",false).unwrap();assert_eq!(db.user_templates().unwrap()[1]["deleted"],false);
        assert_eq!(c.query_row("SELECT count(*) FROM legacy_book_users",[],|r|r.get::<_,i64>(0)).unwrap(),2);
        let backup=db.backup().unwrap();let copy=rusqlite::Connection::open(backup).unwrap();assert_eq!(copy.query_row("SELECT template_id FROM user_template_entries WHERE id=-1",[],|r|r.get::<_,i64>(0)).unwrap(),80);drop(copy);
        drop(c);std::fs::remove_dir_all(root).unwrap();
    }
}
