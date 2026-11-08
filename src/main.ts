import { createApp } from 'vue'
import { createPinia } from 'pinia'
import { createRouter, createWebHashHistory } from 'vue-router'
import ui from '@nuxt/ui/vue-plugin'
import App from './App.vue'
const PatientIndex=()=>import('./views/PatientIndex.vue')
const PatientDetail=()=>import('./views/PatientDetail.vue')
const StudyEditor=()=>import('./views/StudyEditor.vue')
const StudyIndex=()=>import('./views/StudyIndex.vue')
const DatabaseSettings=()=>import('./views/DatabaseSettings.vue')
import './style.css'

const router = createRouter({ history: createWebHashHistory(), routes: [
  { path: '/', component: PatientIndex },
  { path: '/patients/:id', component: PatientDetail },
  { path: '/studies', component: StudyIndex },
  { path: '/studies/new/:patientId', component: StudyEditor },
  { path: '/studies/:id', component: StudyEditor },
  { path: '/database', component: DatabaseSettings },
  { path: '/account', component: ()=>import('./views/AccountSettings.vue') },
  { path: '/templates', component: ()=>import('./views/TemplateIndex.vue') },
  { path: '/statistics', component: ()=>import('./views/Statistics.vue') },
  { path: '/users', component: ()=>import('./views/Users.vue') },
  { path: '/orphans', redirect: '/studies' },
  { path: '/bundles/:id', component: ()=>import('./views/BundleView.vue') }
] })
createApp(App).use(createPinia()).use(router).use(ui).mount('#app')
