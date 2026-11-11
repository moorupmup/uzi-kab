import models from './editor-conditions.json'
import type {FieldDefinition,FieldValue} from './types'
interface Rule {field:string;defaultValue?:string;id?:string;equals?:string;outcomes?:Record<string,Record<string,boolean>>}
interface EditorModel {initial:Record<string,boolean>;fields:Record<string,string[][]>;rules:Rule[]}
export function editorFields(code:string,version:string,definitions:FieldDefinition[],fields:Record<string,FieldValue>,fallback:string[]):FieldDefinition[]{
 const model=(models as unknown as Record<string,EditorModel>)[code.toLowerCase()+'_'+version]
 if(!model)return definitions.filter(d=>fallback.includes(d.key))
 const visibility={...model.initial}
 for(const rule of model.rules){const field=fields[rule.field];const value=(field?.baseValue==='__text'?field.value:field?.baseValue??field?.value)||rule.defaultValue||'';if(rule.id)visibility[rule.id]=value===rule.equals;else Object.assign(visibility,rule.outcomes?.[value]??rule.outcomes?.__other)}
 return definitions.filter(d=>{const locations=model.fields[d.key];return locations?locations.some(parents=>parents.every(id=>visibility[id]!==false)):fallback.includes(d.key)})
}
