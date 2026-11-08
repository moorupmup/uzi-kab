use std::{fs::{File,OpenOptions},path::Path};
pub struct DatabaseLock{_file:File}
impl DatabaseLock{
    pub fn acquire(database:&Path)->std::io::Result<Self>{
        let mut options=OpenOptions::new();options.read(true).write(true).create(true);
        #[cfg(windows)]{use std::os::windows::fs::OpenOptionsExt;options.share_mode(0);}
        Ok(Self{_file:options.open(database.with_extension("lock"))?})
    }
}
#[cfg(all(test,windows))]mod tests{use super::*;#[test]fn one_instance_per_database(){let path=std::env::temp_dir().join(format!("uzi-lock-{}.db",std::process::id()));let first=DatabaseLock::acquire(&path).unwrap();assert!(DatabaseLock::acquire(&path).is_err());drop(first);assert!(DatabaseLock::acquire(&path).is_ok());std::fs::remove_file(path.with_extension("lock")).unwrap();}}
