<script setup lang="ts">
import {ref,watch} from 'vue'
import {useRoute} from 'vue-router'
import {command,message} from '../api'
import type {Study} from '../types'
import ProtocolDocument from '../components/ProtocolDocument.vue'
import PageHeading from '../components/PageHeading.vue'
const route=useRoute(),bundle=ref<{id:number;name:string;patient_id:number;patientName:string}>(),studies=ref<Study[]>([]),error=ref(''),loading=ref(false)
watch(()=>route.params.id,async(id,_previous,onCleanup)=>{let current=true;onCleanup(()=>{current=false});bundle.value=undefined;studies.value=[];error.value='';loading.value=true;try{const result=await command<{bundle:typeof bundle.value;studies:Study[]}>('bundle_detail',{id:Number(id)});if(current){bundle.value=result.bundle;studies.value=result.studies}}catch(e){if(current)error.value=message(e)}finally{if(current)loading.value=false}},{immediate:true})
const print=()=>{if(!loading.value&&!error.value&&studies.value.length)window.print()}
</script>
<template><section class="page-content"><RouterLink v-if="bundle" :to="'/patients/'+bundle.patient_id" class="back-link no-print"><UIcon name="i-lucide-arrow-left"/>К карточке пациента</RouterLink><PageHeading :title="bundle?.name||'Объединённый протокол'" :description="bundle?.patientName"><UButton icon="i-lucide-printer" :disabled="loading||Boolean(error)||!studies.length" :loading="loading" @click="print">Печать всех исследований</UButton></PageHeading><UAlert v-if="error" color="error" variant="soft" :description="error"/><p class="text-slate-600 mb-6 no-print">Исследования остаются отдельными записями. Общая печать не изменяет исходные заключения.</p><div class="bundle-documents"><ProtocolDocument v-for="study in studies" :key="study.id" :study="study"/></div></section></template>
