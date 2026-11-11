import revisions from './form-revisions.json'
import catalog from './catalog.json'
import type {FieldDefinition,FormSnapshot} from './types'
interface Revision {revision:number;versions:string[];editor:NonNullable<FormSnapshot['editor']>;hiddenFields:string[];fields:Record<string,Partial<FieldDefinition>>}

// The same declarative patches are loaded by the desktop backend. Never apply
// them to a saved snapshot or to an archive record without a snapshot.
export function reviseForm(form:FormSnapshot):FormSnapshot {
 const patch=(revisions as unknown as Record<string,Revision>)[form.code.toLowerCase()]
 if(!patch?.versions.includes(form.version))return form
 return {...form,editor:patch.editor,presetRevision:patch.revision,definitions:form.definitions.map(definition=>{
  const field={...definition,...patch.fields[definition.key]} as FieldDefinition
  const defaults=patch.fields[definition.key]?.options
  if(defaults&&definition.options){
   const legacy=(catalog as Record<string,FieldDefinition[]>)[form.code.toLowerCase()+'_'+form.version]?.find(d=>d.key===field.key)?.options
   field.options=defaults.map(option=>{const local=definition.options?.find(o=>o.value===option.value),old=legacy?.find(o=>o.value===option.value);return {...option,...(local&&old?.label!==local.label?{label:local.label}:{}),...(local&&!option.hidden?{hidden:local.hidden}:{})}})
   field.options.push(...definition.options.filter(o=>!defaults.some(d=>d.value===o.value)))
  }
  if(patch.hiddenFields.includes(field.key))field.hidden=true
  return field
 })}
}
