<script setup lang="ts">
import {computed} from 'vue'
import {useDatabase} from '../stores/database'
import BackupManager from '../components/BackupManager.vue'
import ArchiveMaintenance from '../components/ArchiveMaintenance.vue'
import {useAuth} from '../stores/auth'
import PageHeading from '../components/PageHeading.vue'
import {number} from '../format'
const auth=useAuth(),db=useDatabase()
const migration=computed(()=>{try{return JSON.parse(db.info?.migration||'{}')}catch{return {}}})
</script>
<template><section class="page-content"><PageHeading title="База и резервные копии" description="Файл данных хранится на этом компьютере"/><div class="settings-section"><div class="settings-title"><UIcon name="i-lucide-database"/><h2>Текущая база</h2><UBadge color="primary" variant="subtle">Подключена</UBadge></div><dl class="settings-facts"><div><dt>Расположение</dt><dd class="break-all">{{db.info?.path}}</dd></div><div><dt>Пациенты</dt><dd>{{number(db.info?.patients||0)}}</dd></div><div><dt>Исследования</dt><dd>{{number(db.info?.studies||0)}}</dd></div><div><dt>Проверка переноса</dt><dd>{{migration.integrity_check==='ok'?'Целостность базы проверена':'Нет сведений о проверке'}}</dd></div></dl></div><BackupManager v-if="auth.admin"/><ArchiveMaintenance v-if="auth.admin"/></section></template>
