import {defineStore} from 'pinia'
import {computed,ref} from 'vue'
import {command,message} from '../api'
export interface User{id:number;username:string;name:string;role:'admin'|'doctor'|'viewer';doctorId:number|null}
export const useAuth=defineStore('auth',()=>{
  const user=ref<User|null>(null),ready=ref(false),setupRequired=ref(false),hasOpened=ref(false),locked=ref(false),lastUsername=ref(''),error=ref('')
  const canWrite=computed(()=>Boolean(user.value&&user.value.role!=='viewer')),admin=computed(()=>user.value?.role==='admin')
  async function init(){error.value='';try{const state=await command<{user:User|null;setupRequired:boolean}>('auth_status');user.value=state.user;setupRequired.value=state.setupRequired;hasOpened.value=Boolean(state.user)}catch(e){error.value=message(e)}finally{ready.value=true}}
  async function login(username:string,password:string,name=''){const result=setupRequired.value?await command<User>('setup_admin',{input:{id:null,revision:null,username,password,name,role:'admin',doctorId:null,enabled:true}}):await command<User>('auth_login',{username,password});user.value=result;lastUsername.value=result.username;setupRequired.value=false;hasOpened.value=true;locked.value=false}
  async function lock(){if(locked.value)return;if(user.value)lastUsername.value=user.value.username;user.value=null;locked.value=true;try{await command('auth_logout')}catch{/* Session is already expired. */}}
  async function logout(){await command('auth_logout');user.value=null;hasOpened.value=false;locked.value=false}
  return {user,ready,setupRequired,hasOpened,locked,lastUsername,error,canWrite,admin,init,login,lock,logout}
})
