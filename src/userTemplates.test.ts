import {readFileSync} from 'node:fs'
import {runInNewContext} from 'node:vm'
import {describe,it,expect} from 'vitest'
import {templatePath,appendTemplate,sectionItems,visibleTemplate,templatePhraseParts,composeTemplate,type UserTemplate} from './userTemplates'
const entry=(id:number,parentId:number,name:string):UserTemplate=>({id,parentId,name,templateId:0,key:'',hidden:false,folder:true,value:''})
describe('Recovered template library',()=>{
 it('preserves nested section names and handles damaged parent cycles',()=>{
 const entries=[entry(1,0,'Заключения'),entry(2,1,'Печень'),entry(3,2,'Заготовка')]
 expect(templatePath(entries[2],entries).map(e=>e.name)).toEqual(['Заключения','Печень'])
 entries[0].parentId=3
 expect(templatePath(entries[2],entries).map(e=>e.id)).toEqual([1,2])
 })
 it('appends without replacing the doctor’s existing text',()=>{
 expect(appendTemplate('Введённый текст','Заготовка')).toBe('Введённый текст\nЗаготовка')
 expect(appendTemplate('','Заготовка')).toBe('Заготовка')
 })
})

it('hides descendants of deleted sections and preserves individually deleted children',()=>{
 const folder={id:1,parentId:0,name:'Раздел',templateId:80,key:'',hidden:false,folder:true,value:'',deleted:true}
 const child={...folder,id:2,parentId:1,folder:false,deleted:false}
 expect(visibleTemplate(child,templatePath(child,[folder,child]),false,false)).toBe(false)
 expect(visibleTemplate(child,templatePath(child,[folder,child]),false,true)).toBe(true)
 const separatelyDeleted={...child,deleted:true};folder.deleted=false
 expect(visibleTemplate(separatelyDeleted,[folder],false,false)).toBe(false)
 expect(sectionItems([folder,{...folder,id:3,parentId:1,templateId:18}],80).map(i=>i.value)).toEqual([1])
})

it('composes selectable clinical parts below the service boundary, matching source mode 2',()=>{
 const entries=[{...entry(1,0,'Заключительные признаки'),key:'BASE.DECISION'},{...entry(2,1,'УЗИ'),key:'BASE.DECISION.universal'},entry(3,2,'Очаговое образование'),entry(4,3,'по типу гемангиомы')]
 const parts=templatePhraseParts(entries[3],entries)
 expect(parts.map(p=>p.id)).toEqual([3,4])
 const source=readFileSync('legacy/reference.js','latin1')
 const old=runInNewContext(source+`;var result={value:''};var r=new ReferenceList();r.setBookMode(2);r.setEditElement(result);r.getRowIndex=function(){return 1};r.headerIndexOf=function(key){return key};r.getRow=function(){return {name:'по типу гемангиомы',status_root:'0'}};r.close=function(){};stek[0]='Очаговое образование';stek[1]='3';count=2;r.done();result.value;`,{})
 expect(composeTemplate(parts,[3,4])).toBe(old.trim())
 expect(composeTemplate(parts,[4])).toBe('по типу гемангиомы')
 expect(composeTemplate(parts,[999])).toBe('')
 entries[2].value='Уточнённая фраза'
 expect(composeTemplate(templatePhraseParts(entries[3],entries),[3,4])).toBe('Уточнённая фраза по типу гемангиомы')
})
