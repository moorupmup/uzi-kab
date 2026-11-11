import type {DatabaseSync} from 'node:sqlite'
import type {UserTemplate} from '../src/userTemplates'
export function templateReader(db:DatabaseSync,original=false):UserTemplate[]{
 const all=(sql:string)=>db.prepare(sql).all()
 const table=(name:string)=>Boolean(db.prepare("SELECT name FROM sqlite_master WHERE type='table' AND name=?").get(name))
 const decode=(v:unknown)=>v instanceof Uint8Array?new TextDecoder('windows-1251').decode(v):String(v??'')
 let entries:UserTemplate[]=table('legacy_book_users')?all('SELECT * FROM legacy_book_users ORDER BY position,id').map(r=>({id:Number(r.id),templateId:Number(r.research_id),name:decode(r.name),key:decode(r.key_name),parentId:Number(r.level_id),position:Number(r.position),hidden:Boolean(r.status_hidden),folder:Boolean(r.status_root),value:decode(r.value),revision:0,deleted:false})):[]
 if(original)return entries
 if(table('user_template_entries'))entries=[...all("SELECT n.id,n.template_id AS templateId,n.parent_id AS parentId,c.text AS name,c.text AS value,c.revision,c.deleted,'' AS key FROM user_template_entries n JOIN user_template_changes c ON c.id=n.id").map(e=>({...e,hidden:false,folder:false,position:0,deleted:Boolean(e.deleted)}) as unknown as UserTemplate),...entries]
 if(table('user_template_changes'))for(const change of all('SELECT * FROM user_template_changes')){const e=entries.find(e=>e.id===change.id);if(e)Object.assign(e,{value:change.text,revision:change.revision,deleted:Boolean(change.deleted)})}
 if(table('user_template_tree'))for(const row of all('SELECT node_json FROM user_template_tree')){const node=JSON.parse(String(row.node_json)) as UserTemplate,at=entries.findIndex(e=>e.id===node.id);if(at<0)entries.push(node);else entries[at]=node}
 return entries.sort((a,b)=>(a.position||0)-(b.position||0)||a.id-b.id)
}
