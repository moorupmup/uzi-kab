<script setup lang="ts">
import { onMounted,onBeforeUnmount,computed,watch } from 'vue'
import { useRoute,useRouter,isNavigationFailure } from 'vue-router'
import { useDatabase } from './stores/database'
import { desktop } from './api'
import {useAuth} from './stores/auth'
import LoginScreen from './components/LoginScreen.vue'
import AppUpdate from './components/AppUpdate.vue'
const db=useDatabase(),route=useRoute(),router=useRouter(),auth=useAuth()
let idle:ReturnType<typeof setTimeout>
function activity(){clearTimeout(idle);if(auth.user&&desktop)idle=setTimeout(()=>auth.lock(),30*60*1000)}
function required(){void auth.lock()}
watch(()=>auth.user,user=>{if(user){db.load();activity()}})
onMounted(()=>{auth.init();window.addEventListener('uzi-auth-required',required);window.addEventListener('pointerdown',activity);window.addEventListener('keydown',activity)})
onBeforeUnmount(()=>{clearTimeout(idle);window.removeEventListener('uzi-auth-required',required);window.removeEventListener('pointerdown',activity);window.removeEventListener('keydown',activity)})
async function logout(){const result=await router.push('/');if(isNavigationFailure(result))return;await auth.logout();window.location.reload()}
const navigation=computed(()=>[{to:'/',label:'Пациенты',icon:'i-lucide-users-round'},{to:'/studies',label:'Исследования',icon:'i-lucide-files'},{to:'/templates',label:'Справочник шаблонов',icon:'i-lucide-book-open'},{to:'/statistics',label:'Статистика',icon:'i-lucide-chart-no-axes-combined'},...(auth.admin?[{to:'/database',label:'База и копии',icon:'i-lucide-database'},{to:'/users',label:'Пользователи',icon:'i-lucide-user-round-cog'}]:[])])
</script>
<template>
  <UApp>
    <LoginScreen v-if="!auth.ready||!auth.user"/><div v-if="auth.hasOpened" v-show="Boolean(auth.user)" class="app-shell">
      <aside class="sidebar no-print">
        <RouterLink to="/" class="brand"><span class="brand-mark"><UIcon name="i-lucide-activity" /></span><span>Кабинет УЗИ<small>Пациенты и исследования</small></span></RouterLink>
        <nav aria-label="Главное меню">
          <RouterLink v-for="item in navigation" :key="item.to" :to="item.to" class="nav-item" :class="{active:item.to==='/'?route.path==='/'||route.path.startsWith('/patients'):route.path.startsWith(item.to)}"><UIcon :name="item.icon"/><span>{{item.label}}</span><span v-if="item.to==='/'&&db.info" class="nav-count">{{db.info.patients.toLocaleString('ru-RU')}}</span></RouterLink>
        </nav>
        <div class="sidebar-bottom">
          <div class="sidebar-account-actions">
            <RouterLink to="/account" class="account-link sidebar-account-action"><UIcon name="i-lucide-circle-user-round"/><span>{{auth.user?.name}}</span></RouterLink>
            <UButton v-if="desktop" variant="ghost" color="neutral" icon="i-lucide-log-out" class="sidebar-account-action" @click="logout">Выйти</UButton>
          </div>
          <AppUpdate />
        </div>
      </aside>
      <main class="workspace">
        <div v-if="db.error" class="p-6"><UAlert color="error" title="Не удалось открыть базу" :description="db.error"/><UButton class="mt-4" @click="db.load">Повторить</UButton></div>
        <RouterView v-else />
      </main>
    </div>
  </UApp>
</template>
