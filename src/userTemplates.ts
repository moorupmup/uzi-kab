export interface UserTemplate {id:number;templateId:number;name:string;key:string;parentId:number;hidden:boolean;folder:boolean;value:string}
export function templatePath(entry:UserTemplate,entries:UserTemplate[]){
  const path:UserTemplate[]=[];const seen=new Set([entry.id]);let parent=entries.find(e=>e.id===entry.parentId)
  while(parent&&!seen.has(parent.id)){path.unshift(parent);seen.add(parent.id);parent=entries.find(e=>e.id===parent!.parentId)}
  return path
}
export const appendTemplate=(current:string,text:string)=>current.trim()?current+'\n'+text:text
