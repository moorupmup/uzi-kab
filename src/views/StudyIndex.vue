<script setup lang="ts">
import {ref,watch,onMounted,onBeforeUnmount} from 'vue'
import {command,message} from '../api'
import type {StudySummary,Page} from '../types'
import {date,number,studyStatus} from '../format'
import PageHeading from '../components/PageHeading.vue'
import EmptyState from '../components/EmptyState.vue'
import TablePagination from '../components/TablePagination.vue'
const status=ref('active'),statusItems=[{value:'active',label:'Все действующие'},{value:'draft',label:'Черновики'},{value:'final',label:'Завершённые'},{value:'deleted',label:'Удалённые'},{value:'all',label:'Все, включая удалённые'}]
const query=ref(''),page=ref(1),pageSize=ref(50),total=ref(0),items=ref<StudySummary[]>([]),error=ref(''),loading=ref(false)
let timer:ReturnType<typeof setTimeout>,request=0
async function load(){const token=++request;loading.value=true;error.value='';try{const r=await command<Page<StudySummary>>('list_studies',{query:query.value,page:page.value-1,pageSize:pageSize.value,status:status.value});if(token===request){items.value=r.items;total.value=r.total}}catch(e){if(token===request)error.value=message(e)}finally{if(token===request)loading.value=false}}
watch(status,()=>{page.value=1;load()});watch(query,()=>{clearTimeout(timer);timer=setTimeout(()=>{page.value=1;load()},250)});watch([page,pageSize],load);onMounted(load);onBeforeUnmount(()=>clearTimeout(timer))
function changePageSize(size:number){page.value=1;pageSize.value=size}
</script>
<template><section class="page-content"><PageHeading title="Исследования" description="Все исследования в одной хронологии"/><div class="flex items-end flex-wrap gap-4 mb-6"><UInput v-model="query" icon="i-lucide-search" placeholder="ФИО пациента или номер исследования" aria-label="Поиск исследований" size="lg" class="w-full max-w-xl"/><UFormField label="Состояние исследования"><USelect v-model="status" :items="statusItems" class="w-64"/></UFormField></div><UAlert v-if="error" color="error" :description="error"/><div class="result-caption"><span>Найдено <strong>{{number(total)}}</strong> исследований</span></div><div class="table-panel"><div class="table-scroll"><table class="patient-table"><thead><tr><th>Дата</th><th>Пациент</th><th>Исследование</th><th>Статус</th></tr></thead><tbody><tr v-for="s in items" :key="s.id"><td class="whitespace-nowrap">{{date(s.date)}}<div class="cell-sub">№ {{s.id}}</div></td><td><RouterLink v-if="s.patientId" :to="'/patients/'+s.patientId" class="patient-name">{{s.patientName}}</RouterLink><span v-else class="text-slate-500">Без карточки пациента</span></td><td><RouterLink :to="'/studies/'+s.id" class="patient-name">{{s.title}}</RouterLink><div class="cell-sub">{{s.doctor}}</div></td><td><UBadge :color="s.origin==='legacy'?'neutral':s.status==='draft'?'warning':'primary'" variant="subtle">{{studyStatus(s.status)}}</UBadge></td></tr></tbody></table></div><EmptyState v-if="!items.length&&!loading" title="Исследования не найдены" description="Попробуйте другое имя или номер."/><TablePagination v-model:page="page" :page-size="pageSize" @update:page-size="changePageSize" :total="total" :loading="loading"/></div></section></template>
