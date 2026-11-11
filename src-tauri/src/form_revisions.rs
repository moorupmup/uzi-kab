use serde_json::{json,Value};

pub fn revision(code:&str,version:&str)->Option<&'static Value>{
 static DATA:std::sync::OnceLock<Value>=std::sync::OnceLock::new();
 let patch=&DATA.get_or_init(||serde_json::from_str(include_str!("../../src/form-revisions.json")).unwrap())[code];
 patch["versions"].as_array()?.iter().any(|v|v==version).then_some(patch)
}
pub fn catalog(mut source:Value)->Value{
 for (key,definitions) in source.as_object_mut().unwrap(){
  let Some((code,version))=key.rsplit_once('_') else{continue};
  let Some(patch)=revision(code,version) else{continue};
  for field in definitions.as_array_mut().unwrap(){
   let key=field["key"].as_str().unwrap().to_string();
   if let Some(properties)=patch["fields"][&key].as_object(){for (name,value) in properties{field[name]=value.clone();}}
   if patch["hiddenFields"].as_array().unwrap().iter().any(|v|v==&key){field["hidden"]=json!(true);}
  }
 }
 source
}

// Rebase a locally configured list onto the shipped defaults, preserving custom
// labels and additions. Retired codes remain present but hidden.
pub fn options(defaults:&Value,saved:&Value,legacy:&Value)->Value{
 let Some(defaults)=defaults.as_array() else{return saved.clone()};
 let Some(saved)=saved.as_array() else{return json!(defaults)};
 let mut result=Vec::new();
 for default in defaults{
  let mut option=default.clone();
  if let Some(local)=saved.iter().find(|o|o["value"]==default["value"]){
   let old=legacy.as_array().and_then(|list|list.iter().find(|o|o["value"]==default["value"]));
   if old.is_none_or(|old|old["label"]!=local["label"]){option["label"]=local["label"].clone();}
   if default["hidden"]!=true{option["hidden"]=local["hidden"].clone();}
  }
  result.push(option);
 }
 result.extend(saved.iter().filter(|o|!defaults.iter().any(|d|d["value"]==o["value"])).cloned());
 json!(result)
}
