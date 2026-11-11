import {describe,it,expect} from 'vitest'
import catalog from './catalog.json'
import {reviseForm} from './formRevisions'
import {formFields} from './formSnapshots'
import {renderLegacy} from './legacy'
import type {FieldDefinition,FormSnapshot} from './types'

const original=(version='1'):FormSnapshot=>({code:'brooho',version,configurationRevision:0,definitions:(catalog as Record<string,FieldDefinition[]>)['brooho_'+version]})
describe('Shipped abdominal form revisions',()=>{
 it('keeps the archive catalog intact while supplying all requested fields and choices',()=>{
  for(const version of ['1']){
   const old=original(version),before=JSON.stringify(old),current=reviseForm(old),field=(key:string)=>current.definitions.find(d=>d.key===key)!
   expect(JSON.stringify(old)).toBe(before);expect(current.editor?.hideDescription).toBe(true)
   for(const key of ['one_o','m_seg1','m_seg8','m_cdk','m_razot','m_razdo','pechen_str_text','jel_net'])if(field(key))expect(field(key).hidden).toBe(true)
   for(const definition of current.definitions.filter(d=>d.label==='Контуры'))expect(definition.options?.filter(o=>!o.hidden).map(o=>o.label)).toEqual(['ровные','неровные','четкие','нечёткие'])
   expect(field('stenki').options?.map(o=>o.label)).toEqual(['не изменены','уплотнены','утолщены','с двойными контурами'])
   expect(field('soderg').options?.filter(o=>!o.hidden).map(o=>o.label)).toEqual(['без особенностей','незначительное количество застойного содержимого','умеренное количество застойного содержимого','выраженное застойное содержимое'])
   expect(field('forma_izm').options?.at(-1)?.label).toBe('Сокращён на тощак')
   expect(field('v_polosti').referenceKey).toBe('v_polosti')
   for(const key of ['struktura','struktura_pod','struktura_sel'])if(field(key))expect(field(key).options?.at(-1)).toMatchObject({inputLabel:'Выбрать из справочника',referenceSection:'str_text'})
  }
 })
 it('prints new choices and dictionary text without unknown codes or action labels',()=>{
  const snapshot=reviseForm(original())
  const fields=formFields({forma_izm:{value:'654',type:'select'},kontur:{value:'preset_brooho_clear',type:'select'},stenki:{value:'643',type:'select'},soderg:{value:'preset_brooho_moderate',type:'select'},struktura:{value:'125',type:'select'},pechen_str_text:{value:'Текст структуры <из справочника>',type:'textarea_users'},v_polosti:{value:'Содержимое из базы врача',type:'textarea_users'}},snapshot)
  const result=renderLegacy('brooho','1',fields)
  expect(result.supported).toBe(true);expect(result.unknownValues).toEqual([])
  for(const text of ['четкие','утолщены','умеренное количество застойного содержимого','Текст структуры &lt;из справочника&gt;','Содержимое из базы врача'])expect(result.html).toContain(text)
  expect(result.html).not.toContain('Выбрать из справочника')
  expect(renderLegacy('brooho','1',formFields({forma_izm:{value:'preset_brooho_fasting',type:'select'}},snapshot)).html).toContain('Сокращён на тощак')
 })
 it('preserves custom settings and leaves unrelated forms alone',()=>{
  const old=original(),field=old.definitions.find(d=>d.key==='kontur')!
  const modified={...old,definitions:old.definitions.map(d=>d.key==='kontur'?{...d,options:[...field.options!.map(o=>o.value==='120'?{...o,label:'Моя подпись'}:o),{label:'Свой вариант',value:'custom_local',baseValue:'__text'}]}:d)}
  const options=reviseForm(modified).definitions.find(d=>d.key==='kontur')!.options!
  expect(options.find(o=>o.value==='120')?.label).toBe('Моя подпись');expect(options.at(-1)?.value).toBe('custom_local')
  expect(reviseForm(original('2')).presetRevision).toBeUndefined();const unrelated={...old,code:'shit'};expect(reviseForm(unrelated)).toBe(unrelated)
 })
})
