import type {DatabaseSync} from 'node:sqlite'
import {templateReader} from './templateReader'
import type {UserTemplate} from '../src/userTemplates'
import type {ConclusionGroup} from '../src/types'
export function decisionSnapshot(nodes:UserTemplate[],id:number,activeKind?:number):ConclusionGroup{
 const map=new Map(nodes.map(n=>[n.id,n])),path:UserTemplate[]=[],seen=new Set<number>();let cursor=id,templateId=0
 while(cursor){if(seen.has(cursor)||seen.size>=512)throw Error('В справочнике обнаружена циклическая ветвь');seen.add(cursor);const n=map.get(cursor);if(!n)throw Error('Группа заключения отсутствует в исходном справочнике')
  if(activeKind!==undefined&&(n.hidden||n.deleted||n.templateId&&n.templateId!==activeKind))throw Error('Группа недоступна для нового назначения')
  if(!templateId)templateId=n.templateId;path.push(n);cursor=n.parentId
 }
 path.reverse();if(path[0]?.key!=='BASE.DECISION'||path.length<2||activeKind!==undefined&&path.at(-1)?.key)throw Error('Выберите пользовательскую группу заключения')
 return {id,templateId,caption:path.map(p=>p.name).join(' / '),path:path.map(p=>({id:p.id,name:p.name}))}
}
export function decisionReader(db:DatabaseSync){
 const all=(sql:string,...args:(string|number)[])=>db.prepare(sql).all(...args)
 const one=(sql:string,...args:(string|number)[])=>db.prepare(sql).get(...args)
 const table=(name:string)=>Boolean(one("SELECT name FROM sqlite_master WHERE type='table' AND name=?",name))
 const source=()=>table('legacy_protocol')&&all('PRAGMA table_info(legacy_protocol)').some(r=>r.name==='decision_id')
 let raw:UserTemplate[]|undefined;const snapshots=new Map<number,ConclusionGroup>()
 function original(id:number){if(!snapshots.has(id))snapshots.set(id,decisionSnapshot(raw??=templateReader(db,true),id));return snapshots.get(id)!}
 function get(study:Record<string,unknown>):ConclusionGroup|null{
  if(table('study_decisions')){const saved=one('SELECT d.snapshot_hash,g.snapshot_json FROM study_decisions d LEFT JOIN decision_snapshots g ON g.hash=d.snapshot_hash WHERE d.study_id=?',Number(study.id));if(saved){if(saved.snapshot_hash==null)return null;if(!saved.snapshot_json)throw Error('Снимок группы заключения отсутствует');return JSON.parse(String(saved.snapshot_json))}}
  if(study.origin==='legacy'&&source()){const id=Number(one('SELECT decision_id FROM legacy_protocol WHERE id=?',Number(study.id))?.decision_id||0);if(id)return original(id)}return null
 }
 function join(){
  if(table('study_decisions'))return 'LEFT JOIN (SELECT d.study_id,g.entry_id,g.caption,g.ancestor_ids_json FROM study_decisions d LEFT JOIN decision_snapshots g ON g.hash=d.snapshot_hash) sd ON sd.study_id=s.id'
  if(source()){
   db.function('archive_decision_caption',{deterministic:true},id=>Number(id)?original(Number(id)).caption:null)
   db.function('archive_decision_ancestors',{deterministic:true},id=>Number(id)?JSON.stringify(original(Number(id)).path.filter(p=>p.id!==Number(id)).map(p=>p.id)):'[]')
   return "LEFT JOIN (SELECT p.id AS study_id,NULLIF(p.decision_id,0) AS entry_id,archive_decision_caption(p.decision_id) AS caption,archive_decision_ancestors(p.decision_id) AS ancestor_ids_json FROM legacy_protocol p) sd ON sd.study_id=s.id AND s.origin='legacy'"
  }
  return 'LEFT JOIN (SELECT NULL AS study_id,NULL AS entry_id,NULL AS caption,NULL AS ancestor_ids_json WHERE 0) sd ON 0'
 }
 function options(){const nodes=templateReader(db),groups:ConclusionGroup[]=[],branches:ConclusionGroup[]=[],seen=new Set<number>()
  for(const n of nodes){let s:ConclusionGroup;try{s=decisionSnapshot(nodes,n.id)}catch{continue}seen.add(n.id);branches.push(s);try{decisionSnapshot(nodes,n.id,s.templateId);groups.push(s)}catch{/* Only active assignments are offered. */}}
  const history:ConclusionGroup[]=table('decision_snapshots')?all('SELECT snapshot_json FROM decision_snapshots ORDER BY hash').map(r=>JSON.parse(String(r.snapshot_json))):source()?all("SELECT DISTINCT p.decision_id FROM legacy_protocol p JOIN studies s ON s.id=p.id WHERE s.origin='legacy' AND p.decision_id<>0 ORDER BY p.decision_id").map(r=>original(Number(r.decision_id))):[]
  for(const s of history){const path:ConclusionGroup['path']=[];for(const item of s.path){path.push(item);if(path.length>1&&!seen.has(item.id)){seen.add(item.id);branches.push({id:item.id,templateId:s.templateId,caption:path.map(p=>p.name).join(' / '),path:[...path],archived:true})}}}
  const sort=(a:ConclusionGroup,b:ConclusionGroup)=>a.caption<b.caption?-1:a.caption>b.caption?1:0;return {groups:groups.sort(sort),branches:branches.sort(sort)}
 }
 return {get,join,options}
}
