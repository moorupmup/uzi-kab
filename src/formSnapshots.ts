import type {FieldValue,FormSnapshot} from './types'
export function formFields(fields:Record<string,FieldValue>,snapshot?:FormSnapshot):Record<string,FieldValue>{
 const result:Record<string,FieldValue>={}
 for(const [key,field] of Object.entries(fields)){
  const definition=snapshot?.definitions.find(d=>d.key===key)
  const option=definition?.options?.find(o=>o.value===field.value)
  result[key]=option?{value:field.value,type:definition?.valueType||field.type,label:option.label,baseValue:option.baseValue||option.value,caption:[...new Set([definition?.group,definition?.label].filter(Boolean))].join(' · ')}:{value:field.value,type:field.type}
 }
 return result
}
