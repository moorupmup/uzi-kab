<script setup lang="ts">
import {computed,ref,watch,onBeforeUnmount,onMounted} from 'vue'
import {getCurrentWindow} from '@tauri-apps/api/window'
import {useRoute,useRouter,onBeforeRouteLeave} from 'vue-router'
import {useAuth} from '../stores/auth'
import {useDatabase} from '../stores/database'
import {command,message,desktop} from '../api'
import {date,localDate,isDeleted} from '../format'
import type {Study,Patient,FieldValue,FieldDefinition,FormSnapshot} from '../types'
import catalogData from '../catalog.json'
import {formFields} from '../formSnapshots'
import {reviseForm} from '../formRevisions'
import {editorLayoutGroups,studyEditorDefinitions} from '../editorLayout'
import {renderLegacy,resolveValue} from '../legacy'
import {recalculateAutomatic,calculationDependencies,calculatedKeys} from '../calculations'
import versionsData from '../legacy-versions.json'
import TemplateLibrary from '../components/TemplateLibrary.vue'
import {appendTemplate,templateFieldSection,type UserTemplate} from '../userTemplates'
import ProtocolDocument from '../components/ProtocolDocument.vue'
import Attachments from '../components/Attachments.vue'
import StructuredFields from '../components/StructuredFields.vue'
import PageHeading from '../components/PageHeading.vue'
import StudyDatePicker from '../components/StudyDatePicker.vue'
import TemplateTextarea from '../components/TemplateTextarea.vue'

const referenceSelection=ref<{label:string;key:string;apply:(text:string)=>void}>()
let restoreReferenceFocus:(()=>void)|undefined

function openReference(label:string,key:string,apply:(text:string)=>void){
 const trigger=document.activeElement
 restoreReferenceFocus=()=>{if(trigger instanceof HTMLElement&&trigger.isConnected)trigger.focus({preventScroll:true})}
 referenceSelection.value={label,key,apply}
}
function closeReference(){referenceSelection.value=undefined}
function focusAfterReference(event:Event){
 const restore=restoreReferenceFocus
 if(!restore)return
 event.preventDefault()
 restoreReferenceFocus=undefined
 requestAnimationFrame(restore)
}
function parameterReferenceKey(field:string){return `CONFIG.USERS_PARAMS.${referenceCode.value}.${field}`}

function selectReference(field:FieldDefinition,targetKey:string,optionValue?:string){
 const section=field.options?.find(option=>option.value===optionValue)?.referenceSection??templateFieldSection(editorFormKey.value,targetKey)
 openReference(field.label,parameterReferenceKey(section),text=>{
  updateField(targetKey,appendTemplate(fields.value[targetKey]?.value||'',text))
  if(optionValue)updateField(field.key,optionValue,'select')
 })
}
function openTextReference(label:string,key:string,target:HTMLTextAreaElement,update:(value:string)=>void){
 const textarea=target
 openReference(label,key,text=>{
  const value=appendTemplate(textarea.value,text)
  update(value)
  restoreReferenceFocus=()=>{
   textarea.focus({preventScroll:true})
   textarea.setSelectionRange(value.length,value.length)
  }
 })
}
function selectFieldTextReference(field:FieldDefinition,target:HTMLTextAreaElement){
 const section=templateFieldSection(editorFormKey.value,field.key)
 openTextReference(field.label,parameterReferenceKey(section),target,value=>updateField(field.key,value,field.valueType||'string'))
}
function insertTemplate(entry:UserTemplate,text=entry.value||entry.name){
 if(!referenceSelection.value)return
 referenceSelection.value.apply(text)
 success.value=''
}
const versions=versionsData as Record<string,string>
const preservedForm=ref<FormSnapshot>(),sourceId=ref<number>()
const templateVersion=ref('1')
const catalog=catalogData as Record<string,FieldDefinition[]>
const route=useRoute(),router=useRouter(),db=useDatabase(),auth=useAuth()
const record=ref<Study>(),patient=ref<Patient>(),templateId=ref<number>(),doctorId=ref<number>(),studyDate=ref(localDate()),conclusion=ref(''),addition=ref(''),fields=ref<Record<string,FieldValue>>({}),status=ref('draft'),error=ref(''),saving=ref(false),loading=ref(false),snapshot=ref(''),confirmLeave=ref(false),discardAction=ref<null|(()=>void)>(null),success=ref('')
const previewMode=ref(false),deleteOpen=ref(false)
const removed=computed(()=>isDeleted(record.value?.status||''))
const canManage=computed(()=>Boolean(record.value&&auth.canWrite&&(auth.admin||record.value.doctor_id===auth.user?.doctorId)))
const isArchive=computed(()=>record.value?.origin==='legacy')
const readonly=computed(()=>previewMode.value||removed.value||!auth.canWrite||Boolean(record.value&&!isArchive.value&&auth.user?.role==='doctor'&&record.value.doctor_id!==auth.user.doctorId)),isNew=computed(()=>!route.params.id)
const currentTemplate=computed(()=>db.info?.templates.find(t=>t.id===templateId.value))
const referenceCode=computed(()=>currentTemplate.value?.code||record.value?.templateCode||'')
const effectiveForm=computed(()=>preservedForm.value||currentTemplate.value?.formSnapshot||reviseForm({code:currentTemplate.value?.formCode||currentTemplate.value?.code.toLowerCase()||'',version:templateVersion.value,configurationRevision:0,definitions:catalog[(currentTemplate.value?.formCode||currentTemplate.value?.code.toLowerCase()||'')+'_'+templateVersion.value]||[]}))
const formCode=computed(()=>effectiveForm.value?.code||currentTemplate.value?.formCode||currentTemplate.value?.code||record.value?.templateCode||'')
const definitions=computed(()=>effectiveForm.value?.definitions||catalog[formCode.value.toLowerCase()+'_'+templateVersion.value]||[])
const additionalDefinitions=computed<FieldDefinition[]>(()=>{const known=new Set(definitions.value.map(d=>d.key));return Object.entries(fields.value).filter(([key])=>key!=='description'&&!key.startsWith('_')&&!known.has(key)).map(([key,value])=>({key,label:key,kind:'get',valueType:value.type}))})
const templateItems=computed(()=>{const items=db.info?.templates.filter(t=>!t.hidden||t.id===record.value?.template_id).map(t=>({label:t.name,value:t.id}))||[];if(record.value&&!items.some(t=>t.value===record.value!.template_id))items.unshift({label:record.value.title||'Вид исследования не указан',value:record.value.template_id});return items})
const selectedDoctorName=computed(()=>record.value&&record.value.doctor_id===doctorId.value?record.value.doctor||'Не указан':db.info?.doctors.find(d=>d.id===doctorId.value)?.name||'Не выбран')
const doctorItems=computed(()=>{const items=db.info?.doctors.map(d=>({label:record.value?.doctor_id===d.id?record.value.doctor||d.name:d.name,value:d.id}))||[];if(record.value&&!items.some(d=>d.value===record.value!.doctor_id))items.unshift({label:record.value.doctor||'Врач не указан',value:record.value.doctor_id});return items})
const rendered=computed(()=>renderLegacy(formCode.value,templateVersion.value,fields.value))
const hasStructuredData=computed(()=>definitions.value.some(d=>Boolean(fields.value[d.key]?.value)))
const useRendered=computed(()=>rendered.value.supported&&!rendered.value.unknownValues.length&&(readonly.value||hasStructuredData.value))
const editorFormKey=computed(()=>formCode.value.toLowerCase()+'_'+templateVersion.value)
const activeDefinitions=computed(()=>studyEditorDefinitions(editorFormKey.value,definitions.value,fields.value))
const editorGroups=computed(()=>editorLayoutGroups(editorFormKey.value,activeDefinitions.value,fields.value))
const contents=computed(()=>[
 ...editorGroups.value.map(group=>({id:'study-section-'+group.fields[0].key,name:group.name})),
 ...(additionalDefinitions.value.length?[{id:'study-additional',name:'Сохранённые параметры'}]:[]),
 ...(!effectiveForm.value?.editor?.hideDescription?[{id:'study-description',name:'Описание исследования'}]:[]),
 {id:'study-conclusion',name:'Заключение'},
 {id:'study-recommendations',name:'Дополнение и рекомендации'}
])
function goToSection(id:string){
 const section=document.getElementById(id)
 if(!section)return
 section.focus({preventScroll:true})
 section.scrollIntoView({behavior:window.matchMedia('(prefers-reduced-motion: reduce)').matches?'instant':'smooth',block:'start'})
}

const calculationCode=computed(()=>formCode.value.toLowerCase())
const calculationPending=computed(()=>fields.value._calculation_pending?.value==='1')
const visibleFields=computed(()=>{
  const byKey=new Map(definitions.value.map(d=>[d.key,d]))
  return Object.entries(fields.value).filter(([key,v])=>!key.startsWith('_')&&v.value).map(([key,v])=>({key,label:byKey.get(key)?.label||key,value:resolveValue(v)}))
})
const loadedStudy=ref(false)
const formState=()=>JSON.stringify([templateId.value,doctorId.value,studyDate.value,conclusion.value,addition.value,fields.value,status.value,templateVersion.value])
const dirty=computed(()=>!readonly.value&&snapshot.value!==''&&formState()!==snapshot.value)
const validationStatus=ref('')
watch(()=>route.fullPath,load,{immediate:true})
async function load(){validationStatus.value='';loadedStudy.value=false;loading.value=true;error.value='';success.value='';snapshot.value='';previewMode.value=false;record.value=undefined;preservedForm.value=undefined;sourceId.value=undefined;patient.value=undefined;fields.value={};conclusion.value='';addition.value='';studyDate.value=localDate();status.value='draft';templateId.value=undefined;doctorId.value=auth.user?.role==='doctor'?auth.user.doctorId||undefined:undefined
 try{if(!db.info)await db.load();if(route.params.id){const s=await command<Study>('study_detail',{id:Number(route.params.id)});record.value=s;preservedForm.value=s.formSnapshot;templateVersion.value=s.legacy_version||'1';templateId.value=s.template_id;doctorId.value=s.doctor_id;studyDate.value=s.date.slice(0,10);conclusion.value=s.conclusion;addition.value=s.addition;fields.value=formFields(s.fields,s.formSnapshot);status.value=s.status;if(s.patient_id){try{const p=await command<{patient:Patient}>('patient_detail',{id:s.patient_id});patient.value=p.patient}catch(e){if(!message(e).includes('Пациент не найден'))throw e}}}else{const p=await command<{patient:Patient}>('patient_detail',{id:Number(route.params.patientId)});patient.value=p.patient}snapshot.value=formState();if(isNew.value&&route.query.from){const source=await command<Study>('study_detail',{id:Number(route.query.from)});if(source.patient_id!==patient.value?.id)throw new Error('Исходное исследование относится к другому пациенту');sourceId.value=source.id;preservedForm.value=source.formSnapshot;templateId.value=source.template_id;templateVersion.value=source.legacy_version||'1';doctorId.value=auth.user?.role==='doctor'?auth.user.doctorId||undefined:source.doctor_id;conclusion.value=source.conclusion;addition.value=source.addition;fields.value=formFields(source.fields,source.formSnapshot);if(calculationDependencies[calculationCode.value]?.some(key=>fields.value[key]?.value))recalculateAutomatic(calculationCode.value,fields.value,undefined,templateVersion.value)}loadedStudy.value=Boolean(record.value)}catch(e){error.value=message(e)}finally{loading.value=false}}
function updateField(key:string,value:string,type?:string){if(fields.value[key]?.value===value)return;fields.value[key]=formFields({[key]:{value,type:type||fields.value[key]?.type||'text'}},effectiveForm.value)[key];if(calculationDependencies[calculationCode.value]?.includes(key))recalculateAutomatic(calculationCode.value,fields.value,key,templateVersion.value)}
const confirmTemplate=ref(false),pendingTemplate=ref<number>()
function requestTemplate(value:number){if(value===templateId.value)return;if(Object.entries(fields.value).some(([key,v])=>key!=='description'&&v.value)){pendingTemplate.value=value;confirmTemplate.value=true}else{pendingTemplate.value=value;changeTemplate()}}
function changeTemplate(){preservedForm.value=undefined;sourceId.value=undefined;const description=fields.value.description;fields.value=description?{description}:{};templateId.value=pendingTemplate.value;const code=db.info?.templates.find(t=>t.id===templateId.value)?.code.toLowerCase()||'';templateVersion.value=db.info?.templates.find(t=>t.id===templateId.value)?.version||versions[code]||'1';confirmTemplate.value=false}
let unlistenClose:(()=>void)|undefined
onMounted(async()=>{if(desktop)unlistenClose=await getCurrentWindow().onCloseRequested(event=>{if(dirty.value){event.preventDefault();discardAction.value=()=>{void getCurrentWindow().destroy()};confirmLeave.value=true}})})
onBeforeUnmount(()=>unlistenClose?.())
const missingStudyFields=computed(()=>{
 const missing:string[]=[]
 if(templateId.value==null)missing.push('вид исследования')
 if(doctorId.value==null)missing.push('врач')
 if(!studyDate.value)missing.push('дата исследования')
 if(validationStatus.value==='final'&&!conclusion.value.trim())missing.push('заключение')
 return missing
})
function validateStudy(nextStatus:string){
 validationStatus.value=nextStatus
 if(missingStudyFields.value.length)return false
 validationStatus.value=''
 return true
}
async function save(nextStatus:string){error.value='';success.value='';if(!validateStudy(nextStatus))return;saving.value=true;try{const id=await command<number>('save_study',{input:{formRevision:effectiveForm.value?.configurationRevision??null,sourceId:sourceId.value??null,id:record.value?.id??null,revision:record.value?.revision??null,patientId:patient.value?.id??record.value?.patient_id,templateId:templateId.value,doctorId:doctorId.value,date:studyDate.value,conclusion:conclusion.value,addition:addition.value,fields:fields.value,status:nextStatus,templateVersion:templateVersion.value}});snapshot.value=formState();await db.load();if(isNew.value)await router.replace('/studies/'+id);else await load();success.value=nextStatus==='final'?'Исследование завершено и сохранено':'Черновик сохранён'}catch(e){loadedStudy.value=false;error.value=message(e)}finally{saving.value=false}}
async function copy(){const s=record.value;if(s)await router.push('/studies/new/'+s.patient_id+'?from='+s.id)}
let cancelNavigation:(()=>void)|null=null
onBeforeRouteLeave((_to,_from,next)=>{if(!dirty.value){next();return}cancelNavigation=()=>next(false);discardAction.value=()=>{cancelNavigation=null;next()};confirmLeave.value=true})
function cancelLeave(){cancelNavigation?.();cancelNavigation=null;discardAction.value=null;confirmLeave.value=false}
function discard(){snapshot.value=formState();discardAction.value?.();confirmLeave.value=false;discardAction.value=null}
function unload(event:BeforeUnloadEvent){if(dirty.value){event.preventDefault();event.returnValue=''}}
window.addEventListener('beforeunload',unload);onBeforeUnmount(()=>window.removeEventListener('beforeunload',unload))
const print=()=>{if(loadedStudy.value&&record.value&&!loading.value&&!saving.value&&!removed.value&&!dirty.value)window.print()}
const moreActions=computed(()=>[
 {label:'Обновить документ',icon:'i-lucide-refresh-cw',disabled:dirty.value||loading.value||saving.value,onSelect:()=>load()},
 {label:previewMode.value?'Вернуться к редактированию':'Предпросмотр документа',icon:'i-lucide-eye',disabled:dirty.value||removed.value||!record.value||!loadedStudy.value||(!previewMode.value&&readonly.value),onSelect:()=>{previewMode.value=!previewMode.value}},
 ...(canManage.value?[{label:removed.value?'Восстановить исследование':'Удалить исследование',icon:removed.value?'i-lucide-undo-2':'i-lucide-trash-2',disabled:dirty.value||saving.value,onSelect:()=>{deleteOpen.value=true}}]:[])
])
async function changeDeleted(){if(!record.value)return;saving.value=true;error.value='';try{const removing=!removed.value;await command('set_study_deleted',{id:record.value.id,revision:record.value.revision,deleted:removing});deleteOpen.value=false;await load();await db.load();success.value=removing?'Исследование удалено. Его можно восстановить.':'Исследование восстановлено.'}catch(e){error.value=message(e)}finally{saving.value=false}}

</script>
<template><section class="page-content study-page" :class="{'study-deleted':removed}"><p v-if="dirty||!record||!loadedStudy" class="print-blocked-notice unsaved-print-notice">{{loadedStudy?'Сохраните исследование и откройте предпросмотр перед печатью.':'Документ не готов к печати. Обновите его и проверьте сообщение программы.'}}</p><p v-if="removed" class="print-blocked-notice">Исследование удалено. Печать документа недоступна до восстановления.</p><RouterLink v-if="patient" :to="'/patients/'+patient.id" class="back-link no-print"><UIcon name="i-lucide-arrow-left"/>К карточке пациента</RouterLink><PageHeading :title="previewMode?'Предпросмотр исследования':readonly?'Просмотр исследования':isNew?'Новое исследование':'Редактирование исследования'" :description="patient?.name||record?.patientName"><template v-if="readonly"><UButton v-if="previewMode" variant="outline" color="neutral" icon="i-lucide-pencil" @click="previewMode=false">Вернуться к редактированию</UButton><UButton color="neutral" variant="outline" icon="i-lucide-copy-plus" @click="copy" :disabled="!desktop||!auth.canWrite||!patient">Создать на основе</UButton><UButton icon="i-lucide-printer" :disabled="removed||loading||saving||!loadedStudy" @click="print">Печать</UButton></template><template v-else><UBadge v-if="dirty" icon="i-lucide-pencil" :ui="{leadingIcon:'size-4'}" color="warning" variant="subtle" class="dirty-indicator" role="status">Есть изменения</UBadge><UButton color="neutral" variant="outline" :disabled="saving||!desktop||!auth.canWrite||loading" :loading="saving" @click="save('draft')">Сохранить черновик</UButton><UButton icon="i-lucide-check" :disabled="saving||!desktop||!auth.canWrite||loading" @click="save('final')">Завершить</UButton></template><UDropdownMenu v-if="record" :items="moreActions"><UButton color="neutral" variant="outline" icon="i-lucide-ellipsis" :disabled="loading||saving">Ещё</UButton></UDropdownMenu></PageHeading>
<UAlert v-if="removed" icon="i-lucide-trash-2" :ui="{icon:'size-4'}" color="warning" title="Исследование удалено" description="Документ сохранён для просмотра. Чтобы редактировать или распечатать его, восстановите запись. Исходные архивные удаления восстанавливаются как черновики." class="mb-5 no-print"/><UAlert v-if="calculationPending" icon="i-lucide-calculator" :ui="{icon:'size-4'}" color="warning" variant="soft" title="Расчёт не выполнен" description="Размеры изменились, прежние вычисленные значения удалены. Можно завершить и распечатать исследование без расчёта. Расчёт выполняется автоматически после заполнения необходимых размеров." class="mb-5 no-print"/><UAlert v-if="validationStatus&&missingStudyFields.length" icon="i-lucide-circle-alert" color="error" variant="soft" title="Заполните обязательные поля" :description="missingStudyFields.join(', ')" role="alert" class="mb-5 no-print"/><UAlert v-if="error" icon="i-lucide-circle-alert" :ui="{icon:'size-4'}" color="error" :description="error" class="mb-5 no-print"/><UAlert v-if="rendered.unknownValues.length" icon="i-lucide-triangle-alert" :ui="{icon:'size-4'}" color="warning" title="Часть значений отсутствует в исходном справочнике" description="Показаны сохранённые параметры. Печатный текст для этой записи требует проверки." class="mb-5 no-print"/><UAlert v-if="!rendered.supported&&(currentTemplate||readonly)" icon="i-lucide-info" :ui="{icon:'size-4'}" color="warning" title="Для этой версии шаблона доступны сохранённые параметры" description="Точное формирование связного текста пока не поддерживается." class="mb-5 no-print"/><UAlert v-if="success" icon="i-lucide-circle-check" :ui="{icon:'size-4'}" color="success" variant="soft" :description="success" class="mb-5 no-print"/>
<div v-if="loading" class="loading-state">Открываем исследование…</div><template v-else-if="patient||record||readonly">
<div class="study-layout" :class="{'readonly-layout':readonly}">
<aside v-if="!readonly" class="study-settings no-print" aria-label="Параметры исследования">
  <div class="study-settings-fields">
    <UFormField label="Вид исследования" required><USelect :model-value="templateId" :items="templateItems" placeholder="Выберите исследование" class="w-full" @update:model-value="requestTemplate"/></UFormField>
    <UFormField label="Врач" required><USelect :disabled="auth.user?.role==='doctor'&&!isArchive" v-model="doctorId" :items="doctorItems" placeholder="Выберите врача" class="w-full"/></UFormField>
    <UFormField label="Дата исследования" required><StudyDatePicker v-model="studyDate"/></UFormField>
  </div>
<nav v-if="templateId != null && contents.length" class="study-contents" aria-labelledby="study-contents-title">
    <h2 id="study-contents-title">Содержание</h2>
    <ul><li v-for="item in contents" :key="item.id"><a :href="'#'+item.id" @click.prevent="goToSection(item.id)">{{item.name}}</a></li></ul>
  </nav>
</aside>
<ProtocolDocument v-if="readonly&&record&&loadedStudy" :study="record"/><template v-else><ProtocolDocument v-if="record&&!dirty&&loadedStudy" :study="record" class="print-only saved-print-document"/><article class="document-sheet editor-document"><div class="document-header"><span class="document-brand"><UIcon name="i-lucide-activity"/>Протокол исследования</span><span>{{date(studyDate)}}<template v-if="record"> · № {{record.id}}</template></span></div><h2>{{(record?.template_id===templateId?record?.title:undefined)||currentTemplate?.name||'Выберите вид исследования'}}</h2><dl class="document-patient"><div><dt>Пациент</dt><dd>{{patient?.name||record?.patientName||'Без карточки пациента'}}</dd></div><div><dt>Дата рождения</dt><dd>{{date(patient?.birthdate||record?.patientBirthdate)}}</dd></div><div><dt>Врач</dt><dd>{{selectedDoctorName}}</dd></div></dl>
<p v-if="calculationCode==='shit'" class="print-unit-note">В исходном шаблоне объём обозначен как «мм». Обозначения сохранены для сопоставления с архивом. При размерах в миллиметрах исходная формула рассчитывает объём в см³.</p>
<p v-if="record?.status==='draft'||record?.status==='legacy:0'" class="print-unit-note">ЧЕРНОВИК. Исследование не завершено.</p><p v-if="calculationPending" class="print-unit-note">Вычисленные значения удалены после изменения размеров. Расчёт не выполнен.</p>
<template v-if="readonly"><section v-if="useRendered" class="document-section legacy-protocol" v-html="rendered.html"></section><section v-else-if="visibleFields.length" class="document-section"><h3>Сохранённые параметры исследования</h3><dl class="archive-fields"><div v-for="field in visibleFields" :key="field.key"><dt>{{field.label}}</dt><dd>{{field.value}}</dd></div></dl></section><section class="document-section"><h3>Заключение</h3><p class="preserve-lines">{{conclusion||'Заключение не заполнено'}}</p></section><section v-if="addition" class="document-section"><h3>Дополнение</h3><p class="preserve-lines">{{addition}}</p></section><p v-if="isArchive" class="archive-print-note">{{rendered.supported&&!rendered.unknownValues.length?'Архивная запись. Содержание сформировано по исходному шаблону; оформление адаптировано для A4.':'Архивная запись. Показаны сохранённые параметры; связный текст для этой версии требует проверки.'}}</p></template>
<template v-else-if="templateId != null">
  <section v-if="definitions.length" class="document-section no-print">
    <StructuredFields :readonly-keys="calculatedKeys[calculationCode]||[]" :form-key="editorFormKey" section-prefix="study-section-" :definitions="activeDefinitions" :fields="fields" @change="updateField" @reference="selectReference" @text-reference="selectFieldTextReference"/>
    <section v-if="useRendered" class="document-section"><h3>Предпросмотр протокола</h3><div class="legacy-protocol" v-html="rendered.html"></div></section>
  </section>
  <section v-if="additionalDefinitions.length" id="study-additional" tabindex="-1" class="document-section no-print">
    <h3>Сохранённые параметры</h3><StructuredFields :definitions="additionalDefinitions" :fields="fields" @change="updateField" @reference="selectReference"/>
  </section>
  <section v-if="!effectiveForm?.editor?.hideDescription" id="study-description" tabindex="-1" class="document-section no-print">
    <h3>Описание исследования</h3>
    <UFormField label="Протокол" description="Свободное описание результатов исследования">
      <TemplateTextarea label="Протокол" :model-value="fields.description?.value||''" :rows="8" placeholder="Опишите результаты исследования…"
        @update:model-value="updateField('description',$event)" @reference="openTextReference('Протокол',parameterReferenceKey('description'),$event,value=>updateField('description',value))"/>
    </UFormField>
  </section>
  <section id="study-conclusion" tabindex="-1" class="document-section no-print">
    <UFormField label="Заключение" required>
      <TemplateTextarea v-model="conclusion" label="Заключение" :rows="5" placeholder="Введите заключение…"
        @reference="openTextReference('Заключение',`BASE.DECISION.${referenceCode}`,$event,value=>conclusion=value)"/>
    </UFormField>
  </section>
  <section id="study-recommendations" tabindex="-1" class="document-section no-print">
    <UFormField label="Дополнение и рекомендации">
      <TemplateTextarea v-model="addition" label="Дополнение и рекомендации" :rows="3" placeholder="При необходимости"
        @reference="openTextReference('Дополнение и рекомендации',`CONFIG.ADDITION.${referenceCode}`,$event,value=>addition=value)"/>
    </UFormField>
  </section>
  <div v-if="record" class="flex justify-end no-print"><UButton variant="ghost" color="neutral" icon="i-lucide-printer" @click="print" :disabled="dirty||loading||saving||!loadedStudy">Печать сохранённой записи</UButton></div>
</template>
<p v-if="!readonly && templateId == null" class="document-section text-muted no-print">Выберите вид исследования в левой колонке, чтобы начать заполнять протокол</p>
</article></template></div><Attachments v-if="record" :study-id="record.id" :editable="!readonly&&auth.canWrite&&desktop"/></template>
<UModal v-model:open="deleteOpen" :dismissible="!saving" :title="removed?'Восстановить исследование?':'Удалить исследование?'" :description="removed?'Запись вернётся в историю. Если прежний статус архива неизвестен, она станет черновиком.':'Документ и вложения сохранятся. Запись можно восстановить; комплекты с ней потребуют проверки.'"><template #body><UAlert v-if="error" icon="i-lucide-circle-alert" :ui="{icon:'size-4'}" color="error" :description="error"/></template><template #footer><UButton color="neutral" variant="outline" :disabled="saving" @click="deleteOpen=false">Отмена</UButton><UButton :color="removed?'primary':'error'" :loading="saving" :disabled="saving" @click="changeDeleted">{{removed?'Восстановить':'Удалить'}}</UButton></template></UModal>
<UModal :open="Boolean(referenceSelection)" :title="referenceSelection?`Шаблоны — ${referenceSelection.label}`:'Шаблоны'"
  :ui="{content:'sm:max-w-3xl'}" :content="{onCloseAutoFocus:focusAfterReference}" @update:open="(open:boolean)=>{if(!open)closeReference()}">
  <template #body><TemplateLibrary v-if="referenceSelection" :key="referenceSelection.key" :template-id="templateId" :reference-key="referenceSelection.key" pick @select="insertTemplate"/></template>
</UModal>
<UModal v-model:open="confirmTemplate" title="Сменить вид исследования?" description="Заполненные поля прежнего шаблона будут удалены. Свободное описание, заключение и рекомендации сохранятся."><template #footer><UButton color="neutral" variant="outline" @click="confirmTemplate=false">Оставить прежний вид</UButton><UButton color="warning" @click="changeTemplate">Сменить и очистить поля</UButton></template></UModal>
<UModal :open="confirmLeave" @update:open="cancelLeave" :ui="{content:'unsaved-changes-modal'}" :close="{'aria-label':'Закрыть'}" title="Остались несохранённые изменения" description="Сохраните исследование или выйдите без сохранения."><template #footer><UButton color="neutral" variant="outline" @click="cancelLeave">Продолжить редактирование</UButton><UButton color="error" @click="discard">Выйти без сохранения</UButton></template></UModal>
</section></template>

