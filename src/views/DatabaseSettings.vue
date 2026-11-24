<script setup lang="ts">
import {computed,ref} from 'vue'
import {useDatabase} from '../stores/database'
import BackupManager from '../components/BackupManager.vue'
import ArchiveMaintenance from '../components/ArchiveMaintenance.vue'
import CatalogSettings from '../components/CatalogSettings.vue'
import {useAuth} from '../stores/auth'
import PageHeading from '../components/PageHeading.vue'
import {number} from '../format'
const auth=useAuth(),db=useDatabase(),catalogOpen=ref(false)
const migration=computed(()=>{try{return JSON.parse(db.info?.migration||'{}')}catch{return {}}})
</script>
<template><section class="page-content"><PageHeading title="Настройки" description="Виды исследований, база данных и резервные копии"/><div class="settings-section"><div class="settings-title"><UIcon name="i-lucide-database"/><h2>Текущая база</h2><UBadge color="primary" variant="subtle">Подключена</UBadge></div><dl class="settings-facts"><div><dt>Расположение</dt><dd class="break-all">{{db.info?.path}}</dd></div><div><dt>Пациенты</dt><dd>{{number(db.info?.patients||0)}}</dd></div><div><dt>Исследования</dt><dd>{{number(db.info?.studies||0)}}</dd></div><div><dt>Проверка переноса</dt><dd>{{migration.integrity_check==='ok'?'Целостность базы проверена':'Нет сведений о проверке'}}</dd></div></dl></div><section v-if="auth.admin" class="settings-section"><div class="settings-title"><UIcon name="i-lucide-settings-2"/><h2>Виды исследований</h2></div><UButton variant="outline" color="neutral" icon="i-lucide-settings-2" @click="catalogOpen=true">Настройки видов</UButton><CatalogSettings v-if="catalogOpen" v-model:open="catalogOpen"/></section><BackupManager v-if="auth.admin"/><ArchiveMaintenance v-if="auth.admin"/></section></template>
