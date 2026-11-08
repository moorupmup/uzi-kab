<script setup lang="ts">
import {computed,onMounted,ref} from 'vue'
import {command,message} from '../api'
import {useDatabase} from '../stores/database'
import {templatePath,type UserTemplate} from '../userTemplates'
const props=defineProps<{templateId?:number;pick?:boolean}>()
const emit=defineEmits<{select:[entry:UserTemplate]}>()
const db=useDatabase(),entries=ref<UserTemplate[]>([]),query=ref(''),selectedType=ref<number>(props.templateId||0),showHidden=ref(false),error=ref(''),loading=ref(true)
onMounted(async()=>{try{if(!db.info)await db.load();entries.value=await command<UserTemplate[]>('user_templates')}catch(e){error.value=message(e)}finally{loading.value=false}})
const items=computed(()=>[{label:'Все виды исследований',value:0},...(db.info?.templates||[]).map(t=>({label:t.name,value:t.id}))])
const rows=computed(()=>entries.value.filter(e=>!e.folder).map(entry=>({entry,path:templatePath(entry,entries.value)})).filter(({entry,path})=>(!selectedType.value||entry.templateId===selectedType.value||(!entry.templateId&&path.some(p=>p.templateId===selectedType.value)))&&(showHidden.value||![entry,...path].some(p=>p.hidden))&&[...path.map(p=>p.name),entry.name,entry.value].join(' ').toLocaleLowerCase('ru').includes(query.value.trim().toLocaleLowerCase('ru'))))
</script>
<template><div><UAlert v-if="error" color="error" :description="error" class="mb-5"/><div class="grid gap-4 md:grid-cols-2 mb-5"><UFormField label="Поиск по тексту и разделу"><UInput v-model="query" icon="i-lucide-search" placeholder="Найти заготовку…" class="w-full"/></UFormField><UFormField label="Вид исследования"><USelect v-model="selectedType" :items="items" class="w-full"/></UFormField></div><UCheckbox v-model="showHidden" label="Показать скрытые в старой программе" class="mb-5"/><p v-if="loading" role="status">Загружаем справочник…</p><template v-else><p class="mb-4 text-slate-600" role="status">Найдено заготовок: {{rows.length}}</p><p v-if="!rows.length">Заготовок не найдено. Измените поиск или вид исследования.</p><ul class="space-y-4"><li v-for="{entry,path} in rows" :key="entry.id" class="border border-slate-200 rounded-lg p-4"><p class="text-sm text-slate-500 mb-2">{{path.map(p=>p.name).join(' / ')}}<span v-if="entry.hidden"> · Скрытая запись</span></p><p class="preserve-lines">{{entry.value||entry.name}}</p><UButton v-if="pick" class="mt-3" variant="outline" icon="i-lucide-plus" @click="emit('select',entry)">Вставить</UButton></li></ul></template></div></template>
