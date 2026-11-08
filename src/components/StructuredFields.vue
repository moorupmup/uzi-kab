<script setup lang="ts">
import {computed} from 'vue'
import type {FieldDefinition,FieldValue} from '../types'
const props=defineProps<{definitions:FieldDefinition[];fields:Record<string,FieldValue>;readonlyKeys?:string[]}>()
const emit=defineEmits<{change:[key:string,value:string,type:string]}>()
const groups=computed(()=>{const result:{name:string;fields:FieldDefinition[]}[]=[];for(const field of props.definitions){const name=field.group||'Параметры исследования';let group=result.at(-1);if(!group||group.name!==name){group={name,fields:[]};result.push(group)}group.fields.push(field)}return result})
</script>
<template><section v-for="(group,index) in groups" :key="index" class="structured-group"><h3 v-if="groups.length>1" class="mb-5">{{group.name}}</h3><div class="grid grid-cols-1 md:grid-cols-2 gap-6">
  <UFormField v-for="field in group.fields" :key="field.key" :data-field="field.key" :label="field.valueType==='checkbox'&&field.options?.length?undefined:field.label">
    <USelect v-if="field.valueType==='select'&&field.options?.length" :model-value="fields[field.key]?.value||'__empty'" :items="[{label:'Не указано',value:'__empty'},...field.options]" @update:model-value="emit('change',field.key,$event==='__empty'?'':$event,'select')" class="w-full"/>
    <UCheckbox v-else-if="field.valueType==='checkbox'&&field.options?.length" :model-value="Boolean(fields[field.key]?.value&&fields[field.key]?.value!=='0')" :label="field.options[0].label" @update:model-value="emit('change',field.key,$event?field.options![0].value:'','checkbox')" class="min-h-11 items-center"/>
    <UTextarea v-else-if="field.kind==='get'||field.kind.includes('TextArea')" :model-value="fields[field.key]?.value||''" @update:model-value="emit('change',field.key,$event,field.valueType||'string')" :rows="3" autoresize class="w-full"/>
    <UInput v-else :model-value="fields[field.key]?.value||''" @update:model-value="emit('change',field.key,$event,field.valueType||'string')" :readonly="readonlyKeys?.includes(field.key)" class="w-full"/>
  </UFormField>
</div></section></template>
