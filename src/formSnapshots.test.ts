import {describe,it,expect} from 'vitest'
import catalog from './catalog.json'
import models from './editor-conditions.json'
import {renderLegacy,resolveValue} from './legacy'
import {editorFields} from './editor-conditions'
import {formFields} from './formSnapshots'
import type {FieldDefinition,FieldValue,FormSnapshot} from './types'
describe('Versioned field options',()=>{
 it('prints visible free choices without requiring an existing medical meaning',()=>{
  let direct=0,additional=0
  for(const key of Object.keys(models)){
   const split=key.lastIndexOf('_'),code=key.slice(0,split),version=key.slice(split+1),definitions=(catalog as Record<string,FieldDefinition[]>)[key]
   for(const definition of definitions.filter(d=>d.valueType==='select')){
    const label='Собственный вариант '+definition.key,fields:Record<string,FieldValue>={[definition.key]:{value:'custom_test',type:'select',baseValue:'__text',label,caption:definition.label}}
    const original=renderLegacy(code,version,{[definition.key]:{value:label,type:'string'}}),result=renderLegacy(code,version,fields)
    expect(result.supported).toBe(true);expect(result.unknownValues).toEqual([])
    const visible=editorFields(code,version,[definition],fields,result.activeFields).length>0
    if(original.html.includes(label)){expect(result.html).toBe(original.html);direct++}
    else if(visible){expect(result.html).toContain(label);expect(result.html).toContain('archive-fields');additional++}
    else expect(result.html).not.toContain(label)
   }
  }
  expect(direct).toBeGreaterThan(50);expect(additional).toBeGreaterThan(0)
 })
 it('does not print retained free values from a collapsed organ branch',()=>{
  const field:FieldValue={value:'custom_test',type:'select',baseValue:'__text',label:'Скрытый собственный вариант',caption:'Форма образования'}
  const closed=renderLegacy('brooho','1',{struktura:{type:'select',value:'125'},one_obraz1:field})
  expect(closed.html).not.toContain(field.label)
  expect(renderLegacy('brooho','1',{struktura:{type:'select',value:'125'},one_o:{type:'checkbox',value:'631'},one_obraz1:field}).html).toContain(field.label)
 })
 it('escapes free values and supplementary captions and takes them only from the snapshot',()=>{
  const snapshot:FormSnapshot={code:'brooho',version:'1',configurationRevision:1,definitions:[{key:'pechen',label:'<b>Печень</b>',kind:'getSelect',valueType:'select',options:[{value:'custom_free',label:'<script>test()</script>',baseValue:'__text'}]}]}
  const fields=formFields({pechen:{value:'custom_free',type:'string',label:'Подмена',baseValue:'630',caption:'Подмена'}},snapshot)
  expect(fields.pechen.type).toBe('select');expect(fields.pechen.baseValue).toBe('__text');expect(fields.pechen.caption).toBe('<b>Печень</b>')
  const result=renderLegacy('brooho','1',fields)
  expect(result.unknownValues).toEqual([]);expect(result.html).toContain('&lt;script&gt;test()&lt;/script&gt;');expect(result.html).not.toContain('<script>')
 })
 it('keeps original print conditions and editor branches for compatible custom choices',()=>{
  let checked=0
  for(const key of Object.keys(models)){
   const split=key.lastIndexOf('_'),code=key.slice(0,split),version=key.slice(split+1),definitions=(catalog as Record<string,FieldDefinition[]>)[key]
   for(const definition of definitions)for(const choice of definition.options||[]){
    if(!choice.value||choice.value==='0')continue
    const original:Record<string,FieldValue>={[definition.key]:{value:choice.value,type:definition.valueType!}}
    const custom:Record<string,FieldValue>={[definition.key]:{value:'custom_test',baseValue:choice.value,label:resolveValue(original[definition.key]),type:definition.valueType!}}
    const expected=renderLegacy(code,version,original),actual=renderLegacy(code,version,custom)
    expect(actual).toEqual(expected)
    expect(editorFields(code,version,definitions,custom,actual.activeFields)).toEqual(editorFields(code,version,definitions,original,expected.activeFields));checked++
   }
  }
  expect(checked).toBeGreaterThan(500)
 })
 it('uses snapshot definitions and ignores supplied labels or semantic overrides',()=>{
  const snapshot:FormSnapshot={code:'brooho',version:'1',configurationRevision:3,definitions:[{key:'pechen',label:'Печень',kind:'getSelect',valueType:'select',options:[{value:'custom_test',label:'<script>test()</script>',baseValue:'629'}]}]}
  const fields=formFields({pechen:{value:'custom_test',type:'select',label:'Подмена',baseValue:'999'},unknown:{value:'test',type:'string',label:'Подмена'}},snapshot)
  expect(fields.pechen.baseValue).toBe('629');expect(fields.unknown.label).toBeUndefined()
  const result=renderLegacy(snapshot.code,snapshot.version,fields)
  expect(result.unknownValues).toEqual([]);expect(result.html).toContain('&lt;script&gt;test()&lt;/script&gt;');expect(result.html).not.toContain('<script>')
 })
})
