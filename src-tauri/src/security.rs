use crate::repository::{Database,err,rows};
use argon2::{Argon2,PasswordHasher,PasswordVerifier,password_hash::{SaltString,PasswordHash}};
use rand_core::OsRng;
use rusqlite::{params,OptionalExtension,TransactionBehavior};
use serde::{Deserialize,Serialize};
use serde_json::{Value,json};
use std::{sync::Mutex,time::{Instant,Duration}};
thread_local!{static ACTOR:std::cell::Cell<Option<i64>>=const{std::cell::Cell::new(None)};}
pub struct ActorScope(Option<i64>);
impl ActorScope{pub fn new(id:i64)->Self{Self(ACTOR.with(|a|a.replace(Some(id))))}}
impl Drop for ActorScope{fn drop(&mut self){ACTOR.with(|a|a.set(self.0));}}
pub fn audit(tx:&rusqlite::Transaction<'_>,action:&str,id:i64)->Result<(),String>{
    if let Some(actor)=ACTOR.with(|a|a.get()){tx.execute("INSERT INTO access_audit(actor_id,action,entity_id) VALUES(?,?,?)",params![actor,action,id]).map_err(err)?;}Ok(())
}

#[derive(Clone,Serialize)]
#[serde(rename_all="camelCase")]
pub struct User {pub id:i64,pub username:String,pub name:String,pub role:String,pub doctor_id:Option<i64>}
struct Session{user:User,hash:String,last:Instant}
pub struct Security{session:Mutex<Option<Session>>,failures:Mutex<(u32,Instant)>}
impl Default for Security{fn default()->Self{Self{session:Mutex::new(None),failures:Mutex::new((0,Instant::now()))}}}
#[derive(Clone,Copy)]pub enum Permission{Read,Write,Admin}
#[derive(Deserialize)]
#[serde(rename_all="camelCase")]
pub struct AccountInput{pub id:Option<i64>,pub revision:Option<i64>,pub username:String,pub name:String,pub role:String,pub doctor_id:Option<i64>,pub enabled:bool,pub password:Option<String>}

fn hash(password:&str)->Result<String,String>{
    if password.chars().count()<10||password.len()>1024{return Err("Пароль должен содержать от 10 символов (не более 1024 байт).".into())}
    Argon2::default().hash_password(password.as_bytes(),&SaltString::generate(&mut OsRng)).map(|v|v.to_string()).map_err(err)
}
fn validate(input:&AccountInput)->Result<(),String>{
    if input.username.len()<3||input.username.len()>64||!input.username.chars().all(|c|c.is_ascii_alphanumeric()||"._-".contains(c)){return Err("Логин: 3–64 латинских буквы, цифры, точка, дефис или подчёркивание.".into())}
    if input.name.trim().is_empty()||input.name.len()>200{return Err("Укажите имя пользователя.".into())}
    if !["admin","doctor","viewer"].contains(&input.role.as_str()){return Err("Неизвестная роль.".into())}
    if input.role=="doctor"&&input.doctor_id.is_none(){return Err("Свяжите учётную запись с врачом.".into())}
    Ok(())
}
impl Security{
    pub fn logout(&self){if let Ok(mut session)=self.session.lock(){*session=None}}
    pub fn user(&self,db:&Database)->Result<Option<User>,String>{
        let mut session=self.session.lock().map_err(err)?;
        let Some(saved)=session.as_mut() else{return Ok(None)};
        if saved.last.elapsed()>Duration::from_secs(30*60){*session=None;return Ok(None)}
        let c=db.open()?;
        let live=c.query_row("SELECT username,display_name,role,doctor_id,password_hash FROM app_users WHERE id=? AND enabled=1",[saved.user.id],|r|Ok((r.get::<_,String>(0)?,r.get::<_,String>(1)?,r.get::<_,String>(2)?,r.get::<_,Option<i64>>(3)?,r.get::<_,String>(4)?))).optional().map_err(err)?;
        let Some((username,name,role,doctor_id,password_hash))=live else{*session=None;return Ok(None)};
        if username!=saved.user.username||password_hash!=saved.hash||role!=saved.user.role||doctor_id!=saved.user.doctor_id{*session=None;return Ok(None)}
        saved.user.name=name;saved.user.role=role;saved.user.doctor_id=doctor_id;saved.last=Instant::now();Ok(Some(saved.user.clone()))
    }
    pub fn require(&self,db:&Database,permission:Permission)->Result<User,String>{
        let user=self.user(db)?.ok_or("AUTH_REQUIRED: Войдите в программу")?;
        if matches!(permission,Permission::Admin)&&user.role!="admin"||matches!(permission,Permission::Write)&&user.role=="viewer"{return Err("Недостаточно прав для этого действия.".into())}
        Ok(user)
    }
    pub fn status(&self,db:&Database)->Result<Value,String>{
        let count:i64=db.open()?.query_row("SELECT count(*) FROM app_users",[],|r|r.get(0)).map_err(err)?;
        Ok(json!({"setupRequired":count==0,"user":self.user(db)?}))
    }
    pub fn setup(&self,db:&Database,input:AccountInput)->Result<User,String>{
        validate(&input)?;let password_hash=hash(input.password.as_deref().unwrap_or(""))?;
        let mut c=db.open()?;let tx=c.transaction_with_behavior(TransactionBehavior::Immediate).map_err(err)?;
        let count:i64=tx.query_row("SELECT count(*) FROM app_users",[],|r|r.get(0)).map_err(err)?;
        if count!=0{return Err("Первый администратор уже создан. Войдите в программу.".into())}
        tx.execute("INSERT INTO app_users(username,display_name,password_hash,role,enabled) VALUES(?,?,?,'admin',1)",params![input.username,input.name.trim(),password_hash]).map_err(err)?;
        let user=User{id:tx.last_insert_rowid(),username:input.username,name:input.name.trim().into(),role:"admin".into(),doctor_id:None};
        tx.execute("INSERT INTO access_audit(actor_id,action) VALUES(?,'setup_admin')",[user.id]).map_err(err)?;tx.commit().map_err(err)?;
        *self.session.lock().map_err(err)?=Some(Session{user:user.clone(),hash:password_hash,last:Instant::now()});Ok(user)
    }
    pub fn login(&self,db:&Database,username:&str,password:&str)->Result<User,String>{
        if password.len()>1024||username.len()>64{return Err("Неверный логин или пароль.".into())}
        {let mut failure=self.failures.lock().map_err(err)?;if failure.1.elapsed()>Duration::from_secs(60){*failure=(0,Instant::now())}if failure.0>=5{return Err("Слишком много попыток. Повторите вход через минуту.".into())}}
        let c=db.open()?;
        let row=c.query_row("SELECT id,username,display_name,role,doctor_id,password_hash FROM app_users WHERE username=? COLLATE NOCASE AND enabled=1",[username.trim()],|r|Ok((User{id:r.get(0)?,username:r.get(1)?,name:r.get(2)?,role:r.get(3)?,doctor_id:r.get(4)?},r.get::<_,String>(5)?))).optional().map_err(err)?;
        let accepted=row.as_ref().map(|(_,h)|PasswordHash::new(h).map(|p|Argon2::default().verify_password(password.as_bytes(),&p).is_ok()).unwrap_or(false)).unwrap_or(false);
        if !accepted{if row.is_none(){let _=Argon2::default().hash_password(password.as_bytes(),&SaltString::generate(&mut OsRng));}let mut failure=self.failures.lock().map_err(err)?;failure.0+=1;return Err("Неверный логин или пароль.".into())}
        let (user,password_hash)=row.unwrap();*self.session.lock().map_err(err)?=Some(Session{user:user.clone(),hash:password_hash,last:Instant::now()});*self.failures.lock().map_err(err)?=(0,Instant::now());db.audit_event(user.id,"login",None,"")?;Ok(user)
    }
}
impl Database{
    pub fn users(&self)->Result<Value,String>{Ok(json!(rows(&self.open()?,"SELECT id,username,display_name AS name,role,doctor_id AS doctorId,enabled,revision FROM app_users ORDER BY display_name",[])?))}
    pub fn save_account(&self,input:AccountInput,actor:i64)->Result<i64,String>{
        validate(&input)?;let password_hash=match input.password.as_deref(){Some(p) if !p.is_empty()=>Some(hash(p)?),_=>None};
        let mut c=self.open()?;let tx=c.transaction_with_behavior(TransactionBehavior::Immediate).map_err(err)?;
        if let Some(doctor)=input.doctor_id{let n:i64=tx.query_row("SELECT count(*) FROM doctors WHERE id=? AND hidden=0",[doctor],|r|r.get(0)).map_err(err)?;if n!=1{return Err("Врач не найден.".into())}}
        let id=if let Some(id)=input.id{
            let other_admins:i64=tx.query_row("SELECT count(*) FROM app_users WHERE role='admin' AND enabled=1 AND id<>?",[id],|r|r.get(0)).map_err(err)?;
            if other_admins==0&&(!input.enabled||input.role!="admin"){return Err("Нельзя отключить последнего администратора.".into())}
            let changed=tx.execute("UPDATE app_users SET username=?,display_name=?,role=?,doctor_id=?,enabled=?,password_hash=COALESCE(?,password_hash),revision=revision+1 WHERE id=? AND revision=?",params![input.username,input.name.trim(),input.role,input.doctor_id,input.enabled,password_hash,id,input.revision]).map_err(err)?;
            if changed!=1{return Err("Учётная запись изменилась. Обновите список.".into())}id
        }else{
            let password_hash=password_hash.ok_or("Укажите пароль новой учётной записи")?;
            tx.execute("INSERT INTO app_users(username,display_name,password_hash,role,doctor_id,enabled) VALUES(?,?,?,?,?,?)",params![input.username,input.name.trim(),password_hash,input.role,input.doctor_id,input.enabled]).map_err(err)?;tx.last_insert_rowid()
        };
        tx.execute("INSERT INTO access_audit(actor_id,action,entity_id) VALUES(?,'save_user',?)",params![actor,id]).map_err(err)?;tx.commit().map_err(err)?;Ok(id)
    }
    pub fn change_password(&self,user:i64,old:&str,new:&str)->Result<(),String>{
        let c=self.open()?;let old_hash:String=c.query_row("SELECT password_hash FROM app_users WHERE id=?",[user],|r|r.get(0)).map_err(err)?;
        if !PasswordHash::new(&old_hash).map(|h|Argon2::default().verify_password(old.as_bytes(),&h).is_ok()).unwrap_or(false){return Err("Текущий пароль указан неверно.".into())}
        let new_hash=hash(new)?;let changed=c.execute("UPDATE app_users SET password_hash=?,revision=revision+1 WHERE id=? AND password_hash=?",params![new_hash,user,old_hash]).map_err(err)?;
        if changed!=1{return Err("Пароль уже изменился. Выполните вход заново.".into())}Ok(())
    }
}

#[cfg(test)]mod tests{
    use super::*;
    #[test]fn accounts_permissions_and_revocation(){let folder=std::env::temp_dir().join(format!("uzi-auth-{}",std::process::id()));std::fs::create_dir_all(&folder).unwrap();let db=Database::new(folder.join("uzi.db"));let c=rusqlite::Connection::open(&db.path).unwrap();c.execute_batch(include_str!("../schema.sql")).unwrap();c.execute_batch(include_str!("../extended.sql")).unwrap();c.pragma_update(None,"user_version",2).unwrap();drop(c);let security=Security::default();let input=AccountInput{id:None,revision:None,username:"admin".into(),name:"Administrator".into(),role:"admin".into(),doctor_id:None,enabled:true,password:Some("Synthetic-test-123".into())};let admin=security.setup(&db,input).unwrap();assert!(security.require(&db,Permission::Admin).is_ok());let viewer=db.save_account(AccountInput{id:None,revision:None,username:"viewer".into(),name:"Reader".into(),role:"viewer".into(),doctor_id:None,enabled:true,password:Some("Synthetic-test-456".into())},admin.id).unwrap();security.logout();assert!(security.require(&db,Permission::Read).is_err());assert!(security.login(&db,"viewer","bad").is_err());security.login(&db,"viewer","Synthetic-test-456").unwrap();assert!(security.require(&db,Permission::Read).is_ok());assert!(security.require(&db,Permission::Write).is_err());db.open().unwrap().execute("UPDATE app_users SET enabled=0 WHERE id=?",[viewer]).unwrap();assert!(security.require(&db,Permission::Read).is_err());std::fs::remove_dir_all(folder).unwrap();}
}
