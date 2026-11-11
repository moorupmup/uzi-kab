import type {DatabaseSync} from 'node:sqlite'
import {readFileSync} from 'node:fs'
import {resolve} from 'node:path'
import {decisionReader} from './decisionReader'
type Row=Record<string,unknown>
interface Filter{templateId?:number|null;doctorIds?:number[];month?:string|null;title?:string|null;byDecisions?:boolean;decisionId?:number|null;decisionCaption?:string|null;branchId?:number|null}
const clause=readFileSync(resolve('src-tauri/reports-filter.sql'),'utf8')
export function reportReader(db:DatabaseSync){
 const decisions=decisionReader(db)
 const all=(sql:string,...args:(string|number|null)[])=>db.prepare(sql).all(...args) as Row[]
 const one=(sql:string,...args:(string|number|null)[])=>db.prepare(sql).get(...args) as Row|undefined
 const table=(name:string)=>Boolean(one("SELECT name FROM sqlite_master WHERE type='table' AND name=?",name))
 function parameters(from:string,to:string,filter:Filter={}){
  const valid=(value:string)=>/^\d{4}-\d{2}-\d{2}$/.test(value)&&Number.isFinite(Date.parse(value+'T00:00:00Z'))&&new Date(value+'T00:00:00Z').toISOString().slice(0,10)===value
  if(!valid(from)||!valid(to)||from>to)throw Error('Проверьте период отчёта')
  const ids=filter.doctorIds??[]
  if(filter.branchId===0||filter.branchId!=null&&!Number.isSafeInteger(filter.branchId)||filter.decisionId!=null&&!Number.isSafeInteger(filter.decisionId)||filter.decisionCaption!=null&&(typeof filter.decisionCaption!=='string'||Buffer.byteLength(filter.decisionCaption)>500_000))throw Error('Некорректный фильтр заключений')
  if(!Array.isArray(ids)||ids.length>200||ids.some(id=>!Number.isSafeInteger(id)||id<0)||filter.templateId!=null&&(!Number.isSafeInteger(filter.templateId)||filter.templateId<0)||filter.title!=null&&(typeof filter.title!=='string'||Buffer.byteLength(filter.title)>1000))throw Error('Некорректные фильтры отчёта')
  if(filter.month!=null&&!/^\d{4}-\d{2}$/.test(filter.month)||filter.month!=null&&!valid(filter.month+'-01'))throw Error('Проверьте месяц отчёта')
  const next=new Date(to+'T00:00:00Z');next.setUTCDate(next.getUTCDate()+1)
  return [from,to==='9999-12-31'?'9999-12-32':next.toISOString().slice(0,10),filter.templateId??null,JSON.stringify(ids),filter.month??null,filter.title??null,filter.decisionId??null,filter.decisionCaption??null,filter.branchId??null]
 }
 function snapshot<T>(read:()=>T):T{db.exec('BEGIN');try{const result=read();db.exec('COMMIT');return result}catch(e){db.exec('ROLLBACK');throw e}}
 function statistics(from:string,to:string,filters:Filter={}){const args=parameters(from,to,filters),decisionJoin=decisions.join();return snapshot(()=>({...(filters.byDecisions?{byDecision:all(`SELECT COALESCE(sd.entry_id,0) AS id,COALESCE(sd.caption,'Без группы') AS name,count(*) AS count FROM studies s ${decisionJoin} ${clause} GROUP BY COALESCE(sd.entry_id,0),COALESCE(sd.caption,'Без группы') ORDER BY count DESC,name`,...args)}:{}),summary:one(`SELECT count(*) AS studies,count(distinct s.patient_id) AS patients FROM studies s ${decisionJoin} ${clause}`,...args),byType:all(`SELECT s.template_id AS id,s.title AS name,count(*) AS count FROM studies s ${decisionJoin} ${clause} GROUP BY s.template_id,s.title ORDER BY count DESC,s.template_id,s.title`,...args),byDoctor:all(`SELECT s.doctor_id AS id,COALESCE(d.name,'Не указан') AS name,count(*) AS count FROM studies s LEFT JOIN doctors d ON d.id=s.doctor_id ${decisionJoin} ${clause} GROUP BY s.doctor_id ORDER BY count DESC,s.doctor_id`,...args),byMonth:all(`SELECT substr(s.date,1,7) AS name,count(*) AS count FROM studies s ${decisionJoin} ${clause} GROUP BY substr(s.date,1,7) ORDER BY name`,...args)}))}
 function details(from:string,to:string,filters:Filter={},page=0,pageSize=50){const decisionJoin=decisions.join(),args=parameters(from,to,filters),size=Math.max(1,Math.min(500,pageSize));const signature=table('study_signatures')?"COALESCE((SELECT ss.name FROM study_signatures ss WHERE ss.study_id=s.id AND ss.doctor_id=s.doctor_id),d.name,'Врач не указан')":"COALESCE(d.name,'Врач не указан')";return snapshot(()=>({total:one(`SELECT count(*) AS n FROM studies s ${decisionJoin} ${clause}`,...args)!.n,items:all(`SELECT s.id,s.patient_id AS patientId,p.name AS patientName,COALESCE(p.hidden,0) AS patientHidden,s.date,s.title,s.template_id AS templateId,s.doctor_id AS doctorId,${signature} AS doctor,s.status,COALESCE(sd.entry_id,0) AS decisionId,COALESCE(sd.caption,'Без группы') AS decisionCaption,substr(s.conclusion,1,300) AS conclusionPreview FROM studies s LEFT JOIN patients p ON p.id=s.patient_id LEFT JOIN doctors d ON d.id=s.doctor_id ${decisionJoin} ${clause} ORDER BY s.date DESC,s.id DESC LIMIT ?10 OFFSET ?11`,...args,size,Math.max(0,Math.min(100000,page))*size)}))}
 function options(){const kinds=all('SELECT id,name FROM templates ORDER BY name').map(t=>{const config=table('template_config')?one('SELECT config_json FROM template_config WHERE template_id=?',Number(t.id)):undefined;return {...t,hidden:config?Boolean(JSON.parse(String(config.config_json)).hidden):table('legacy_book')?Boolean(one('SELECT status_hidden FROM legacy_book WHERE id=?',Number(t.id))?.status_hidden):false}});return {templates:kinds,doctors:all('SELECT id,name,hidden FROM doctors ORDER BY name,id')}}
 return {statistics,details,options}
}
