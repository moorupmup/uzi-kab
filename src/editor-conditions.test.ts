import {describe,it,expect} from 'vitest'
import catalog from './catalog.json'
import {editorFields} from './editor-conditions'
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
