import aliases from './legacy-reference-aliases.json'

export interface UserTemplate {id:number;templateId:number;name:string;key:string;parentId:number;hidden:boolean;folder:boolean;value:string;revision?:number;deleted?:boolean;position?:number;includeInPhrase?:boolean}
export interface TemplatePhrasePart {id:number;text:string;checked:boolean}

export function templatePhraseParts(entry:UserTemplate,path:UserTemplate[],sectionId:number):TemplatePhrasePart[]{
 const boundary=path.findIndex(node=>node.id===sectionId)
 const folders=boundary<0?[]:path.slice(boundary+1).filter(node=>!node.key)
 return [
  ...folders.map(node=>({id:node.id,text:node.name,checked:node.includeInPhrase!==false})),
  {id:entry.id,text:entry.value||entry.name,checked:true},
 ].filter(part=>part.text.trim())
}

export function composeTemplate(parts:TemplatePhrasePart[],selected:number[]){
 const chosen=new Set(selected)
 return parts.filter(part=>chosen.has(part.id)).reduce((phrase,part)=>{
  const text=part.text.trim()
  return text.startsWith(',')?phrase.replace(/(?<!\.)\.$/,'')+text:appendTemplate(phrase,text)
 },'')
}

export function templateFieldSection(formKey:string,fieldKey:string){
 return (aliases as Record<string,Record<string,string>>)[formKey]?.[fieldKey]??fieldKey
}

export function findTemplateSection(entries:UserTemplate[],key:string,templateId:number){
 const normalized=key.toLowerCase()
 return entries.find(entry=>entry.folder&&entry.key.toLowerCase()===normalized&&entry.templateId===templateId)
   ??entries.find(entry=>entry.folder&&entry.key.toLowerCase()===normalized&&!entry.templateId)
}

export function templateSectionRows(entries:UserTemplate[],section:UserTemplate|undefined,templateId:number,showHidden:boolean){
 if(!section)return []
 return entries.filter(entry=>!entry.folder&&(!entry.templateId||entry.templateId===templateId))
   .map(entry=>({entry,path:templatePath(entry,entries)}))
   .filter(({entry,path})=>path.some(parent=>parent.id===section.id)&&visibleTemplate(entry,path,showHidden,false))
}

export function templatePath(entry:UserTemplate,entries:UserTemplate[]){
  const path:UserTemplate[]=[];const seen=new Set([entry.id]);let parent=entries.find(e=>e.id===entry.parentId)
  while(parent&&!seen.has(parent.id)){path.unshift(parent);seen.add(parent.id);parent=entries.find(e=>e.id===parent!.parentId)}
  return path
}
export const appendTemplate=(current:string,text:string)=>current ? current+(/\s$/.test(current)||/^\s/.test(text)?'':' ')+text : text

export function sectionItems(entries:UserTemplate[],templateId:number,showHidden=false,showDeleted=false){
 return entries.filter(e=>e.folder).map(e=>({entry:e,path:templatePath(e,entries)})).filter(({entry:e,path})=>(!templateId||[e,...path].every(p=>!p.templateId||p.templateId===templateId))&&(showHidden||![e,...path].some(p=>p.hidden))&&(showDeleted||![e,...path].some(p=>p.deleted))).map(({entry:e,path})=>({label:[...path,e].map(p=>p.name).join(' / '),value:e.id}))
}
export function visibleTemplate(entry:UserTemplate,path:UserTemplate[],showHidden:boolean,showDeleted:boolean){return (showHidden||![entry,...path].some(e=>e.hidden))&&(showDeleted||![entry,...path].some(e=>e.deleted))}
