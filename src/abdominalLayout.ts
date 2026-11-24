import type {FieldDefinition,FieldValue} from './types'
import {groupFields} from './structuredGroups'
import catalog from './catalog.json'
import revisions from './form-revisions.json'
import {editorFields} from './editor-conditions'

// Presentation only: source keys, values and snapshots remain unchanged.
export function abdominalLayout(definitions:FieldDefinition[],fields:Record<string,FieldValue>){
 const starts=new Set(['pechen','forma_izm','pod_jel','selez','r_pochka','l_pochka'])
 const dimensions=new Set(['kosoi_r','kosoi_l','tolsh_r','tolsh_l','jelch_dl','jelch_sh','jelch_tol','jelch_ob','golov','telo','hvost','sel_dl','sel_tol','sel_sh','sel_obem','r_razm_poch_1','r_razm_poch_2','l_razm_poch_1','l_razm_poch_2'])
 const parenchyma=new Set(['r_tolsh_paren_1','r_tolsh_paren_2','r_tolsh_paren_3','l_tolsh_paren_1','l_tolsh_paren_2','l_tolsh_paren_3'])
 type Block={name?:string;fields:FieldDefinition[]}
 const result:{name:string;fields:FieldDefinition[];blocks:Block[]}[]=[]
 // The source places the splenic vein at the end of the pancreas section.
 for(const source of groupFields(definitions.map(field=>field.key==='sel_vena'
   ? {...field,group:'Селезёночная вена',label:'Селезёночная вена'}
   : field),fields)){
   let organ=result.at(-1)
   const isOrgan=starts.has(source.fields[0].key)
   if(!organ||isOrgan){organ={name:source.name,fields:[],blocks:[]};result.push(organ)}
   let block:Block|undefined
   for(const field of source.fields){
     const name=dimensions.has(field.key)?'Размеры':parenchyma.has(field.key)?'Толщина паренхимы в средней трети':undefined
     const lesion=field.key.match(/(?:_obraz|one_obraz)([123])$/)
     const blockName=lesion?'Единичное образование '+lesion[1]:name||(!isOrgan?source.name:undefined)
     if(!block||block.name!==blockName){block={name:blockName,fields:[]};organ.blocks.push(block)}
     block.fields.push(field);organ.fields.push(field)
   }
 }
 return result
}

export function abdominalRows(fields:FieldDefinition[]){
 const pairs=[['port_vena','port_vena_text'],['polaj_vena','polaj_vena1','polaj_vena2'],['stenki','stenki_size'],['jelch_protok','protok_mm'],['virs_rash','virs_size'],['r_razm_poch_1','r_razm_poch_2'],['l_razm_poch_1','l_razm_poch_2'],['r_tolsh_paren_1','r_tolsh_paren_2','r_tolsh_paren_3'],['l_tolsh_paren_1','l_tolsh_paren_2','l_tolsh_paren_3']]
 pairs.push(['m_razot','m_razdo'],Array.from({length:8},(_,index)=>`m_seg${index+1}`))
 for(const side of ['r','l']){
   pairs.push([`${side}_chash_check`,`${side}_chash_local`,`${side}_chash_size`],[`${side}_lohanki`,`${side}_lohan_size`])
 }
 for(const n of [1,2,3])pairs.push([`r1_obraz${n}`,`r2_obraz${n}`,`r3_obraz${n}`])
 const used=new Set<string>()
 return fields.flatMap(field=>{
   if(used.has(field.key))return []
   const keys=pairs.find(keys=>keys[0]===field.key)||[field.key]
   const row=keys.map(key=>fields.find(f=>f.key===key)).filter((f):f is FieldDefinition=>Boolean(f))
   row.forEach(f=>used.add(f.key))
   return [{name:field.key==='m_seg1'?'Сегменты':field.key==='m_razot'?'Размеры от и до':field.valueType==='checkbox'?'':field.key.includes('_razm_poch_')?'Размеры':field.key.includes('_tolsh_paren_')?'Толщина паренхимы в средней трети':field.label,fields:row}]
 })
}
export function abdominalUnit(field:FieldDefinition){
 if(field.kind!=='getSizeInput')return ''
 if(field.key==='jelch_ob')return 'мл'
 if(field.key==='sel_obem')return 'см²'
 if(field.key==='polaj_vena1')return 'мм на вдохе'
 if(field.key==='polaj_vena2')return 'мм на выдохе'
 return 'мм'
}

export function originalAbdominalFields(definitions:FieldDefinition[],fields:Record<string,FieldValue>){
 const restored=new Set(revisions.brooho.hiddenFields)
 const original=new Map((catalog.brooho_1 as FieldDefinition[]).map(d=>[d.key,d]))
 const ordered=[...definitions]
 const veinIndex=ordered.findIndex(d=>d.key==='sel_vena')
 if(veinIndex>=0&&ordered.some(d=>d.key==='selez')){
   const [vein]=ordered.splice(veinIndex,1)
   ordered.splice(ordered.findIndex(d=>d.key==='selez'),0,vein)
 }
 const source=ordered.map(d=>{
   const base=original.get(d.key)
   if(!base)return d
   const definition={...d,hidden:restored.has(d.key)?base.hidden:d.hidden}
   const lesion=d.key.match(/^(one|eho|str|kontur|obod|gde|cdk|r1|r2|r3|do|vkl)_obraz([123])$/)
   const labels:Record<string,string>={one:'Вид образования',eho:'Эхогенность образования',str:'Структура образования',kontur:'Контуры образования',obod:'Ободок образования',gde:'Расположение образования',cdk:'При ЦДК',r1:'Размеры образования',r2:'Второй размер образования',r3:'Третий размер образования',do:'Размер до',vkl:'С жидкостными включениями'}
   if(lesion)definition.label=labels[lesion[1]]
   if(d.key==='pechen_str_text')definition.label=base.label
   if(d.key==='polaj_vena1')definition.label='Нижняя полая вена на вдохе'
   if(d.key==='polaj_vena2')definition.label='Нижняя полая вена на выдохе'
   if(d.key==='stenki_size')definition.label='Толщина стенки'
   if(d.key==='port_vena_text'||d.key==='protok_mm'||d.key==='virs_size')definition.label='Диаметр: '+base.label.toLowerCase()

   // This option opens the original lesion controls rather than a dictionary dialog.
   if(d.key==='struktura')definition.options=d.options?.map(option=>{
     const {referenceKey,referenceSection,inputLabel,...rest}=option
     return rest
   })
   return definition
 })
 return editorFields('brooho','1',source,fields,source.map(d=>d.key)).filter(d=>!d.hidden)
}
