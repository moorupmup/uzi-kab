import {readFileSync,readdirSync} from 'node:fs'
import {describe,it,expect} from 'vitest'
import catalog from './catalog.json'
import type {FieldDefinition} from './types'
import {templatePath,appendTemplate,sectionItems,visibleTemplate,templateFieldSection,findTemplateSection,templateSectionRows,templatePhraseParts,composeTemplate,type UserTemplate} from './userTemplates'
const entry=(id:number,parentId:number,name:string):UserTemplate=>({id,parentId,name,templateId:0,key:'',hidden:false,folder:true,value:''})
describe('Recovered template library',()=>{
 it('preserves nested section names and handles damaged parent cycles',()=>{
 const entries=[entry(1,0,'Заключения'),entry(2,1,'Печень'),entry(3,2,'Заготовка')]
 expect(templatePath(entries[2],entries).map(e=>e.name)).toEqual(['Заключения','Печень'])
 entries[0].parentId=3
 expect(templatePath(entries[2],entries).map(e=>e.id)).toEqual([1,2])
 })
 it('appends without replacing the doctor’s existing text',()=>{
 expect(appendTemplate('Введённый текст','Заготовка')).toBe('Введённый текст Заготовка')
 expect(appendTemplate('','Заготовка')).toBe('Заготовка')
 })
 it('uses the original dictionary location for every legacy textarea',()=>{
  const files=new Map(readdirSync('legacy/definitions').map(file=>[file.toLowerCase(),file]))
  for(const [form,fields] of Object.entries(catalog as Record<string,FieldDefinition[]>)){
   const textFields=fields.filter(field=>field.valueType==='textarea_users')
   if(!textFields.length)continue
   const file=files.get(`${form}.properties`)
   const legacy=readFileSync(`legacy/definitions/${file}`,'latin1')
   const locations=new Map([...legacy.matchAll(/^([^\s#!][^=\r\n]*)\s*=\s*textarea_users\s*,\s*([^,\s]+)/gm)].map(([,key,location])=>[key.trim(),location]))
   for(const field of textFields)expect(templateFieldSection(form,field.key),`${form}.${field.key}`).toBe(locations.get(field.key))
  }
 })
 it('shows only descendants of the exact field branch of the selected study kind',()=>{
  const entries=[
   {...entry(1,0,'Почки'),key:'CONFIG.USERS_PARAMS.POCHKI.POCHKA_TEXT',templateId:22},
   {...entry(2,0,'Другая ветка'),key:'CONFIG.ADDITION.POCHKA_TEXT',templateId:22},
   {...entry(3,0,'Другой вид'),key:'CONFIG.USERS_PARAMS.BROOHO.POCHKA_TEXT',templateId:80},
   entry(4,1,'Подраздел'),
   {...entry(5,4,'Нужная фраза'),folder:false},
   {...entry(6,2,'Другая ветка'),folder:false},
   {...entry(7,3,'Другой вид'),folder:false,templateId:80},
   {...entry(8,1,'Скрыто'),folder:false,hidden:true},
   {...entry(9,1,'Удалено'),folder:false,deleted:true},
  ]
  const key='config.users_params.pochki.pochka_text'
  const section=findTemplateSection(entries,key,22)
  expect(templateSectionRows(entries,section,22,false).map(({entry})=>entry.id)).toEqual([5])
  expect(templateSectionRows(entries,section,22,true).map(({entry})=>entry.id)).toEqual([5,8])
  expect(findTemplateSection(entries,key,80)).toBeUndefined()
  expect(templateSectionRows(entries,undefined,22,false)).toEqual([])
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

it('composes chosen fragments below the service branch and joins a leading comma',()=>{
 const root={...entry(1,0,'Заключительные признаки'),key:'BASE.DECISION'}
 const section={...entry(2,1,'УЗИ брюшной полости'),key:'BASE.DECISION.BROOHO'}
 const group={...entry(3,2,'Частые заготовки'),includeInPhrase:false}
 const prefix=entry(4,3,'Очагового образования')
 const location=entry(5,4,'брюшной полости.')
 const leaf={...entry(6,5,'исходный фрагмент'),folder:false,value:', без дополнительных уточнений.'}
 const parts=templatePhraseParts(leaf,[root,section,group,prefix,location],section.id)
 expect(parts.map(({id,checked})=>[id,checked])).toEqual([[3,false],[4,true],[5,true],[6,true]])
 expect(composeTemplate(parts,[4,5,6])).toBe('Очагового образования брюшной полости, без дополнительных уточнений.')
 expect(composeTemplate(parts,[4])).toBe('Очагового образования')
})
