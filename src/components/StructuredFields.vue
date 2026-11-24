<script setup lang="ts">
import {computed} from 'vue'
import type {FieldDefinition,FieldValue} from '../types'
import {editorLayoutGroups,editorLayoutRows,editorFieldUnit,editorFieldCaption,hasSourceLayout} from '../editorLayout'
import TemplateTextarea from './TemplateTextarea.vue'
const props=defineProps<{definitions:FieldDefinition[];fields:Record<string,FieldValue>;readonlyKeys?:string[];sectionPrefix?:string;formKey?:string}>()
const emit=defineEmits<{change:[key:string,value:string,type:string];reference:[field:FieldDefinition,referenceKey:string,optionValue?:string];'text-reference':[field:FieldDefinition,target:HTMLTextAreaElement]}>()
const selectItems=(field:FieldDefinition)=>[{label:'Не указано',value:'__empty'},...(field.options||[]).filter(o=>!o.hidden||o.value===props.fields[field.key]?.value).sort((a,b)=>Number(Boolean(a.referenceKey))-Number(Boolean(b.referenceKey))).map(o=>({...o,label:o.inputLabel||o.label}))]
function select(field:FieldDefinition,value:string){const option=field.options?.find(o=>o.value===value);if(option?.referenceKey)emit('reference',field,option.referenceKey,value);else{for(const key of new Set(field.options?.map(o=>o.referenceKey).filter(Boolean)))emit('change',key!,'','textarea_users');emit('change',field.key,value==='__empty'?'':value,'select')}}
const referenceText=(field:FieldDefinition)=>{const option=field.options?.find(o=>o.value===props.fields[field.key]?.value);return option?.referenceKey?props.fields[option.referenceKey]?.value:''}
const checkboxOption=(field:FieldDefinition)=>field.options?.find(o=>o.value===props.fields[field.key]?.value)||field.options?.find(o=>!o.hidden)
const formKey=computed(()=>props.formKey??'')
const sourceLayout=computed(()=>hasSourceLayout(formKey.value))
const groups=computed(()=>editorLayoutGroups(formKey.value,props.definitions,props.fields))
const unit=(field:FieldDefinition)=>editorFieldUnit(formKey.value,field)
const caption=(field:FieldDefinition)=>editorFieldCaption(formKey.value,field)

</script>
<template><section v-for="group in groups" :key="group.fields[0].key" class="structured-group" :class="{'source-form-layout':sourceLayout}" :id="sectionPrefix?sectionPrefix+group.fields[0].key:undefined" :aria-labelledby="sectionPrefix?sectionPrefix+group.fields[0].key+'-title':undefined" tabindex="-1"><h3 :id="sectionPrefix?sectionPrefix+group.fields[0].key+'-title':undefined" class="structured-group-title">{{group.name}}</h3><div v-for="block in group.blocks" :key="block.fields[0].key" class="structured-block"><h4 v-if="block.name==='Размеры'||block.name?.startsWith('Единичное образование ')" class="structured-block-title" :class="{'source-dimensions-title':block.name==='Размеры'}">{{block.name}}</h4><div class="structured-rows" :class="sourceLayout?'source-rows':'grid grid-cols-1 md:grid-cols-2 gap-6'">
<template v-for="row in (sourceLayout?editorLayoutRows(formKey,block.fields):block.fields.map(field=>({name:field.label,fields:[field]})))" :key="row.fields[0].key">
<div :class="sourceLayout?'source-field-row':'contents'">
  <span v-if="sourceLayout" class="source-row-label" aria-hidden="true">{{row.name}}</span>
  <div :class="sourceLayout?['source-row-controls',{'source-segments':row.fields.length>1&&row.fields.every(field=>field.valueType==='checkbox')}]:'contents'">
  <UFormField v-for="field in row.fields" :key="field.key" :data-field="field.key" :ui="sourceLayout?{labelWrapper:'sr-only',container:'mt-0'}:undefined" :class="{'structured-checkbox-field':field.valueType==='checkbox'&&field.options?.length,'source-numeric-field':sourceLayout&&(field.kind==='getSizeInput'||field.kind==='getHidden'||Boolean(unit(field)))}" :label="field.valueType==='checkbox'&&field.options?.length?undefined:field.label">
    <span v-if="sourceLayout&&field!==row.fields[0]&&field.valueType!=='checkbox'&&caption(field)" class="source-control-caption">{{caption(field)}}</span>
    <template v-if="field.referenceKey"><div class="flex items-start gap-2"><p class="min-w-0 flex-1 preserve-lines" :class="{'text-muted':!fields[field.key]?.value}">{{fields[field.key]?.value||'Не указано'}}</p><UButton type="button" color="neutral" variant="outline" size="sm" icon="i-lucide-book-open" class="study-template-trigger" aria-label="Выбрать из справочника" aria-haspopup="dialog" :title="`Шаблоны для поля «${field.label}»`" @click="emit('reference',field,field.referenceKey)"/></div><UButton v-if="fields[field.key]?.value" color="neutral" variant="ghost" size="sm" @click="emit('change',field.key,'',field.valueType||'string')">Очистить</UButton></template>
    <template v-else-if="field.valueType==='select'&&field.options?.length"><USelect :model-value="fields[field.key]?.value||'__empty'" :items="selectItems(field)" @update:model-value="select(field,$event)" class="w-full"/><template v-if="referenceText(field)"><p class="preserve-lines mt-3">{{referenceText(field)}}</p><UButton color="neutral" variant="ghost" size="sm" icon="i-lucide-book-open" @click="emit('reference',field,field.options!.find(o=>o.value===fields[field.key]?.value)!.referenceKey!,fields[field.key]?.value)">Изменить выбор</UButton></template></template>
    <UCheckbox v-else-if="field.valueType==='checkbox'&&field.options?.length" :model-value="Boolean(fields[field.key]?.value&&fields[field.key]?.value!=='0')" :label="checkboxOption(field)?.label||field.label" @update:model-value="emit('change',field.key,$event?checkboxOption(field)?.value||'':'','checkbox')" variant="card" class="structured-checkbox"/>
    <TemplateTextarea v-else-if="field.kind==='get'||field.kind.includes('TextArea')" :label="formKey?field.label:undefined" :model-value="fields[field.key]?.value||''" :rows="2" @update:model-value="emit('change',field.key,$event,field.valueType||'string')" @reference="emit('text-reference',field,$event)"/>
    <div v-else :class="sourceLayout?'source-input-with-unit':undefined"><UInput :model-value="fields[field.key]?.value||''" @update:model-value="emit('change',field.key,$event,field.valueType||'string')" :readonly="readonlyKeys?.includes(field.key)" class="w-full"/><span v-if="sourceLayout&&unit(field)" class="source-unit">{{unit(field)}}</span></div>
  </UFormField>
</div></div></template></div></div></section></template>
