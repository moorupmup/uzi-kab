import type {DatabaseSync} from 'node:sqlite'
import catalog from '../src/catalog.json'
import {decisionReader} from './decisionReader'
type Row=Record<string,unknown>
export function archiveReader(db:DatabaseSync){
 const all=(sql:string,...args:(string|number)[])=>db.prepare(sql).all(...args) as Row[]
 const one=(sql:string,...args:(string|number)[])=>db.prepare(sql).get(...args) as Row|undefined
 const table=(name:string)=>Boolean(one("SELECT name FROM sqlite_master WHERE type='table' AND name=?",name))
 const decode=(v:unknown)=>v instanceof Uint8Array?new TextDecoder('windows-1251').decode(v):String(v??'')
 function study(id:number):Row{
  const s=one("SELECT s.*,COALESCE(d.name,'Не указан') AS doctor,COALESCE(p.name,'Без карточки пациента') AS patientName,p.birthdate AS patientBirthdate,t.code AS templateCode FROM studies s LEFT JOIN patients p ON p.id=s.patient_id LEFT JOIN doctors d ON d.id=s.doctor_id LEFT JOIN templates t ON t.id=s.template_id WHERE s.id=?",id)
  if(!s)throw Error('Исследование не найдено')
  s.decision=decisionReader(db).get(s)
  s.doctorCurrentName=s.doctor
  const signature=table('study_signatures')?one('SELECT name FROM study_signatures WHERE study_id=? AND doctor_id=?',id,Number(s.doctor_id)):undefined
  if(signature)s.doctor=signature.name
  const fields=JSON.parse(String(s.fields_json)) as Record<string,{value:string}>
  s.fields=fields
  if(fields._form_ref){const saved=table('form_snapshots')?one('SELECT snapshot_json FROM form_snapshots WHERE hash=?',fields._form_ref.value):undefined;if(!saved)throw Error('Не найден сохранённый снимок формы');s.formSnapshot=JSON.parse(String(saved.snapshot_json))}
  else{const code=String(s.templateCode||'').toLowerCase(),version=String(s.legacy_version||'1');s.formSnapshot={code,version,configurationRevision:0,definitions:(catalog as Record<string,unknown>)[code+'_'+version]||[]}}
  delete s.fields_json;return s
 }
 function state(id:number):Row{const saved=table('bundle_state')?one('SELECT deleted,revision,origin FROM bundle_state WHERE bundle_id=?',id):undefined;return saved?{...saved,deleted:Boolean(saved.deleted)}:{deleted:false,revision:1,origin:'native'}}
 function virtualLegacy(patient?:number):Row[]{
  if(!table('legacy_container')||!table('legacy_research'))return []
  const mapped=table('legacy_bundle_map')?new Set(all('SELECT source_id FROM legacy_bundle_map').map(r=>Number(r.source_id))):new Set<number>()
  return all('SELECT c.* FROM legacy_container c'+(patient===undefined?'':' WHERE c.pacient_id=?')+' ORDER BY c.id DESC',...(patient===undefined?[]:[patient])).filter(c=>!mapped.has(Number(c.id))).map(c=>({id:-Number(c.id),patient_id:c.pacient_id,name:decode(c.name),createdAt:c.create_date,count:Number(one('SELECT count(*) AS n FROM legacy_research WHERE container_id=?',Number(c.id))?.n||0),origin:'legacy',deleted:false,revision:1,actor_id:null}))
 }
 function bundles(patient:number):Row[]{const native=table('study_bundles')?all('SELECT b.id,b.name,b.created_at AS createdAt,(SELECT count(*) FROM bundle_items i WHERE i.bundle_id=b.id) AS count FROM study_bundles b WHERE b.patient_id=? ORDER BY b.id DESC',patient).map(b=>({...b,...state(Number(b.id))})):[];return [...native,...virtualLegacy(patient)]}
 function bundle(id:number){
  const b=id<0?virtualLegacy().find(b=>b.id===id):one('SELECT b.*,p.name AS patientName FROM study_bundles b JOIN patients p ON p.id=b.patient_id WHERE b.id=?',id)
  if(!b)throw Error('Объединённый протокол не найден')
  if(id>=0)Object.assign(b,state(id));else b.patientName=one('SELECT name FROM patients WHERE id=?',Number(b.patient_id))?.name
  const ids=id<0?all('SELECT protocol_id AS id FROM legacy_research WHERE container_id=? ORDER BY protocol_id,legacy_research.id',-id):all('SELECT study_id AS id FROM bundle_items WHERE bundle_id=? ORDER BY position,study_id',id)
  const studies:Row[]=[],issues:{studyId:number;message:string}[]=[];let canPrint=!b.deleted&&ids.length>0
  for(const row of ids){const studyId=Number(row.id);try{const s=study(studyId),status=String(s.status);studies.push(s)
   if(s.patient_id!==b.patient_id){canPrint=false;issues.push({studyId,message:'Пациент исследования не совпадает с пациентом комплекта.'})}
   if(['deleted','legacy:2'].includes(status)){canPrint=false;issues.push({studyId,message:'Исследование удалено. Для печати восстановите его либо создайте другой комплект.'})}
   else if(!['final','legacy:1'].includes(status)){if(b.origin!=='legacy')canPrint=false;issues.push({studyId,message:'Исследование не завершено. Архивный состав сохранён; документ имеет отметку черновика.'})}
   const prior=id>=0&&table('bundle_item_revisions')?one('SELECT revision FROM bundle_item_revisions WHERE bundle_id=? AND study_id=?',id,studyId):undefined
   if(prior&&prior.revision!==s.revision)issues.push({studyId,message:'Исследование изменено после формирования комплекта. Проверьте текущий документ.'})
  }catch(e){canPrint=false;issues.push({studyId,message:'Документ не удалось открыть: '+(e instanceof Error?e.message:String(e))})}}
  return {bundle:b,studies,issues,canPrint}
 }
 return {study,bundles,bundle}
}
