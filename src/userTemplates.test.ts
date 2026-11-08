import {describe,it,expect} from 'vitest'
import {templatePath,appendTemplate,type UserTemplate} from './userTemplates'
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
