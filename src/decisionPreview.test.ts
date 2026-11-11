import {it,expect} from 'vitest'
import {DatabaseSync} from 'node:sqlite'
import {readFileSync} from 'node:fs'
import {decisionReader} from '../tools/decisionReader'
import {reportReader} from '../tools/reportReader'
import {archiveReader} from '../tools/archiveReader'
it('reads original decision references before migration and explicit saved overrides afterwards',()=>{
 const db=new DatabaseSync(':memory:');db.exec(readFileSync(new URL('../src-tauri/schema.sql',import.meta.url),'utf8'));db.exec(readFileSync(new URL('../src-tauri/extended.sql',import.meta.url),'utf8'))
 db.exec("INSERT INTO patients(id,name,search_name,gender) VALUES(1,'Тест','тест','F');INSERT INTO doctors VALUES(1,'Врач',0);INSERT INTO templates VALUES(1,'УЗИ','universal');CREATE TABLE legacy_book_users(id,research_id,name,key_name,level_id,position,status_hidden,status_root,value);INSERT INTO legacy_book_users VALUES(1,0,'Признаки','BASE.DECISION',0,0,0,1,''),(10,1,'УЗИ','BASE.DECISION.universal',1,0,0,1,''),(100,1,'Ветвь','',10,0,0,1,''),(101,1,'Прежняя группа','',100,0,0,0,'');CREATE TABLE legacy_protocol(id,decision_id);INSERT INTO legacy_protocol VALUES(1,101),(2,0);INSERT INTO studies(id,patient_id,date,template_id,doctor_id,title,conclusion,addition,fields_json,legacy_version,origin,status) VALUES(1,1,'2026-11-08',1,1,'УЗИ','Текст','','{}','1','legacy','legacy:1'),(2,1,'2026-11-08',1,1,'УЗИ','Прежняя группа написана в тексте','','{}','1','legacy','legacy:1');CREATE TABLE user_template_tree(id,node_json)")
 db.prepare('INSERT INTO user_template_tree VALUES(?,?)').run(101,JSON.stringify({id:101,templateId:1,name:'Новое имя',parentId:100,key:'',hidden:false,deleted:false,folder:false,value:'Новое имя',revision:1}))
 const decisions=decisionReader(db),reader=reportReader(db),changes=db.prepare('SELECT total_changes() AS n').get()!.n
 expect(archiveReader(db).study(1).decision).toMatchObject({id:101,caption:'Признаки / УЗИ / Ветвь / Прежняя группа'})
 expect(archiveReader(db).study(2).decision).toBeNull()
 expect(decisions.options().groups.some(g=>g.caption.endsWith('Новое имя'))).toBe(true)
 const before=reader.statistics('2026-11-08','2026-11-08',{byDecisions:true})
 expect(before.byDecision).toHaveLength(2)
 expect(before.byDecision!.some(r=>r.name==='Без группы'&&r.count===1)).toBe(true)
 expect(reader.statistics('2026-11-08','2026-11-08',{byDecisions:true,branchId:100}).summary!.studies).toBe(1)
 for(const row of before.byDecision!)expect(reader.details('2026-11-08','2026-11-08',{decisionId:Number(row.id),decisionCaption:String(row.name)}).total).toBe(row.count)
 expect(db.prepare('SELECT total_changes() AS n').get()!.n).toBe(changes)
 const snapshot=decisions.get({id:1,origin:'legacy'})!
 db.exec('CREATE TABLE decision_snapshots(hash TEXT PRIMARY KEY,entry_id INTEGER,caption TEXT,ancestor_ids_json TEXT,snapshot_json TEXT);CREATE TABLE study_decisions(study_id INTEGER PRIMARY KEY,snapshot_hash TEXT)')
 db.prepare('INSERT INTO decision_snapshots VALUES(?,?,?,?,?)').run('original',101,snapshot.caption,JSON.stringify([1,10,100]),JSON.stringify(snapshot));db.exec("INSERT INTO study_decisions VALUES(1,'original'),(2,NULL)")
 expect(reader.statistics('2026-11-08','2026-11-08',{byDecisions:true}).byDecision).toEqual(before.byDecision)
 db.exec('UPDATE study_decisions SET snapshot_hash=NULL WHERE study_id=1')
 expect(archiveReader(db).study(1).decision).toBeNull();expect(reader.statistics('2026-11-08','2026-11-08',{byDecisions:true}).byDecision).toEqual([{id:0,name:'Без группы',count:2}])
 db.close()
})
