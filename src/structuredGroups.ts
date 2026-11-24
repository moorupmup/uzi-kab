import type {FieldDefinition,FieldValue} from './types'

export function groupFields(definitions:FieldDefinition[],fields:Record<string,FieldValue>){
  const groups:{name:string;fields:FieldDefinition[]}[]=[]
  for(const field of definitions){
    if(field.valueType==='checkbox'&&!field.options?.some(o=>!o.hidden)&&!fields[field.key]?.value)continue
    const name=field.group||'Параметры исследования'
    let group=groups.at(-1)
    if(!group||group.name!==name){group={name,fields:[]};groups.push(group)}
    group.fields.push(field)
  }
  return groups
}
