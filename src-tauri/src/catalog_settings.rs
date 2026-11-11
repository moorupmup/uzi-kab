use crate::repository::{Database,err,rows};
use rusqlite::{Connection,OptionalExtension,params};
use serde::Deserialize;
use serde_json::{Value,json};
use sha2::{Digest,Sha256};

#[derive(Deserialize)]#[serde(rename_all="camelCase")]
pub struct CatalogInput{pub id:Option<i64>,pub revision:i64,pub name:String,pub form_code:String,pub version:String,pub hidden:bool,pub gender:String,pub options:Value}
fn exists(c:&Connection,table:&str)->Result<bool,String>{Ok(c.query_row("SELECT count(*) FROM sqlite_master WHERE type='table' AND name=?",[table],|r|r.get::<_,i64>(0)).map_err(err)?>0)}
fn tables(c:&Connection)->Result<(),String>{c.execute_batch("CREATE TABLE IF NOT EXISTS template_config(template_id INTEGER PRIMARY KEY REFERENCES templates(id),revision INTEGER NOT NULL,config_json TEXT NOT NULL);CREATE TABLE IF NOT EXISTS form_snapshots(hash TEXT PRIMARY KEY,snapshot_json TEXT NOT NULL);").map_err(err)}
fn original_catalog()-> &'static Value{static DATA:std::sync::OnceLock<Value>=std::sync::OnceLock::new();DATA.get_or_init(||serde_json::from_str(include_str!("../../src/catalog.json")).unwrap())}
fn catalog()-> &'static Value{static DATA:std::sync::OnceLock<Value>=std::sync::OnceLock::new();DATA.get_or_init(||crate::form_revisions::catalog(original_catalog().clone()))}
fn versions()-> &'static Value{static DATA:std::sync::OnceLock<Value>=std::sync::OnceLock::new();DATA.get_or_init(||serde_json::from_str(include_str!("../../src/legacy-versions.json")).unwrap())}
fn supported(code:&str,version:&str)->bool{code=="universal"&&version=="1"||{static DATA:std::sync::OnceLock<Value>=std::sync::OnceLock::new();DATA.get_or_init(||serde_json::from_str(include_str!("../../src/editor-conditions.json")).unwrap()).get(format!("{code}_{version}")).is_some()}}
fn source_gender(c:&Connection,code:&str)->Result<String,String>{
 if !exists(c,"legacy_book")?{return Ok(String::new())}
 let columns=rows(c,"PRAGMA table_info(legacy_book)",[])?;if !["key_name","value"].iter().all(|key|columns.iter().any(|r|r["name"]==*key)){return Ok(String::new())}
 let value=c.query_row("SELECT cast(value AS TEXT) FROM legacy_book WHERE lower(cast(key_name AS TEXT))=? LIMIT 1",[format!("base.sex.{code}")],|r|r.get::<_,String>(0)).optional().map_err(err)?.unwrap_or_default();Ok(if ["M","F"].contains(&value.as_str()){value}else{String::new()})
}

#[cfg(test)]mod tests{
 use super::*;
 fn fixture()->Database{let root=std::env::temp_dir().join(format!("uzi-catalog-{}",chrono::Utc::now().timestamp_nanos_opt().unwrap()));std::fs::create_dir_all(&root).unwrap();let db=Database::new(root.join("uzi.db"));let c=Connection::open(&db.path).unwrap();c.execute_batch(include_str!("../schema.sql")).unwrap();c.execute_batch(include_str!("../extended.sql")).unwrap();c.execute_batch("PRAGMA user_version=2;INSERT INTO templates VALUES(80,'Брюшная полость','BROOHO');INSERT INTO doctors VALUES(1,'Тестовый врач',0);INSERT INTO patients(id,name,search_name,gender) VALUES(1,'Тест','тест','F');CREATE TABLE legacy_book_users(id,research_id,name,key_name,level_id,position,status_hidden,status_root,value);INSERT INTO legacy_book_users VALUES(1,0,'Заключения','BASE.DECISION',0,1,0,1,''),(2,80,'Исходный вид','BASE.DECISION.BROOHO',1,1,0,1,''),(3,80,'Текст врача','',2,1,0,0,'');").unwrap();db}
 fn clean(db:Database){std::fs::remove_dir_all(db.path.parent().unwrap()).unwrap()}
 fn config(db:&Database)->Value{Database::template_settings(&db.open().unwrap(),80).unwrap()}
 fn save(db:&Database,mut v:Value)->Result<Value,String>{v["formCode"]=v.get("formCode").cloned().unwrap_or(json!("brooho"));db.save_catalog_settings(serde_json::from_value(v).unwrap())}
 fn study(db:&Database,id:Option<i64>,kind:i64,fields:Value,source:Option<i64>)->i64{db.save_study(serde_json::from_value(json!({"id":id,"revision":id.map(|_|1),"patientId":1,"templateId":kind,"doctorId":1,"date":"2026-11-08","conclusion":"Тестовое заключение","addition":"","fields":fields,"status":"final","templateVersion":"1","sourceId":source})).unwrap()).unwrap()}
 #[test]fn settings_and_source_semantics_are_versioned_without_rewriting_documents(){
  let db=fixture();let before=study(&db,None,80,json!({"pechen":{"value":"81","type":"select"}}),None);let old=db.study(before).unwrap();let mut settings=config(&db);let original=catalog()["brooho_1"].as_array().unwrap().iter().find(|d|d["key"]=="pechen").unwrap()["options"].as_array().unwrap().clone();let first=original[0]["value"].as_str().unwrap();let mut choices:Vec<Value>=original.iter().map(|o|json!({"value":o["value"],"baseValue":o["value"],"label":o["label"],"hidden":false})).collect();choices[0]["label"]=json!("Новая подпись");choices.push(json!({"value":"custom_test","baseValue":first,"label":"Свой вариант","hidden":false}));settings["options"]["pechen"]=json!(choices);settings["name"]=json!("Новое название");let saved=save(&db,settings.clone()).unwrap();assert_eq!(saved["revision"],1);assert!(save(&db,settings).unwrap_err().contains("изменились"));
  assert_eq!(db.study(before).unwrap()["formSnapshot"],old["formSnapshot"]);assert_eq!(db.study(before).unwrap()["title"],"Брюшная полость");
  let new=study(&db,None,80,json!({"pechen":{"value":"custom_test","type":"select","label":"Подмена","baseValue":"999"}}),None);let current=db.study(new).unwrap();assert_eq!(current["fields"]["pechen"]["label"],"Свой вариант");assert_eq!(current["fields"]["pechen"]["baseValue"],first);assert_eq!(current["formSnapshot"]["configurationRevision"],1);
  study(&db,Some(before),80,json!({"pechen":{"value":"81","type":"select"},"_form_ref":{"value":current["fields"]["_form_ref"]["value"],"type":"meta"}}),None);assert_eq!(db.study(before).unwrap()["formSnapshot"],old["formSnapshot"]);assert_eq!(db.study(before).unwrap()["title"],old["title"]);
  let copy=study(&db,None,80,old["fields"].clone(),Some(before));assert_eq!(db.study(copy).unwrap()["formSnapshot"],old["formSnapshot"]);
  let mut next=config(&db);next["formCode"]=json!("universal");next["version"]=json!("1");next["options"]=json!({});save(&db,next).unwrap();assert_eq!(db.study(new).unwrap()["formSnapshot"],current["formSnapshot"]);let latest=study(&db,None,80,json!({}),None);assert_eq!(db.study(latest).unwrap()["formSnapshot"]["code"],"universal");
  let mut stale:crate::repository::StudyInput=serde_json::from_value(json!({"patientId":1,"templateId":80,"doctorId":1,"date":"2026-11-08","conclusion":"","addition":"","fields":{},"status":"draft","formRevision":0})).unwrap();assert!(db.save_study(stale).unwrap_err().contains("Настройки формы"));stale=serde_json::from_value(json!({"patientId":1,"templateId":80,"doctorId":1,"date":"2026-11-08","conclusion":"","addition":"","fields":{},"status":"draft","sourceId":new+999})).unwrap();assert!(db.save_study(stale).is_err());clean(db)
 }
 #[test]fn new_types_have_real_forms_and_service_sections_sync_idempotently(){
  let db=fixture();let created=save(&db,json!({"id":null,"revision":0,"name":"Новый вид","formCode":"brooho","version":"1","gender":"F","hidden":false,"options":{}})).unwrap();let kind=created["id"].as_i64().unwrap();let code=created["code"].as_str().unwrap();assert!(code.starts_with("custom_"));let saved=study(&db,None,kind,json!({}),None);assert_eq!(db.study(saved).unwrap()["formSnapshot"]["code"],"brooho");let nodes=db.user_templates().unwrap();assert!(nodes.as_array().unwrap().iter().any(|n|n["key"]==format!("CONFIG.USERS_PARAMS.{code}.pechen_text")));
  db.sync_catalog_sections().unwrap();let once=db.user_templates().unwrap();db.sync_catalog_sections().unwrap();assert_eq!(db.user_templates().unwrap(),once);assert_eq!(once.as_array().unwrap().iter().filter(|n|n["key"].as_str().is_some_and(|k|k.eq_ignore_ascii_case("BASE.DECISION.brooho"))).count(),1);assert!(nodes.as_array().unwrap().iter().any(|n|n["name"]=="Текст врача"));assert!(nodes.as_array().unwrap().iter().any(|n|n["key"]==format!("CONFIG.USERS_PARAMS.{code}.str_text")));
  let c=db.open().unwrap();assert_eq!(c.query_row("SELECT count(*) FROM legacy_book_users",[],|r|r.get::<_,i64>(0)).unwrap(),3);drop(c);
  let mut bad=created.clone();bad["formCode"]=json!("missing");assert!(save(&db,bad).unwrap_err().contains("ещё не перенесена"));let mut hidden=created;hidden["hidden"]=json!(true);save(&db,hidden).unwrap();assert!(Database::template_hidden(&db.open().unwrap(),kind).unwrap());clean(db)
 }
 #[test]fn free_options_are_canonical_and_immutable_in_older_studies(){
  let db=fixture();let mut settings=config(&db);let original=catalog()["brooho_1"].as_array().unwrap().iter().find(|d|d["key"]=="pechen").unwrap()["options"].as_array().unwrap();let mut choices:Vec<Value>=original.iter().map(|o|json!({"value":o["value"],"baseValue":o["value"],"label":o["label"],"hidden":false})).collect();choices.push(json!({"value":"custom_free","baseValue":"__text","label":"Собственный текст","hidden":false}));settings["options"]["pechen"]=json!(choices);save(&db,settings).unwrap();
  let id=study(&db,None,80,json!({"pechen":{"value":"custom_free","type":"string","baseValue":"630","label":"Подмена","caption":"Подмена"}}),None);let before=db.study(id).unwrap();assert_eq!(before["fields"]["pechen"]["type"],"select");assert_eq!(before["fields"]["pechen"]["label"],"Собственный текст");assert_eq!(before["fields"]["pechen"]["baseValue"],"__text");assert_eq!(before["fields"]["pechen"]["caption"],"Печень");
  let mut next=config(&db);next["options"]["pechen"][2]["label"]=json!("Изменённый текст");save(&db,next).unwrap();study(&db,Some(id),80,before["fields"].clone(),None);assert_eq!(db.study(id).unwrap()["formSnapshot"],before["formSnapshot"]);assert_eq!(db.study(id).unwrap()["fields"]["pechen"]["label"],"Собственный текст");let latest=study(&db,None,80,before["fields"].clone(),None);assert_eq!(db.study(latest).unwrap()["fields"]["pechen"]["label"],"Изменённый текст");
  let mut bad=config(&db);bad["options"]["pechen"][0]["baseValue"]=json!("__text");assert!(save(&db,bad).is_err());clean(db)
 }
 #[test]fn new_database_without_legacy_dictionary_keeps_native_service_nodes(){let db=fixture();db.open().unwrap().execute_batch("DROP TABLE legacy_book_users").unwrap();db.sync_catalog_sections().unwrap();let once=db.user_templates().unwrap();assert!(!once.as_array().unwrap().is_empty());db.sync_catalog_sections().unwrap();assert_eq!(db.user_templates().unwrap(),once);clean(db)}
 #[test]fn shipped_form_revision_needs_no_database_migration_and_keeps_old_documents(){
  let db=fixture();let c=db.open().unwrap();
  c.execute_batch("INSERT INTO studies(id,patient_id,date,template_id,doctor_id,title,conclusion,addition,fields_json,origin,status,legacy_version) VALUES(900,1,'2026-11-01',80,1,'Прежний протокол','Тест','','{\"kontur\":{\"value\":\"122\",\"type\":\"select\"},\"one_o\":{\"value\":\"631\",\"type\":\"checkbox\"},\"description\":{\"value\":\"Старое описание\",\"type\":\"text\"}}','native','final','1');").unwrap();
  let schema=rows(&c,"SELECT sql FROM sqlite_master ORDER BY name",[]).unwrap();let old=db.study(900).unwrap();
  assert!(old["formSnapshot"]["editor"].is_null());
  let form=Database::current_form(&c,80).unwrap();assert_eq!(form["presetRevision"],1);assert_eq!(form["editor"]["hideDescription"],true);
  assert_eq!(rows(&c,"SELECT sql FROM sqlite_master ORDER BY name",[]).unwrap(),schema);
  let defs=form["definitions"].as_array().unwrap();let field=|key:&str|defs.iter().find(|d|d["key"]==key).unwrap();
  assert_eq!(field("one_o")["hidden"],true);assert_eq!(field("m_seg8")["hidden"],true);assert_eq!(field("pechen_str_text")["hidden"],true);
  assert_eq!(field("v_polosti")["referenceKey"],"v_polosti");assert_eq!(field("struktura")["options"][2]["referenceSection"],"str_text");
  let id=study(&db,None,80,json!({"forma_izm":{"value":"preset_brooho_fasting","type":"select"},"soderg":{"value":"preset_brooho_moderate","type":"select"},"v_polosti":{"value":"Текст из своего справочника","type":"textarea_users"}}),None);
  let saved=db.study(id).unwrap();assert_eq!(saved["formSnapshot"],form);assert_eq!(saved["fields"]["forma_izm"]["baseValue"],"__text");assert_eq!(saved["fields"]["soderg"]["label"],"умеренное количество застойного содержимого");
  study(&db,Some(900),80,old["fields"].clone(),None);assert_eq!(db.study(900).unwrap()["formSnapshot"],old["formSnapshot"]);assert_eq!(db.study(900).unwrap()["fields"]["description"]["value"],"Старое описание");
  let copy=study(&db,None,80,old["fields"].clone(),Some(900));assert_eq!(db.study(copy).unwrap()["formSnapshot"],old["formSnapshot"]);
  drop(c);clean(db)
 }
 #[test]fn revised_options_roundtrip_through_settings_and_rebase_older_lists(){
  let db=fixture();let mut settings=config(&db);
  for key in ["kontur","soderg","forma_izm","struktura"]{
   let definitions=catalog()["brooho_1"].as_array().unwrap();let definition=definitions.iter().find(|d|d["key"]==key).unwrap();
   settings["options"][key]=json!(definition["options"].as_array().unwrap().iter().map(|o|json!({"value":o["value"],"baseValue":o.get("baseValue").unwrap_or(&o["value"]),"label":o["label"],"hidden":o["hidden"]==true})).collect::<Vec<_>>());
  }
  save(&db,settings).unwrap();let current=Database::current_form(&db.open().unwrap(),80).unwrap();assert_eq!(current["definitions"].as_array().unwrap().iter().find(|d|d["key"]=="struktura").unwrap()["options"][2]["referenceKey"],"pechen_str_text");
  let mut old=config(&db);old["options"]["kontur"]=json!(original_catalog()["brooho_1"].as_array().unwrap().iter().find(|d|d["key"]=="kontur").unwrap()["options"].as_array().unwrap().iter().map(|o|json!({"value":o["value"],"baseValue":o["value"],"label":o["label"],"hidden":false})).collect::<Vec<_>>());
  let mut custom=json!({"value":"custom_local","baseValue":"__text","label":"Мой вариант","hidden":false});old["options"]["kontur"].as_array_mut().unwrap().push(custom.take());save(&db,old).unwrap();
  let form=Database::current_form(&db.open().unwrap(),80).unwrap();let options=form["definitions"].as_array().unwrap().iter().find(|d|d["key"]=="kontur").unwrap()["options"].as_array().unwrap();assert_eq!(options.iter().filter(|o|o["hidden"]!=true).count(),5);assert_eq!(options.last().unwrap()["label"],"Мой вариант");clean(db)
 }
}
fn service_node(c:&Connection,nodes:&mut Vec<Value>,kind:i64,parent:i64,key:&str,name:&str)->Result<i64,String>{
 if let Some(n)=nodes.iter().find(|n|n["key"].as_str().is_some_and(|k|k.eq_ignore_ascii_case(key))){return n["id"].as_i64().ok_or("Неверный служебный раздел".into())}
 let id=nodes.iter().filter_map(|n|n["id"].as_i64()).min().unwrap_or(0).min(0)-1;
 let n=json!({"id":id,"templateId":kind,"parentId":parent,"key":key,"name":name,"value":"","folder":true,"hidden":false,"deleted":false,"position":kind,"revision":1});c.execute("INSERT INTO user_template_tree VALUES(?,?)",params![id,n.to_string()]).map_err(err)?;nodes.push(n);Ok(id)
}
impl Database{
 pub(crate) fn template_settings(c:&Connection,id:i64)->Result<Value,String>{
  if exists(c,"template_config")?{if let Some(raw)=c.query_row("SELECT config_json FROM template_config WHERE template_id=?",[id],|r|r.get::<_,String>(0)).optional().map_err(err)?{return serde_json::from_str(&raw).map_err(err)}}
  let mut value=rows(c,"SELECT id,name,lower(code) AS code FROM templates WHERE id=?",[id])?.pop().ok_or("Вид исследования не найден")?;
  let code=value["code"].as_str().unwrap_or("").to_string();value["formCode"]=json!(code);value["version"]=versions()[&code].clone();if value["version"].is_null(){value["version"]=json!("1")}
  value["revision"]=json!(0);value["hidden"]=json!(Self::source_template_hidden(c,id)?);value["gender"]=json!(source_gender(c,&code)?);value["options"]=json!({});Ok(value)
 }
 pub fn catalog_settings(&self)->Result<Value,String>{let c=self.open()?;let mut kinds=Vec::new();for t in rows(&c,"SELECT id FROM templates ORDER BY name",[])?{kinds.push(Self::template_settings(&c,t["id"].as_i64().unwrap())?)}let source=catalog();let presets:Vec<Value>=source.as_object().unwrap().keys().filter_map(|key|{let (code,version)=key.rsplit_once('_')?;supported(code,version).then(||json!({"key":key,"code":code,"version":version,"definitions":source[key]}))}).collect();Ok(json!({"templates":kinds,"presets":presets}))}
 pub fn save_catalog_settings(&self,input:CatalogInput)->Result<Value,String>{
  if input.name.trim().is_empty()||input.name.chars().count()>200||!["","M","F"].contains(&input.gender.as_str()){return Err("Укажите название и допустимый пол пациента.".into())}
  if !supported(&input.form_code,&input.version){return Err("Эта форма ещё не перенесена. Выберите доступную форму.".into())}
  let key=format!("{}_{}",input.form_code,input.version);let source=catalog();let defs=source[&key].as_array().ok_or("Форма не найдена")?;
  let opts=input.options.as_object().ok_or("Неверный справочник вариантов")?;
  if input.options.to_string().len()>500_000{return Err("Слишком большой справочник".into())}
  for (field,list) in opts{
   let def=defs.iter().find(|d|d["key"]==field.as_str()).ok_or("Поле формы не найдено")?;
   if !["select","checkbox"].contains(&def["valueType"].as_str().unwrap_or("")){return Err("У поля нет списка вариантов".into())}
   let original=def["options"].as_array().ok_or("Нет исходных вариантов")?;let choices=list.as_array().ok_or("Неверный список вариантов")?;
   if choices.len()>500{return Err("Слишком много вариантов".into())}let mut seen=std::collections::HashSet::new();
   for o in choices{let value=o["value"].as_str().ok_or("Неверный код варианта")?;let base=o["baseValue"].as_str().unwrap_or(value);let label=o["label"].as_str().unwrap_or("");
    if value.is_empty()||value.len()>100||!seen.insert(value)||(label.trim().is_empty()&&!original.iter().any(|o|o["value"]==value&&o["label"]==""))||label.chars().count()>500||!o["hidden"].is_boolean()||!(original.iter().any(|v|v["value"]==base||v["value"]==value&&v.get("baseValue").and_then(Value::as_str)==Some(base))||(base=="__text"&&value.starts_with("custom_")&&def["valueType"]=="select")){return Err("Укажите уникальный вариант, название и допустимое поведение в протоколе.".into())}
    if let Some(old)=original.iter().find(|v|v["value"]==value){if old.get("baseValue").unwrap_or(&old["value"])!=base{return Err("Нельзя изменить исходный смысл существующего варианта.".into())}}
   }
   if def["valueType"]=="checkbox"&&choices.iter().filter(|o|o["hidden"]!=true).count()>1{return Err("Для флажка допустим один действующий вариант.".into())}
   if original.iter().filter(|o|!o["value"].as_str().unwrap_or("").starts_with("preset_")).any(|o|!choices.iter().any(|v|v["value"]==o["value"])){return Err("Исходный вариант можно скрыть, но нельзя удалять.".into())}
  }
  let mut c=self.open()?;let tx=c.transaction().map_err(err)?;tables(&tx)?;
  let (id,code,previous)=if let Some(id)=input.id{let p=Self::template_settings(&tx,id)?;if p["revision"]!=input.revision{return Err("Настройки уже изменились. Откройте их заново.".into())}(id,p["code"].as_str().unwrap_or("").to_string(),p)}else{
   if input.revision!=0{return Err("Неверная версия новых настроек".into())}tx.execute("INSERT INTO templates(name,code) VALUES(?,'')",[input.name.trim()]).map_err(err)?;let id=tx.last_insert_rowid();let code=format!("custom_{id}");tx.execute("UPDATE templates SET code=? WHERE id=?",params![code,id]).map_err(err)?;(id,code,Value::Null)
  };
  let config=json!({"id":id,"code":code,"name":input.name.trim(),"formCode":input.form_code,"version":input.version,"hidden":input.hidden,"gender":input.gender,"options":input.options,"revision":input.revision+1});
  tx.execute("UPDATE templates SET name=? WHERE id=?",params![input.name.trim(),id]).map_err(err)?;
  tx.execute("INSERT INTO template_config VALUES(?,?,?) ON CONFLICT(template_id) DO UPDATE SET revision=excluded.revision,config_json=excluded.config_json",params![id,input.revision+1,config.to_string()]).map_err(err)?;
  tx.execute("INSERT INTO audit(entity,entity_id,previous_json,saved_at) VALUES('template_config',?,?,datetime('now'))",params![id,previous.to_string()]).map_err(err)?;crate::security::audit(&tx,"catalog_save",id)?;
  Self::sync_template_sections(&tx,id,input.name.trim(),&code)?;tx.commit().map_err(err)?;Ok(config)
 }
 pub(crate) fn sync_template_sections(c:&Connection,kind:i64,name:&str,code:&str)->Result<(),String>{
  c.execute_batch("CREATE TABLE IF NOT EXISTS user_template_tree(id INTEGER PRIMARY KEY,node_json TEXT NOT NULL)").map_err(err)?;let mut nodes=Self::user_templates_from(c)?;
  for (key,label) in [("BASE.DECISION","Заключительные признаки"),("CONFIG.ADDITION","Дополнения и рекомендации"),("CONFIG.USERS_PARAMS","Параметры протокола")]{
   let root=service_node(c,&mut nodes,0,0,key,label)?;
   let branch=format!("{key}.{code}");let parent=service_node(c,&mut nodes,kind,root,&branch,name)?;
   if key=="CONFIG.USERS_PARAMS"{let form=Self::current_form(c,kind)?;if let Some(defs)=form["definitions"].as_array(){for d in defs{let field=d["key"].as_str().unwrap_or("");let field_kind=d["kind"].as_str().unwrap_or("");if field_kind=="get"||field_kind.contains("TextArea"){service_node(c,&mut nodes,kind,parent,&format!("{branch}.{field}"),d["label"].as_str().unwrap_or(field))?;}if let Some(options)=d["options"].as_array(){for option in options{if let Some(section)=option["referenceSection"].as_str(){service_node(c,&mut nodes,kind,parent,&format!("{branch}.{section}"),d["label"].as_str().unwrap_or(section))?;}}}}}}
  }Ok(())
 }
 pub(crate) fn current_form(c:&Connection,id:i64)->Result<Value,String>{let config=Self::template_settings(c,id)?;Self::form_from_config(&config)}
 fn form_from_config(config:&Value)->Result<Value,String>{Self::configured_form(config,false)}
 fn configured_form(config:&Value,original:bool)->Result<Value,String>{
  let code=config["formCode"].as_str().unwrap_or("");let version=config["version"].as_str().unwrap_or("1");let key=format!("{code}_{version}");
  let patch=if original{None}else{crate::form_revisions::revision(code,version)};
  let mut definitions=if original{original_catalog()[&key].clone()}else{catalog()[&key].clone()};
  if let Some(defs)=definitions.as_array_mut(){for d in defs{let field=d["key"].as_str().unwrap().to_string();if let Some(opts)=config["options"].get(&field){d["options"]=if patch.is_some_and(|p|p["fields"][&field]["options"].is_array()){crate::form_revisions::options(&d["options"],opts,&original_catalog()[&key].as_array().and_then(|ds|ds.iter().find(|d|d["key"]==field)).map(|d|d["options"].clone()).unwrap_or(Value::Null))}else{opts.clone()}}}}else{definitions=json!([])}
  let mut form=json!({"code":config["formCode"],"version":config["version"],"definitions":definitions,"configurationRevision":config["revision"]});
  if let Some(patch)=patch{form["editor"]=patch["editor"].clone();form["presetRevision"]=patch["revision"].clone();}Ok(form)
 }
 pub(crate) fn canonical_form_fields(fields:&mut Value,form:&Value){
  for (key,field) in fields.as_object_mut().unwrap(){field.as_object_mut().unwrap().remove("label");field.as_object_mut().unwrap().remove("baseValue");field.as_object_mut().unwrap().remove("caption");
   if let Some(option)=form["definitions"].as_array().and_then(|defs|defs.iter().find(|d|d["key"]==key.as_str())).and_then(|d|d["options"].as_array()).and_then(|opts|opts.iter().find(|o|o["value"]==field["value"])){field["label"]=option["label"].clone();if let Some(def)=form["definitions"].as_array().and_then(|defs|defs.iter().find(|d|d["key"]==key.as_str())){field["type"]=def["valueType"].clone();field["caption"]=json!(match def["group"].as_str(){Some(group) if !group.is_empty()&&def["label"]!=group=>format!("{} · {}",group,def["label"].as_str().unwrap_or(key)),_=>def["label"].as_str().unwrap_or(key).to_string()});}field["baseValue"]=option.get("baseValue").unwrap_or(&option["value"]).clone();}
  }
 }
 pub fn sync_catalog_sections(&self)->Result<(),String>{let mut c=self.open()?;let tx=c.transaction().map_err(err)?;for kind in rows(&tx,"SELECT id,name,lower(code) AS code FROM templates",[])?{Self::sync_template_sections(&tx,kind["id"].as_i64().unwrap(),kind["name"].as_str().unwrap(),kind["code"].as_str().unwrap())?;}crate::security::audit(&tx,"catalog_sync",0)?;tx.commit().map_err(err)}
 pub(crate) fn load_form_snapshot(c:&Connection,fields:&Value)->Result<Option<Value>,String>{if let Some(hash)=fields["_form_ref"]["value"].as_str(){if exists(c,"form_snapshots")?{let raw=c.query_row("SELECT snapshot_json FROM form_snapshots WHERE hash=?",[hash],|r|r.get::<_,String>(0)).optional().map_err(err)?;if let Some(raw)=raw{return serde_json::from_str(&raw).map(Some).map_err(err)}}return Err("Не найден сохранённый снимок формы. Восстановите полную резервную копию базы.".into())}Ok(None)}
 pub(crate) fn save_form_snapshot(c:&Connection,fields:&mut Value,form:&Value)->Result<(),String>{tables(c)?;let raw=form.to_string();let hash=format!("{:x}",Sha256::digest(raw.as_bytes()));c.execute("INSERT OR IGNORE INTO form_snapshots VALUES(?,?)",params![hash,raw]).map_err(err)?;fields["_form_ref"]=json!({"type":"meta","value":hash});Ok(())}
 pub(crate) fn original_form(c:&Connection,study:&Value)->Result<Value,String>{let code=c.query_row("SELECT lower(code) FROM templates WHERE id=?",[study["template_id"].as_i64().unwrap_or(0)],|r|r.get::<_,String>(0)).optional().map_err(err)?.unwrap_or_default();Self::configured_form(&json!({"formCode":code,"version":study["legacy_version"].as_str().unwrap_or("1"),"revision":0,"options":{}}),true)}
}
