import { defineStore } from 'pinia'
import { ref } from 'vue'
import { command,message } from '../api'
import type { Patient,Page } from '../types'
export const usePatients=defineStore('patients',()=>{
  const sort=ref<'name'|'birthdate'|'lastStudy'>('lastStudy'),direction=ref<'asc'|'desc'>('desc')
  const query=ref(''),gender=ref('all'),page=ref(1),pageSize=ref(50),total=ref(0),items=ref<Patient[]>([]),loading=ref(false),error=ref('')
  let request=0
  async function load(){const token=++request; loading.value=true;error.value='';try{const result=await command<Page<Patient>>('list_patients',{query:query.value,gender:gender.value==='all'?'':gender.value,page:page.value-1,pageSize:pageSize.value,sort:sort.value,direction:direction.value});if(token===request){items.value=result.items;total.value=result.total}}catch(e){if(token===request)error.value=message(e)}finally{if(token===request)loading.value=false}}
  return {sort,direction,query,gender,page,pageSize,total,items,loading,error,load}
})
