import {describe,it,expect} from 'vitest'
import {calculateLegacy,invalidateCalculations} from './calculations'
import type {FieldValue} from './types'
import {readFileSync} from 'node:fs'
import {runInNewContext} from 'node:vm'
const fields=(values:Record<string,string>)=>Object.fromEntries(Object.entries(values).map(([key,value])=>[key,{type:'string',value}])) as Record<string,FieldValue>
describe('Explicit calculations',()=>{
  it('removes derived values and persists pending status across a draft roundtrip',()=>{
    const input=fields({r_dolya_1:'50',r_dolya_2:'20',r_dolya_3:'20',v1:'9.58',sum:'19.16'})
    invalidateCalculations('shit',input)
    const reopened=JSON.parse(JSON.stringify(input))
    expect(reopened.v1).toBeUndefined();expect(reopened.sum).toBeUndefined()
    expect(reopened._calculation_pending.value).toBe('1')
    expect(reopened.r_dolya_1.value).toBe('50')
  })
  it('allows a narrative-only study after clearing every measurement',()=>{
    const input=fields({r_dolya_1:'50',v1:'9.58'})
    invalidateCalculations('shit',input)
    input.r_dolya_1.value=''
    invalidateCalculations('shit',input)
    expect(input.v1).toBeUndefined();expect(input._calculation_pending).toBeUndefined()
  })
  it('uses the thyroid coefficient, unit conversion and rounding from the source',()=>{
    const result=calculateLegacy('shit',fields({r_dolya_1:'50',r_dolya_2:'20',r_dolya_3:'20',l_dolya_1:'50',l_dolya_2:'20',l_dolya_3:'20'}))
    expect(result.v1.value).toBe('9.58');expect(result.v2.value).toBe('9.58');expect(result.sum.value).toBe('19.16')
  })
  it('accepts decimal commas without modifying entered values',()=>{
    const input=fields({kdr:'5,1',ksr:'3,2',mjld_tol:'1',zslj_tol:'1'})
    const result=calculateLegacy('eho_kg',input)
    expect(input.kdr.value).toBe('5,1');expect(Number(result.kdo.value)).toBe(124);expect(Number(result.kso.value)).toBe(41)
  })
  it('rejects incomplete and invalid input instead of saving NaN or zero defaults',()=>{
    expect(()=>calculateLegacy('shit',{})).toThrow()
    expect(()=>calculateLegacy('eho_kg',fields({kdr:'0',ksr:'3',mjld_tol:'1',zslj_tol:'1'}))).toThrow()
  })
  it('preserves signed results from the source without adding diagnostic thresholds',()=>{
    const result=calculateLegacy('eho_kg',fields({kdr:'4',ksr:'5',mjld_tol:'1',zslj_tol:'1'}))
    expect(result.fv.value).toBe('-69');expect(result.fy.value).toBe('-25')
  })
  it('matches remaining source volume functions on synthetic inputs',()=>{
    for(const code of ['ginekol','brooho']){
      const source=readFileSync(`legacy/forms/${code}_${code==='ginekol'?'11':'1'}.jsp`,'latin1')
      const script=[...source.matchAll(/<script[^>]*>([\s\S]*?)<\/script>/gi)].at(-1)![1]
      for(let i=1;i<=30;i++){
        const input:Record<string,string>=code==='ginekol'?{r_dlina:String(20+i),r_tolsh:'15',r_shir:'20',l_dlina:'25',l_tolsh:'15',l_shir:'20',matka_dl:'60',matka_tol:'40',matka_sh:'50'}:{jelch_dl:String(40+i),jelch_tol:'20',jelch_sh:'25',sel_dl:'90',sel_tol:'40',sel_sh:'50'}
        const result=calculateLegacy(code,fields(input)),protocol:Record<string,{value:string}>={}
        for(const key of [...Object.keys(input),...Object.keys(result)]){let stored=input[key]||'';protocol[key]=Object.defineProperty({},'value',{get:()=>stored,set:(v:unknown)=>{stored=String(v)}}) as {value:string}}
        runInNewContext(script+(code==='ginekol'?';ObemR();ObemL();ObemM();':';ObemJP();ObemSel();'),{document:{protocol},Math},{timeout:1000})
        for(const [key,value] of Object.entries(result))expect(value.value).toBe(String(protocol[key].value))
      }
    }
  })
  it('matches the original JavaScript calculation functions on synthetic inputs',()=>{
    for(const code of ['shit','eho_kg']){
      const source=readFileSync(`legacy/forms/${code}_${code==='shit'?'1':'2'}.jsp`,'latin1')
      const scripts=[...source.matchAll(/<script[^>]*>([\s\S]*?)<\/script>/gi)]
      const script=scripts.at(-1)![1]
      for(let i=1;i<=30;i++){
        const input:Record<string,string>=code==='shit'?{r_dolya_1:String(30+i),r_dolya_2:'20',r_dolya_3:'15',l_dolya_1:'40',l_dolya_2:String(10+i),l_dolya_3:'15'}:{kdr:String(4+i/10),ksr:'3.1',mjld_tol:'0.9',zslj_tol:'1.1'}
        const result=calculateLegacy(code,fields(input))
        const protocol:Record<string,{value:string}>={};for(const key of [...Object.keys(input),...Object.keys(result)]){let stored=input[key]||'';protocol[key]=Object.defineProperty({},'value',{get:()=>stored,set:(v:unknown)=>{stored=String(v)}}) as {value:string}}
        const context={document:{protocol},Math}
        runInNewContext(script+(code==='shit'?';ExecutRv1();ExecutLv2();':';F_kdo();F_kso();'),context,{timeout:1000})
        for(const [key,field] of Object.entries(result))expect(field.value).toBe(String(protocol[key].value))
      }
    }
  })
})
