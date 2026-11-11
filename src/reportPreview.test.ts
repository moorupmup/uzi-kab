import {it,expect} from 'vitest'
import {DatabaseSync} from 'node:sqlite'
import {readFileSync} from 'node:fs'
import {reportReader} from '../tools/reportReader'
it('uses the same SQL selection for preview aggregates and each drilldown without changing data',()=>{
 const db=new DatabaseSync(':memory:');db.exec(readFileSync(new URL('../src-tauri/schema.sql',import.meta.url),'utf8'))
 db.exec("PRAGMA foreign_keys=OFF;INSERT INTO patients(id,name,search_name,gender,hidden) VALUES(1,'Тест','тест','F',0),(2,'Скрыт','скрыт','M',1);INSERT INTO doctors VALUES(1,'Текущее имя',0),(2,'Второй врач',1);INSERT INTO templates VALUES(1,'УЗИ','universal'),(2,'Другой вид','shit');INSERT INTO studies(id,patient_id,date,template_id,doctor_id,title,conclusion,addition,fields_json,origin,status) VALUES(1,1,'2026-11-08',1,1,'Прежнее имя','Текст','','{}','native','final'),(2,2,'2026-11-08 23:59:59',1,2,'Прежнее имя','Текст','','{}','legacy','legacy:1'),(3,1,'2026-11-08',2,1,'Другой вид','','','{}','native','draft'),(4,1,'2026-11-08',1,1,'Прежнее имя','','','{}','native','deleted'),(5,0,'2026-11-08',1,1,'Прежнее имя','','','{}','legacy','legacy:1');CREATE TABLE study_signatures(study_id,doctor_id,name);INSERT INTO study_signatures VALUES(1,1,'Историческая подпись');")
 const reader=reportReader(db),changes=db.prepare('SELECT total_changes() AS n').get()!.n
 const stats=reader.statistics('2026-11-08','2026-11-08')
 expect(stats.summary).toEqual({studies:2,patients:2})
 for(const row of stats.byType)expect(reader.details('2026-11-08','2026-11-08',{templateId:Number(row.id),title:String(row.name)}).total).toBe(row.count)
 for(const row of stats.byDoctor)expect(reader.details('2026-11-08','2026-11-08',{doctorIds:[Number(row.id)]}).total).toBe(row.count)
 const selected=reader.details('2026-11-08','2026-11-08',{templateId:1,doctorIds:[1]})
 expect(selected.total).toBe(1);expect(selected.items[0].doctor).toBe('Историческая подпись')
 expect(reader.details('2026-11-08','2026-11-08',{doctorIds:[2]}).items[0].patientHidden).toBe(1)
 expect(reader.options().doctors.some(d=>d.id===2&&d.hidden===1)).toBe(true)
 expect(()=>reader.statistics('2026-02-30','2026-11-08')).toThrow();expect(()=>reader.statistics('2026-11-08','2026-11-08',{doctorIds:[-1]})).toThrow()
 expect(reader.statistics('2026-11-08','2026-11-08',{title:"' OR 1=1 --"}).summary!.studies).toBe(0)
 expect(db.prepare('SELECT total_changes() AS n').get()!.n).toBe(changes);db.close()
})
