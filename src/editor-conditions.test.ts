import {readFileSync} from 'node:fs'
import {describe,it,expect} from 'vitest'
import catalog from './catalog.json'
import {editorFields} from './editor-conditions'
import {abdominalLayout,abdominalRows,originalAbdominalFields} from './abdominalLayout'
import {reviseForm} from './formRevisions'
import type {FieldDefinition,FieldValue} from './types'
const keys=(code:string,values:Record<string,string>)=>editorFields(code,'1',(catalog as Record<string,FieldDefinition[]>)[code+'_1'],Object.fromEntries(Object.entries(values).map(([key,value])=>[key,{value,type:'string'}])) as Record<string,FieldValue>,[]).map(f=>f.key)
describe('Legacy editor availability',()=>{
 it('restores inputs independently of whether the print template uses them',()=>{
 expect((catalog.brooho_1 as FieldDefinition[]).find(f=>f.key==='sel_vena')).toBeDefined()
 expect((catalog.pochki_1 as FieldDefinition[]).find(f=>f.key==='r_chash_size')).toBeDefined()
 expect((catalog.ginekol_11 as FieldDefinition[]).find(f=>f.key==='matka_ob')).toBeDefined()
 })
 it('retains the original checkbox branch and stored values when collapsed',()=>{
 const empty=keys('brooho',{struktura:'125'}),visible=keys('brooho',{struktura:'125',one_o:'631'})
 expect(visible.length).toBeGreaterThan(empty.length)
 expect(visible).toContain('one_obraz1');expect(empty).not.toContain('one_obraz1')
 })
 it('never hides the main selectors for blank protocols',()=>{expect(keys('brooho',{})).toContain('pechen');expect(keys('shit',{})).toContain('r_dolya_1')})
})

describe('Original abdominal layout conditions',()=>{
 const definitions=reviseForm({code:'brooho',version:'1',configurationRevision:0,definitions:catalog.brooho_1 as FieldDefinition[]}).definitions
 it('restores revised-away controls and matches every combination of the nested source branches',()=>{
   for(const struktura of ['124','555','125'])for(const one_o of ['','631'])for(const many_o of ['','632'])for(const forma_izm of ['654','655','656','657'])for(const pod_jel of ['666','667','668'])for(const selez of ['1016','1018'])for(const r_pochka of ['670','673','676']){
     const values={struktura,one_o,many_o,forma_izm,pod_jel,selez,r_pochka,l_pochka:r_pochka,r_chash:'687',l_chash:'687'}
     const fields=Object.fromEntries(Object.entries(values).map(([key,value])=>[key,{value,type:'string'}]))
     const expected=editorFields('brooho','1',catalog.brooho_1 as FieldDefinition[],fields,[]).map(d=>d.key)
     expect(originalAbdominalFields(definitions,fields).map(d=>d.key).sort()).toEqual(expected.sort())
   }
 })
 it('keeps visible fields in JSP order and every control appears exactly once',()=>{
   const source=readFileSync('legacy/forms/brooho_1.jsp','latin1')
   const sourceKeys=[...new Set([...source.matchAll(/r\.(?:getSizeInput|getSelect|getCheckbox|get)\("([^"]+)"\)/g)].map(match=>match[1]))]
   const fields:Record<string,FieldValue>={struktura:{value:'125',type:'select'},one_o:{value:'631',type:'checkbox'},many_o:{value:'632',type:'checkbox'},r_chash:{value:'140',type:'select'},l_chash:{value:'140',type:'select'}}
   const visible=originalAbdominalFields(definitions,fields)
   const layout=abdominalLayout(visible,fields)
   const rendered=layout.flatMap(section=>section.blocks.flatMap(block=>abdominalRows(block.fields).flatMap(row=>row.fields.map(field=>field.key))))
   expect(rendered).toEqual(sourceKeys.filter(key=>visible.some(field=>field.key===key)))
   expect(layout.find(section=>section.fields[0].key==='pod_jel')?.fields.at(-1)?.key).toBe('sel_vena')
 })
 it('keeps hidden measurements intact and restores them when reopened',()=>{
   const fields:Record<string,FieldValue>={struktura:{value:'125',type:'select'},one_o:{value:'631',type:'checkbox'},r1_obraz1:{value:'12',type:'string'}}
   expect(originalAbdominalFields(definitions,fields).some(d=>d.key==='r1_obraz1')).toBe(true)
   fields.one_o.value=''
   expect(originalAbdominalFields(definitions,fields).some(d=>d.key==='r1_obraz1')).toBe(false)
   expect(fields.r1_obraz1.value).toBe('12')
   fields.one_o.value='631'
   expect(originalAbdominalFields(definitions,fields).some(d=>d.key==='r1_obraz1')).toBe(true)
   expect(originalAbdominalFields(definitions,fields).find(d=>d.key==='struktura')?.options?.find(o=>o.value==='125')?.referenceKey).toBeUndefined()
 })
})
