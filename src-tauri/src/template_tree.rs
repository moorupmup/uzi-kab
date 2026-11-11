use crate::repository::{Database,err};
use rusqlite::{Connection,params};
use serde::Deserialize;
use serde_json::{Value,json};
use std::collections::{HashMap,HashSet};
#[derive(Deserialize)]#[serde(rename_all="camelCase")]
pub struct TreeInput{pub action:String,pub id:Option<i64>,pub revision:Option<i64>,pub parent_id:Option<i64>,pub template_id:Option<i64>,pub text:Option<String>,pub folder:Option<bool>,pub direction:Option<String>,pub deleted:Option<bool>}
fn id(e:&Value)->i64{e["id"].as_i64().unwrap()}
fn parent(e:&Value)->i64{e["parentId"].as_i64().unwrap_or(0)}
fn revision(e:&Value)->i64{e["revision"].as_i64().unwrap_or(0)}
fn position(e:&Value)->i64{e["position"].as_i64().unwrap_or(0)}
fn ensure_tables(c:&Connection)->Result<(),String>{c.execute_batch("CREATE TABLE IF NOT EXISTS user_template_changes(id INTEGER PRIMARY KEY,text TEXT NOT NULL,deleted INTEGER NOT NULL DEFAULT 0,revision INTEGER NOT NULL);CREATE TABLE IF NOT EXISTS user_template_entries(id INTEGER PRIMARY KEY CHECK(id<0),template_id INTEGER NOT NULL REFERENCES templates(id),parent_id INTEGER NOT NULL);CREATE TABLE IF NOT EXISTS user_template_tree(id INTEGER PRIMARY KEY,node_json TEXT NOT NULL);").map_err(err)}
fn descendants(nodes:&[Value],root:i64)->HashSet<i64>{let mut found=HashSet::from([root]);loop{let before=found.len();for e in nodes{if found.contains(&parent(e)){found.insert(id(e));}}if found.len()==before{return found}}}
fn target(nodes:&[Value],parent_id:i64,template_id:i64,forbidden:&HashSet<i64>)->Result<(),String>{
 if parent_id==0{return Err("Выберите раздел справочника.".into())}
 let map:HashMap<i64,&Value>=nodes.iter().map(|e|(id(e),e)).collect();let mut cursor=parent_id;let mut seen=HashSet::new();
 while cursor!=0{if forbidden.contains(&cursor)||!seen.insert(cursor){return Err("Нельзя переместить раздел внутрь себя или его подраздела.".into())}
 let e=map.get(&cursor).ok_or("Раздел не найден. Обновите справочник.")?;
 if e["hidden"]==true||e["deleted"]==true{return Err("Выберите действующий раздел.".into())}
 let kind=e["templateId"].as_i64().unwrap_or(0);if kind!=0&&kind!=template_id{return Err("Раздел относится к другому виду исследования.".into())}cursor=parent(e);
 }Ok(())
}
impl Database{
 pub fn mutate_template_tree(&self,input:TreeInput)->Result<Value,String>{
  let mut c=self.open()?;let tx=c.transaction().map_err(err)?;let mut nodes=Self::user_templates_from(&tx)?;let original=nodes.clone();let mut changed=HashSet::new();let mut result_id=input.id.unwrap_or(0);
  let index=if let Some(key)=input.id{Some(nodes.iter().position(|e|id(e)==key).ok_or("Запись справочника не найдена.")?)}else{None};
  if let Some(i)=index{if input.revision!=Some(revision(&nodes[i])){return Err("Запись справочника уже изменилась. Обновите список и повторите действие.".into())}
   if !nodes[i]["key"].as_str().unwrap_or("").is_empty(){return Err("Служебный раздел защищён. Управляйте его пользовательскими подразделами.".into())}}
  let text=input.text.as_deref().unwrap_or("");if ["create","edit"].contains(&input.action.as_str())&&(text.trim().is_empty()||text.len()>100_000){return Err("Введите текст допустимой длины.".into())}
  if ["create","edit"].contains(&input.action.as_str())&&(input.folder==Some(true)||index.is_some_and(|i|nodes[i]["folder"]==true))&&text.chars().count()>500{return Err("Название раздела должно содержать не более 500 символов.".into())}
  match input.action.as_str(){
   "create"=>{
    let kind=input.template_id.ok_or("Выберите вид исследования.")?;let p=input.parent_id.ok_or("Выберите раздел.")?;
    let exists:i64=tx.query_row("SELECT count(*) FROM templates WHERE id=?",[kind],|r|r.get(0)).map_err(err)?;
    if exists!=1||Self::template_hidden(&tx,kind)?{return Err("Выберите действующий вид исследования.".into())}
    target(&nodes,p,kind,&HashSet::new())?;
    result_id=nodes.iter().map(id).min().unwrap_or(0).min(0)-1;
    let rank=nodes.iter().filter(|e|parent(e)==p).map(position).min().unwrap_or(1)-1;
    if let Some(e)=nodes.iter_mut().find(|e|id(e)==p){if e["folder"]!=true{if !e["key"].as_str().unwrap_or("").is_empty(){return Err("Служебная запись не может стать пользовательским разделом.".into())}e["folder"]=json!(true);changed.insert(p);}}
    nodes.push(json!({"id":result_id,"templateId":kind,"parentId":p,"name":text,"value":text,"key":"","folder":input.folder.unwrap_or(false),"hidden":false,"deleted":false,"revision":0,"position":rank}));changed.insert(result_id);
   }
   "edit"|"delete"|"restore"=>{
    let i=index.ok_or("Выберите запись.")?;
    if input.action=="edit"{nodes[i]["name"]=json!(text);nodes[i]["value"]=json!(text);if let Some(deleted)=input.deleted{nodes[i]["deleted"]=json!(deleted)}}
    if input.action=="delete"{nodes[i]["deleted"]=json!(true)}
    if input.action=="restore"{nodes[i]["deleted"]=json!(false);nodes[i]["hidden"]=json!(false)}
    changed.insert(id(&nodes[i]));
   }
   "move"|"copy"=>{
    let i=index.ok_or("Выберите запись.")?;let root=id(&nodes[i]);let subtree=descendants(&nodes,root);let p=input.parent_id.ok_or("Выберите раздел.")?;let kind=input.template_id.ok_or("Выберите вид исследования.")?;
    let exists:i64=tx.query_row("SELECT count(*) FROM templates WHERE id=?",[kind],|r|r.get(0)).map_err(err)?;
    if exists!=1||Self::template_hidden(&tx,kind)?{return Err("Выберите действующий вид исследования.".into())}
    let empty=HashSet::new();target(&nodes,p,kind,if input.action=="move"{&subtree}else{&empty})?;
    if nodes.iter().any(|e|subtree.contains(&id(e))&&!e["key"].as_str().unwrap_or("").is_empty()){return Err("Ветвь содержит служебные разделы и защищена от переноса.".into())}
    if let Some(e)=nodes.iter_mut().find(|e|id(e)==p){if e["folder"]!=true{if !e["key"].as_str().unwrap_or("").is_empty(){return Err("Служебная запись не может стать пользовательским разделом.".into())}e["folder"]=json!(true);changed.insert(p);}}
    let rank=nodes.iter().filter(|e|parent(e)==p).map(position).min().unwrap_or(1)-1;
    if input.action=="move"{for e in &mut nodes{if subtree.contains(&id(e)){e["templateId"]=json!(kind);if id(e)==root{e["parentId"]=json!(p);e["position"]=json!(rank)}changed.insert(id(e));}}}
    else{
     let mut next=nodes.iter().map(id).min().unwrap_or(0).min(0)-1;let mut remap=HashMap::new();for e in &nodes{if subtree.contains(&id(e)){remap.insert(id(e),next);next-=1;}}
     let mut added=Vec::new();for e in &nodes{if subtree.contains(&id(e)){let mut copy=e.clone();let old=id(e);copy["id"]=json!(remap[&old]);copy["parentId"]=json!(if old==root{p}else{remap[&parent(e)]});copy["templateId"]=json!(kind);copy["revision"]=json!(0);if old==root{copy["position"]=json!(rank)}changed.insert(id(&copy));added.push(copy)}}result_id=remap[&root];nodes.extend(added);
    }
   }
   "order"=>{
    let i=index.ok_or("Выберите запись.")?;let p=parent(&nodes[i]);let mut siblings:Vec<usize>=(0..nodes.len()).filter(|&n|parent(&nodes[n])==p&&nodes[n]["deleted"]!=true&&nodes[n]["hidden"]!=true).collect();siblings.sort_by_key(|&n|(position(&nodes[n]),id(&nodes[n])));
    let n=siblings.iter().position(|&n|n==i).ok_or("Скрытую запись нельзя упорядочить.")?;
    let other=match input.direction.as_deref(){Some("up") if n>0=>Some(n-1),Some("down") if n+1<siblings.len()=>Some(n+1),Some("up"|"down")=>None,_=>return Err("Неизвестное направление.".into())};
    if let Some(other)=other{siblings.swap(n,other);for (rank,&n) in siblings.iter().enumerate(){nodes[n]["position"]=json!((rank as i64+1)*10);changed.insert(id(&nodes[n]));}}
   }
   _=>return Err("Неизвестное действие со справочником.".into())
  }
  ensure_tables(&tx)?;
  for e in &mut nodes{if !changed.contains(&id(e)){continue}let key=id(e);let previous=original.iter().find(|e|id(e)==key);e["revision"]=json!(previous.map(revision).unwrap_or(0)+1);
   tx.execute("INSERT INTO user_template_tree(id,node_json) VALUES(?,?) ON CONFLICT(id) DO UPDATE SET node_json=excluded.node_json",params![key,e.to_string()]).map_err(err)?;
   let text=if e["folder"]==true{e["name"].as_str().unwrap_or("")}else{e["value"].as_str().filter(|s|!s.is_empty()).unwrap_or(e["name"].as_str().unwrap_or(""))};
   tx.execute("INSERT INTO user_template_changes(id,text,deleted,revision) VALUES(?,?,?,?) ON CONFLICT(id) DO UPDATE SET text=excluded.text,deleted=excluded.deleted,revision=excluded.revision",params![key,text,e["deleted"]==true,revision(e)]).map_err(err)?;
   if key<0&&e["folder"]!=true{tx.execute("INSERT INTO user_template_entries(id,template_id,parent_id) VALUES(?,?,?) ON CONFLICT(id) DO UPDATE SET template_id=excluded.template_id,parent_id=excluded.parent_id",params![key,e["templateId"].as_i64(),parent(e)]).map_err(err)?;}
   tx.execute("INSERT INTO audit(entity,entity_id,previous_json,saved_at) VALUES('user_template',?,?,datetime('now'))",params![key,previous.unwrap_or(&Value::Null).to_string()]).map_err(err)?;
  }
  if !changed.is_empty(){crate::security::audit(&tx,&format!("template_{}",input.action),result_id)?;}
  nodes.sort_by_key(|e|(position(e),id(e)));
  let entry=nodes.iter().find(|e|id(e)==result_id).cloned();tx.commit().map_err(err)?;Ok(json!({"entry":entry,"entries":nodes}))
 }
}
#[cfg(test)]mod tests{
 use super::*;
 fn fixture()->Database{let root=std::env::temp_dir().join(format!("uzi-tree-{}",chrono::Utc::now().timestamp_nanos_opt().unwrap()));std::fs::create_dir_all(&root).unwrap();let db=Database::new(root.join("uzi.db"));let c=Connection::open(&db.path).unwrap();c.execute_batch(include_str!("../schema.sql")).unwrap();c.execute_batch(include_str!("../extended.sql")).unwrap();c.execute_batch("PRAGMA user_version=2;INSERT INTO templates VALUES(80,'УЗИ','brooho'),(18,'Щитовидная','shit');CREATE TABLE legacy_book_users(id,research_id,name,key_name,level_id,position,status_hidden,status_root,value);INSERT INTO legacy_book_users VALUES(1,0,'Заключения','BASE.DECISION',0,1,0,1,''),(2,80,'УЗИ','BASE.DECISION.brooho',1,1,0,1,''),(3,80,'Группа','',2,1,0,1,''),(4,80,'Старый текст','',3,1,0,0,''),(5,18,'Щитовидная','BASE.DECISION.shit',1,2,0,1,'');").unwrap();drop(c);db}
 fn action(db:&Database,v:Value)->Result<Value,String>{db.mutate_template_tree(serde_json::from_value(v).unwrap()).map(|v|v["entry"].clone())}
 fn node(db:&Database,key:i64)->Value{db.user_templates().unwrap().as_array().unwrap().iter().find(|n|n["id"]==key).unwrap().clone()}
 fn create(db:&Database,parent:i64,text:&str,folder:bool)->Value{action(db,json!({"action":"create","parentId":parent,"templateId":80,"text":text,"folder":folder})).unwrap()}
 fn clean(db:Database){std::fs::remove_dir_all(db.path.parent().unwrap()).unwrap()}
 #[test]fn nested_nodes_move_copy_preserve_source_and_reject_cycles_and_stale_updates(){
  let db=fixture();assert!(action(&db,json!({"action":"create","parentId":3,"templateId":80,"text":"Я".repeat(501),"folder":true})).unwrap_err().contains("500"));let group=create(&db,3,"Новый раздел",true);let g=id(&group);let leaf=create(&db,g,"Новый текст",false);let l=id(&leaf);
  assert_eq!(node(&db,l)["parentId"],g);
  assert!(action(&db,json!({"action":"move","id":g,"revision":1,"parentId":l,"templateId":80})).unwrap_err().contains("внутрь"));
  action(&db,json!({"action":"move","id":g,"revision":1,"parentId":5,"templateId":18})).unwrap();assert_eq!(node(&db,g)["parentId"],5);assert_eq!(node(&db,l)["templateId"],18);assert_eq!(node(&db,l)["revision"],2);
  assert!(db.save_user_template(l,1,"Затереть",false).unwrap_err().contains("изменилась"));
  let copy=action(&db,json!({"action":"copy","id":g,"revision":2,"parentId":2,"templateId":80})).unwrap();assert_ne!(id(&copy),g);let all=db.user_templates().unwrap();let child=all.as_array().unwrap().iter().find(|n|n["parentId"]==id(&copy)).unwrap();assert_ne!(id(child),l);assert_eq!(child["templateId"],80);assert_eq!(child["value"],"Новый текст");
  let c=db.open().unwrap();assert_eq!(c.query_row("SELECT count(*) FROM legacy_book_users",[],|r|r.get::<_,i64>(0)).unwrap(),5);assert_eq!(c.query_row("SELECT name FROM legacy_book_users WHERE id=3",[],|r|r.get::<_,String>(0)).unwrap(),"Группа");drop(c);clean(db)
 }
 #[test]fn restore_parent_does_not_restore_separately_deleted_child_and_order_survives_reopen(){
  let db=fixture();let a=create(&db,3,"А",false);let b=create(&db,3,"Б",false);
  action(&db,json!({"action":"order","id":id(&a),"revision":1,"direction":"up"})).unwrap();assert!(position(&node(&db,id(&a)))<position(&node(&db,id(&b))));
  let child=node(&db,id(&a));action(&db,json!({"action":"delete","id":id(&child),"revision":revision(&child)})).unwrap();
  action(&db,json!({"action":"delete","id":3,"revision":0})).unwrap();assert_eq!(node(&db,4)["deleted"],false);
  action(&db,json!({"action":"restore","id":3,"revision":1})).unwrap();assert_eq!(node(&db,id(&a))["deleted"],true);assert_eq!(node(&db,4)["deleted"],false);
  assert!(action(&db,json!({"action":"edit","id":1,"revision":0,"text":"Сломать ключ"})).unwrap_err().contains("защищён"));
  let path=db.backup().unwrap();let c=Connection::open(path).unwrap();assert!(c.query_row("SELECT count(*) FROM user_template_tree",[],|r|r.get::<_,i64>(0)).unwrap()>=3);drop(c);clean(db)
 }
 #[test]fn leaf_can_become_parent_without_changing_its_original_text(){let db=fixture();let child=create(&db,4,"Дочерняя запись",false);assert_eq!(node(&db,4)["folder"],true);assert_eq!(node(&db,4)["value"],"");assert_eq!(node(&db,4)["name"],"Старый текст");assert_eq!(child["parentId"],4);clean(db)}
}
