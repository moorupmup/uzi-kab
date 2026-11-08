import { defineStore } from 'pinia'
import { ref } from 'vue'
import { command,message } from '../api'
import type { DatabaseInfo } from '../types'
export const useDatabase=defineStore('database',()=>{
  const info=ref<DatabaseInfo|null>(null),error=ref(''),loading=ref(false)
  async function load(){loading.value=true;error.value='';try{info.value=await command<DatabaseInfo>('database_info')}catch(e){error.value=message(e)}finally{loading.value=false}}
  return {info,error,loading,load}
})
