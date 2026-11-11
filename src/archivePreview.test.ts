import {it,expect} from 'vitest'
import {DatabaseSync} from 'node:sqlite'
import {readFileSync} from 'node:fs'
import {archiveReader} from '../tools/archiveReader'
it('reads unmigrated and migrated legacy bundles without writing or losing source order',()=>{
 const db=new DatabaseSync(':memory:')
 db.exec(readFileSync(new URL('../src-tauri/schema.sql',import.meta.url),'utf8'))
 db.exec(readFileSync(new URL('../src-tauri/extended.sql',import.meta.url),'utf8'))
 db.exec("INSERT INTO patients(id,name,search_name,gender) VALUES(1,'Тест','тест','F');INSERT INTO doctors VALUES(1,'Врач',0);INSERT INTO templates VALUES(1,'УЗИ','universal');INSERT INTO studies(id,patient_id,date,template_id,doctor_id,title,conclusion,addition,fields_json,legacy_version,origin,status) VALUES(1,1,'2026-11-08',1,1,'УЗИ','Первый','','{}','1','legacy','legacy:1'),(2,1,'2026-11-08',1,1,'УЗИ','Второй','','{}','1','legacy','legacy:0');CREATE TABLE legacy_container(id,create_date,pacient_id,name);CREATE TABLE legacy_research(id,container_id,protocol_id);INSERT INTO legacy_container VALUES(1,'2013-01-01',1,X'D3C7C8');INSERT INTO legacy_research VALUES(1,1,2),(2,1,1)")
 const reader=archiveReader(db),changes=db.prepare('SELECT total_changes() AS n').get()!.n
 expect(reader.bundles(1)[0]).toMatchObject({id:-1,name:'УЗИ',origin:'legacy',count:2})
 const before=reader.bundle(-1)
 expect(before.studies.map(s=>s.id)).toEqual([1,2]);expect(before.canPrint).toBe(true);expect(before.issues).toHaveLength(1)
 expect(db.prepare('SELECT total_changes() AS n').get()!.n).toBe(changes)
 db.exec("INSERT INTO study_bundles(id,patient_id,name) VALUES(5,1,'УЗИ');INSERT INTO bundle_items VALUES(5,1,0),(5,2,1);CREATE TABLE legacy_bundle_map(source_id,bundle_id);INSERT INTO legacy_bundle_map VALUES(1,5);CREATE TABLE bundle_state(bundle_id,deleted,revision,origin);INSERT INTO bundle_state VALUES(5,0,1,'legacy');CREATE TABLE bundle_item_revisions(bundle_id,study_id,revision);INSERT INTO bundle_item_revisions VALUES(5,1,1),(5,2,1)")
 expect(reader.bundles(1)).toHaveLength(1);expect(reader.bundle(5).studies.map(s=>s.id)).toEqual([1,2])
 db.exec("UPDATE studies SET status='deleted',revision=2 WHERE id=2")
 expect(reader.bundle(5).canPrint).toBe(false);expect(reader.bundle(5).studies).toHaveLength(2)
 expect(reader.bundle(5).issues).toHaveLength(2)
 db.exec('CREATE TABLE form_snapshots(hash TEXT PRIMARY KEY,snapshot_json TEXT)')
 const snapshot={code:'brooho',version:'1',definitions:[],configurationRevision:2}
 db.prepare('INSERT INTO form_snapshots VALUES(?,?)').run('saved',JSON.stringify(snapshot))
 db.prepare('UPDATE studies SET fields_json=? WHERE id=1').run(JSON.stringify({_form_ref:{value:'saved',type:'meta'}}))
 expect(reader.study(1).formSnapshot).toEqual(snapshot)
 db.exec("DELETE FROM form_snapshots WHERE hash='saved'")
 expect(()=>reader.study(1)).toThrow('Не найден сохранённый снимок формы')
 expect(reader.bundle(5).canPrint).toBe(false);expect(reader.bundle(5).issues.some(i=>i.studyId===1&&i.message.includes('снимок формы'))).toBe(true)
 db.close()
})
