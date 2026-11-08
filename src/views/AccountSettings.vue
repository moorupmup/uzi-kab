<script setup lang="ts">
import {ref} from 'vue'
import {useAuth} from '../stores/auth'
import {command,message} from '../api'
import PageHeading from '../components/PageHeading.vue'
const auth=useAuth(),oldPassword=ref(''),password=ref(''),confirmation=ref(''),busy=ref(false),error=ref('')
async function save(){busy.value=true;error.value='';try{if(password.value!==confirmation.value)throw Error('Пароли не совпадают');await command('change_password',{oldPassword:oldPassword.value,newPassword:password.value});await auth.lock()}catch(e){error.value=message(e)}finally{busy.value=false}}
</script>
<template><section class="page-content"><PageHeading title="Моя учётная запись" :description="auth.user?.name"/><form @submit.prevent="save" class="settings-section space-y-6"><h2>Изменить пароль</h2><UAlert v-if="error" color="error" variant="soft" :description="error"/><UFormField label="Текущий пароль"><UInput v-model="oldPassword" type="password" required autocomplete="current-password" class="w-full"/></UFormField><UFormField label="Новый пароль" description="Не менее 10 символов"><UInput v-model="password" type="password" required minlength="10" autocomplete="new-password" class="w-full"/></UFormField><UFormField label="Повторите новый пароль"><UInput v-model="confirmation" type="password" required autocomplete="new-password" class="w-full"/></UFormField><UButton type="submit" :loading="busy">Сохранить пароль и войти заново</UButton></form></section></template>
