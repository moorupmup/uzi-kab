import templatesData from './legacy-templates.json'
import dictionaryData from './legacy-dictionary.json'
import type { FieldValue } from './types'
import {editorFields} from './editor-conditions'

type Expression = [string, ...unknown[]]
type Node = [string, ...unknown[]]
const templates=templatesData as unknown as Record<string,Node[]>
const dictionary=dictionaryData as Record<string,string>
const escapeHTML=(value:unknown)=>String(value).replaceAll('&','&amp;').replaceAll('<','&lt;').replaceAll('>','&gt;').replaceAll('"','&quot;').replaceAll("'",'&#39;')

export function resolveValue(field:FieldValue):string {
  if(!['select','checkbox'].includes(field.type))return field.value
  if(!field.value || field.value==='0')return ''
  if(field.label!==undefined)return field.label
  return dictionary[field.value]??field.value
}

export function renderLegacy(code:string,version:string,fields:Record<string,FieldValue>) {
  const key=code.toLowerCase()+'_'+version
  const nodes=templates[key]
  if(!nodes)return {supported:false,html:'',unknownValues:[] as string[],activeFields:[] as string[]}
  const values:Record<string,string>={},semantics:Record<string,string>={},variables:Record<string,unknown>={},semanticVariables:Record<string,unknown>={}
  const unknownValues:string[]=[]
  const activeFields=new Set<string>()
  const printedFields=new Set<string>(),variableFields:Record<string,string[]>={}
  for(const [name,field] of Object.entries(fields)){
    values[name]=resolveValue(field)
    const free=field.baseValue==='__text'&&field.label!==undefined
    semantics[name]=free?field.label!:resolveValue({value:field.baseValue??field.value,type:field.type})
    const base=field.baseValue??field.value
    if(['select','checkbox'].includes(field.type)&&field.value&&field.value!=='0'&&!free&&base!=='0'&&!(base in dictionary))unknownValues.push(name)
  }
  function evaluate(expression:Expression,semantic=false):unknown {
    const [type,a,b]=expression
    const get=(e:Expression)=>evaluate(e,semantic)
    const vars=semantic?semanticVariables:variables, data=semantic?semantics:values
    switch(type){
      case 'literal':return a
      case 'variable':if(!(String(a) in vars))throw new Error('Unknown template variable: '+a);return vars[String(a)]
      case 'get':{const name=String(get(a as Expression));activeFields.add(name);return data[name]??''}
      // Exact RequestWrapper.empty semantics: Java trim removes ASCII <= U+0020.
      case 'empty':{const name=String(get(a as Expression));activeFields.add(name);const value=(data[name]??'').replace(/^[\x00-\x20]+|[\x00-\x20]+$/g,'');return value===''||value==='null'}
      case '!':return !get(a as Expression)
      case '&&':return Boolean(get(a as Expression))&&Boolean(get(b as Expression))
      case '||':return Boolean(get(a as Expression))||Boolean(get(b as Expression))
      case '+':return String(get(a as Expression))+String(get(b as Expression))
      case 'equals':return get(a as Expression)===get(b as Expression)
      default:throw new Error('Unsupported template expression: '+type)
    }
  }
  function dependencies(expression:Expression){
    const [type,a,b]=expression
    if(type==='get'||type==='empty')activeFields.add(String(evaluate(a as Expression)))
    else if(['!','&&','||','+','equals'].includes(type)){
      dependencies(a as Expression);if(b)dependencies(b as Expression)
    }
  }
  function outputFields(expression:Expression):string[]{
    const [type,a,b]=expression
    if(type==='get')return [String(evaluate(a as Expression))]
    if(type==='variable')return variableFields[String(a)]||[]
    if(type==='+')return [...outputFields(a as Expression),...outputFields(b as Expression)]
    return []
  }
  function render(list:Node[]):string {
    return list.map(([type,a,b,c])=>{
      switch(type){
        case 'html':return String(a)
        case 'output':{const value=evaluate(a as Expression);for(const name of outputFields(a as Expression))printedFields.add(name);return escapeHTML(value)}
        case 'set':variables[String(a)]=evaluate(b as Expression);semanticVariables[String(a)]=evaluate(b as Expression,true);variableFields[String(a)]=outputFields(b as Expression);return ''
        case 'if':dependencies(a as Expression);return render((evaluate(a as Expression,true)?b:c) as Node[])
        default:throw new Error('Unsupported template node: '+type)
      }
    }).join('')
  }
  try{let html=render(nodes)
    const freeFields=Object.entries(fields).filter(([name,field])=>!name.startsWith('_')&&field.baseValue==='__text'&&field.value&&field.label)
    const visible=new Set(editorFields(code,version,freeFields.map(([name,field])=>({key:name,label:field.caption||name,kind:'getSelect',valueType:field.type})),fields,[...activeFields]).map(d=>d.key))
    const additional=freeFields.filter(([name])=>!printedFields.has(name)&&visible.has(name))
    if(additional.length)html+='<dl class="archive-fields">'+additional.map(([name,field])=>'<div><dt>'+escapeHTML(field.caption||name)+'</dt><dd>'+escapeHTML(field.label)+'</dd></div>').join('')+'</dl>'
    return {supported:true,html,unknownValues,activeFields:[...activeFields]}}
  catch{return {supported:false,html:'',unknownValues,activeFields:[] as string[]}}
}
