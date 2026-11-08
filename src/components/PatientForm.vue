<script setup lang="ts">
import {useAuth} from '../stores/auth'
const auth=useAuth()
import { reactive,ref,watch } from 'vue'
import type { Patient } from '../types'
import { command,message,desktop } from '../api'
const props=defineProps<{patient?:Patient;open:boolean}>(),emit=defineEmits<{ 'update:open':[boolean]; saved:[number] }>()
const form=reactive({name:'',gender:'F',birthdate:'',city:'',street:'',house:'',flat:''}),busy=ref(false),error=ref('')
watch(()=>props.open,()=>{Object.assign(form,{name:'',gender:'F',birthdate:'',city:'',street:'',house:'',flat:''},props.patient||{});if(form.birthdate.startsWith('0000'))form.birthdate='';error.value=''})
async function save(){busy.value=true;error.value='';try{const id=await command<number>('save_patient',{input:{...form,id:props.patient?.id??null,revision:props.patient?.revision??null}});emit('saved',id);emit('update:open',false)}catch(e){error.value=message(e)}finally{busy.value=false}}
</script>
<template><UModal :open="open" @update:open="emit('update:open',$event)" :title="patient?'Редактировать карточку':'Новый пациент'" description="Основные сведения для карточки пациента" :dismissible="!busy" :ui="{content:'max-w-[640px]',header:'px-7 py-6',body:'p-7 sm:p-7',footer:'px-7 py-5'}">
<template #body><form id="patient-form" @submit.prevent="save" class="space-y-6"><UAlert v-if="error" color="error" :description="error"/><UFormField label="Фамилия, имя, отчество" required><UInput v-model="form.name" autofocus maxlength="255" class="w-full" required placeholder="Введите ФИО полностью"/></UFormField><div class="grid grid-cols-1 sm:grid-cols-2 gap-6"><UFormField label="Дата рождения" description="Если дата неизвестна, оставьте пустой"><UInput v-model="form.birthdate" type="date" class="w-full"/></UFormField><UFormField label="Пол"><USelect v-model="form.gender" :items="[{label:'Женский',value:'F'},{label:'Мужской',value:'M'}]" class="w-full"/></UFormField></div><UFormField label="Город"><UInput v-model="form.city" class="w-full"/></UFormField><UFormField label="Улица"><UInput v-model="form.street" class="w-full"/></UFormField><div class="grid grid-cols-1 sm:grid-cols-2 gap-6"><UFormField label="Дом"><UInput v-model="form.house" class="w-full"/></UFormField><UFormField label="Квартира"><UInput v-model="form.flat" class="w-full"/></UFormField></div></form></template>
<template #footer><div class="flex w-full justify-end gap-2"><UButton color="neutral" variant="ghost" @click="emit('update:open',false)" :disabled="busy">Отмена</UButton><UButton type="submit" form="patient-form" :loading="busy" :disabled="!desktop||!auth.canWrite">Сохранить карточку</UButton></div></template>
</UModal></template>
