import { invoke, isTauri } from '@tauri-apps/api/core'
export const desktop = isTauri()
export async function command<T>(name:string,args:Record<string,unknown>={}):Promise<T> {
  if (desktop) {try{return await invoke<T>(name,args)}catch(e){const detail=message(e);if(detail.startsWith('AUTH_REQUIRED:'))window.dispatchEvent(new Event('uzi-auth-required'));throw new Error(detail.replace('AUTH_REQUIRED: ',''))}}
  const response=await fetch('/__archive/'+name,{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify(args)})
  const result=await response.json()
  if(!response.ok) throw new Error(result.error || 'Не удалось прочитать базу')
  return result
}
export const message=(e:unknown)=>e instanceof Error?e.message:String(e)
