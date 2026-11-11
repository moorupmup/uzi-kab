export interface UserTemplate {id:number;templateId:number;name:string;key:string;parentId:number;hidden:boolean;folder:boolean;value:string;revision?:number;deleted?:boolean;position?:number}
export function templatePath(entry:UserTemplate,entries:UserTemplate[]){
  const path:UserTemplate[]=[];const seen=new Set([entry.id]);let parent=entries.find(e=>e.id===entry.parentId)
  while(parent&&!seen.has(parent.id)){path.unshift(parent);seen.add(parent.id);parent=entries.find(e=>e.id===parent!.parentId)}
  return path
}
export const appendTemplate=(current:string,text:string)=>current.trim()?current+'\n'+text:text

export function sectionItems(entries:UserTemplate[],templateId:number,showHidden=false,showDeleted=false){
 return entries.filter(e=>e.folder).map(e=>({entry:e,path:templatePath(e,entries)})).filter(({entry:e,path})=>(!templateId||[e,...path].every(p=>!p.templateId||p.templateId===templateId))&&(showHidden||![e,...path].some(p=>p.hidden))&&(showDeleted||![e,...path].some(p=>p.deleted))).map(({entry:e,path})=>({label:[...path,e].map(p=>p.name).join(' / '),value:e.id}))
}
export function visibleTemplate(entry:UserTemplate,path:UserTemplate[],showHidden:boolean,showDeleted:boolean){return (showHidden||![entry,...path].some(e=>e.hidden))&&(showDeleted||![entry,...path].some(e=>e.deleted))}

// Legacy ReferenceList mode 2 collects names below the opened service section.
// Keep each part selectable: folders can be phrases or merely organisers.
export function templatePhraseParts(entry:UserTemplate,entries:UserTemplate[]){
 const path=[...templatePath(entry,entries),entry]
 let boundary=-1;path.forEach((node,index)=>{if(node.key)boundary=index})
 return path.slice(boundary+1).map(node=>({id:node.id,text:node.value||node.name}))
}
export function composeTemplate(parts:{id:number;text:string}[],selected:number[]){
 const chosen=new Set(selected)
 return parts.filter(part=>chosen.has(part.id)).map(part=>part.text.trim()).filter(Boolean).join(' ')
}
