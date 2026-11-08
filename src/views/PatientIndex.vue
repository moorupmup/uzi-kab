<script setup lang="ts">
import {useAuth} from '../stores/auth'
const auth=useAuth()
import { onMounted,onBeforeUnmount,ref,watch } from 'vue'
import { useRouter } from 'vue-router'
import { usePatients } from '../stores/patients'
import { useDatabase } from '../stores/database'
import { date,age,initials,number } from '../format'
import { desktop } from '../api'
import PageHeading from '../components/PageHeading.vue'
import EmptyState from '../components/EmptyState.vue'
import PatientForm from '../components/PatientForm.vue'
import TablePagination from '../components/TablePagination.vue'
const store=usePatients(),db=useDatabase(),router=useRouter(),create=ref(false)
let timer:ReturnType<typeof setTimeout>
watch([()=>store.query,()=>store.gender],()=>{clearTimeout(timer);timer=setTimeout(()=>{store.page=1;store.load()},250)})
watch([()=>store.page,()=>store.pageSize,()=>store.sort,()=>store.direction],store.load)
type SortColumn='name'|'birthdate'|'lastStudy'
const sortColumns:{key:SortColumn;label:string}[]=[{key:'name',label:'Пациент'},{key:'birthdate',label:'Дата рождения'},{key:'lastStudy',label:'Последнее исследование'}]
function changeSort(key:SortColumn){store.direction=store.sort===key?(store.direction==='asc'?'desc':'asc'):(key==='lastStudy'?'desc':'asc');store.sort=key;store.page=1}
function sortState(key:SortColumn){return store.sort===key?(store.direction==='asc'?'ascending':'descending'):'none'}
function sortLabel(key:SortColumn,label:string){const next=store.sort===key?(store.direction==='asc'?'desc':'asc'):(key==='lastStudy'?'desc':'asc');return `${label}: сортировать по ${next==='asc'?'возрастанию':'убыванию'}`}
function changePageSize(size:number){store.page=1;store.pageSize=size}
onMounted(store.load);onBeforeUnmount(()=>clearTimeout(timer))
async function saved(id:number){await db.load();store.load();router.push('/patients/'+id)}
</script>
<template><section class="page-content">
<PageHeading title="Пациенты" description="Карточки пациентов и вся история исследований"><UButton icon="i-lucide-plus" size="lg" :disabled="!desktop||!auth.canWrite" @click="create=true">Новый пациент</UButton></PageHeading>
<div class="index-toolbar"><UInput v-model="store.query" icon="i-lucide-search" placeholder="Найти по ФИО или номеру карточки" aria-label="Поиск пациентов" size="lg" class="search-input" :trailing-icon="store.loading?'i-lucide-loader-circle':undefined"/><USelect v-model="store.gender" aria-label="Пол пациента" :items="[{label:'Любой пол',value:'all'},{label:'Женский',value:'F'},{label:'Мужской',value:'M'}]" size="lg" class="w-40"/><UButton v-if="store.query||store.gender!=='all'" variant="ghost" color="neutral" @click="store.query='';store.gender='all'">Сбросить</UButton></div>
<div class="result-caption"><span>{{store.query||store.gender!=='all'?'Найдено':'Всего'}} <strong>{{number(store.total)}}</strong> пациентов</span><span>Выберите пациента, чтобы открыть историю</span></div>
<UAlert v-if="store.error" color="error" :description="store.error" class="mb-4"/><div v-if="store.error" class="mb-4"><UButton @click="store.load">Повторить</UButton></div>
<div class="table-panel" :aria-busy="store.loading"><div class="table-scroll"><table class="patient-table"><thead><tr><th v-for="column in sortColumns" :key="column.key" scope="col" class="sortable-column" :aria-sort="sortState(column.key)"><button type="button" class="table-sort" :class="{'is-active':store.sort===column.key}" :disabled="store.loading" :aria-label="sortLabel(column.key,column.label)" @click="changeSort(column.key)">{{column.label}}<UIcon :name="store.sort===column.key?(store.direction==='asc'?'i-lucide-arrow-up':'i-lucide-arrow-down'):'i-lucide-arrow-up-down'" aria-hidden="true"/></button></th><th scope="col" class="text-right">Исследований</th><th scope="col"><span class="sr-only">Открыть карточку</span></th></tr></thead><tbody><tr v-for="patient in store.items" :key="patient.id" @click="router.push('/patients/'+patient.id)"><td><div class="flex items-center gap-3"><span class="patient-avatar" :class="patient.gender==='F'?'avatar-rose':'avatar-blue'">{{initials(patient.name)}}</span><div><RouterLink :to="'/patients/'+patient.id" class="patient-name">{{patient.name}}</RouterLink><div class="cell-sub">№ {{patient.id}} <span class="mx-1">·</span> {{patient.gender==='F'?'Женский':'Мужской'}}</div></div></div></td><td><span class="tabular-nums">{{date(patient.birthdate)}}</span><div class="cell-sub">{{age(patient.birthdate)}}</div></td><td><span class="tabular-nums">{{patient.lastStudy?date(patient.lastStudy):'Нет исследований'}}</span></td><td class="text-right"><span class="count-badge">{{patient.studyCount}}</span></td><td><UIcon name="i-lucide-chevron-right" class="text-slate-400"/></td></tr></tbody></table></div>
<EmptyState v-if="!store.items.length&&!store.loading&&!store.error" title="Пациенты не найдены" description="Проверьте ФИО или попробуйте убрать фильтр."/>
<TablePagination v-model:page="store.page" :page-size="store.pageSize" @update:page-size="changePageSize" :total="store.total" :loading="store.loading"/></div>
<PatientForm v-model:open="create" @saved="saved"/>
</section></template>
