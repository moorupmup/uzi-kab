import {readFileSync} from 'node:fs'
import {runInNewContext} from 'node:vm'
import modelsData from './editor-conditions.json'
import {editorFields} from './editor-conditions'
import {editorLayoutGroups,editorLayoutRows,studyEditorDefinitions} from './editorLayout'
import catalogData from './catalog.json'
import type {FieldDefinition,FieldValue} from './types'
import {it,expect} from 'vitest'
it('matches the original visibility functions for every transferred selector outcome',()=>{
 const models=modelsData as unknown as Record<string,{initial:Record<string,boolean>;fields:Record<string,string[][]>;rules:{field:string;defaultValue?:string;outcomes?:Record<string,Record<string,boolean>>}[]}>
 const catalog=catalogData as Record<string,FieldDefinition[]>
 let cases=0
 for(const [key,model] of Object.entries(models)){
  const source=readFileSync('legacy/forms/'+key+'.jsp','latin1'),functions:string[]=[]
  for(const match of source.matchAll(/function\s+(\w+)\s*\([^)]*\)\s*\{/g)){
   let level=1,end=match.index!+match[0].length
   for(;end<source.length&&level;end++){if(source[end]==='{')level++;else if(source[end]==='}')level--}
   const body=source.slice(match.index,end);if(body.includes('.style.display'))functions.push(body+';'+match[1]+'();')
  }
  const candidates=[{},...model.rules.flatMap(r=>Object.keys(r.outcomes||{}).map(value=>({[r.field]:{value:value==='__other'?'unrecognized':value,type:'string'}})))] as Record<string,FieldValue>[]
  for(const fields of candidates){
   const protocol:Record<string,{value:string;checked:boolean}>={}
   for(const f of catalog[key]){const value=fields[f.key]?.value||(f.valueType==='select'?f.options?.[0]?.value:'')||'';protocol[f.key]={value,checked:Boolean(fields[f.key]?.value&&fields[f.key]?.value!=='0')}}
   const context:Record<string,unknown>={document:{protocol},protocol}
   for(const [id,on] of Object.entries(model.initial))context[id]={style:{display:on?'':'none'}}
   for(const rule of model.rules)for(const states of Object.values(rule.outcomes||{}))for(const id of Object.keys(states))if(!context[id])context[id]={style:{display:''}}
   for(const fn of functions)runInNewContext(fn,context,{timeout:100})
   for(const match of source.matchAll(/getChangeHidden\("([^"]+)",\s*"([^"]+)",\s*"([^"]+)"\)/g))(context['display'+match[2]] as {style:{display:string}}).style.display=protocol[match[1]].value===match[3]?'':'none'
   const expected=catalog[key].filter(f=>model.fields[f.key]?.some(parents=>parents.every(id=>(context[id] as {style:{display:string}}).style.display!=='none'))).map(f=>f.key)
   const at=key.lastIndexOf('_');expect(editorFields(key.slice(0,at),key.slice(at+1),catalog[key],fields,[]).map(f=>f.key),key+' '+JSON.stringify(fields)).toEqual(expected)
   const visible = studyEditorDefinitions(key,catalog[key],fields)
   const actual = editorLayoutGroups(key,visible,fields).flatMap(group=>
    group.blocks.flatMap(block=>editorLayoutRows(key,block.fields).flatMap(row=>row.fields.map(field=>field.key))))
   const expectedControls = visible.filter(field=>field.valueType!=='checkbox'||field.options?.some(option=>!option.hidden)||fields[field.key]?.value)
   expect(actual.sort(),key+' duplicated or omitted a control').toEqual(expectedControls.map(field=>field.key).sort())
   cases++
  }
 }
 expect(cases).toBeGreaterThan(160)
})
