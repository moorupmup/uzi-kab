import templatesData from './legacy-templates.json'
import dictionaryData from './legacy-dictionary.json'
import type { FieldValue } from './types'

type Expression = [string, ...unknown[]]
type Node = [string, ...unknown[]]
const templates=templatesData as unknown as Record<string,Node[]>
const dictionary=dictionaryData as Record<string,string>
const escapeHTML=(value:unknown)=>String(value).replaceAll('&','&amp;').replaceAll('<','&lt;').replaceAll('>','&gt;').replaceAll('"','&quot;').replaceAll("'",'&#39;')

export function resolveValue(field:FieldValue):string {
  if(!['select','checkbox'].includes(field.type))return field.value
  if(!field.value || field.value==='0')return ''
  return dictionary[field.value]??field.value
}

export function renderLegacy(code:string,version:string,fields:Record<string,FieldValue>) {
  const key=code.toLowerCase()+'_'+version
  const nodes=templates[key]
  if(!nodes)return {supported:false,html:'',unknownValues:[] as string[],activeFields:[] as string[]}
  const values:Record<string,string>={},variables:Record<string,unknown>={}
  const unknownValues:string[]=[]
  const activeFields=new Set<string>()
  for(const [name,field] of Object.entries(fields)){
    values[name]=resolveValue(field)
    if(['select','checkbox'].includes(field.type)&&field.value&&field.value!=='0'&&!(field.value in dictionary))unknownValues.push(name)
  }
  function evaluate(expression:Expression):unknown {
    const [type,a,b]=expression
    switch(type){
      case 'literal':return a
      case 'variable':if(!(String(a) in variables))throw new Error('Unknown template variable: '+a);return variables[String(a)]
      case 'get':{const name=String(evaluate(a as Expression));activeFields.add(name);return values[name]??''}
      // Exact RequestWrapper.empty semantics: Java trim removes ASCII <= U+0020.
      case 'empty':{const name=String(evaluate(a as Expression));activeFields.add(name);const value=(values[name]??'').replace(/^[\x00-\x20]+|[\x00-\x20]+$/g,'');return value===''||value==='null'}
      case '!':return !evaluate(a as Expression)
      case '&&':return Boolean(evaluate(a as Expression))&&Boolean(evaluate(b as Expression))
      case '||':return Boolean(evaluate(a as Expression))||Boolean(evaluate(b as Expression))
      case '+':return String(evaluate(a as Expression))+String(evaluate(b as Expression))
      case 'equals':return evaluate(a as Expression)===evaluate(b as Expression)
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
  function render(list:Node[]):string {
    return list.map(([type,a,b,c])=>{
      switch(type){
        case 'html':return String(a)
        case 'output':return escapeHTML(evaluate(a as Expression))
        case 'set':variables[String(a)]=evaluate(b as Expression);return ''
        case 'if':dependencies(a as Expression);return render((evaluate(a as Expression)?b:c) as Node[])
        default:throw new Error('Unsupported template node: '+type)
      }
    }).join('')
  }
  try{const html=render(nodes);return {supported:true,html,unknownValues,activeFields:[...activeFields]}}
  catch{return {supported:false,html:'',unknownValues,activeFields:[] as string[]}}
}
