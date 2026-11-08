import type {FieldValue} from './types'
export const calculationDependencies:Record<string,string[]>={shit:['r_dolya_1','r_dolya_2','r_dolya_3','l_dolya_1','l_dolya_2','l_dolya_3'],eho_kg:['kdr','ksr','mjld_tol','zslj_tol'],ginekol:['r_dlina','r_tolsh','r_shir','l_dlina','l_tolsh','l_shir','matka_dl','matka_tol','matka_sh'],brooho:['jelch_dl','jelch_tol','jelch_sh','sel_dl','sel_tol','sel_sh']}
export const calculatedKeys:Record<string,string[]>={shit:['v1','v2','sum'],eho_kg:['kdo','kso','fv','ydar_v','fy','massa'],ginekol:['r_obem','l_obem','matka_ob'],brooho:['jelch_ob','sel_obem']}
export function invalidateCalculations(code:string,fields:Record<string,FieldValue>){
  for(const key of calculatedKeys[code.toLowerCase()]||[])delete fields[key]
  if(calculationDependencies[code.toLowerCase()]?.some(key=>fields[key]?.value.trim()))fields._calculation_pending={type:'meta',value:'1'}
  else delete fields._calculation_pending
}
// Ported literally from legacy/forms/shit_1.jsp and eho_kg_1/2.jsp.
// No diagnostic interpretation or reference ranges are introduced.
export function calculateLegacy(code:string,fields:Record<string,FieldValue>):Record<string,FieldValue> {
  const result:Record<string,FieldValue>={}
  const read=(key:string)=>{const raw=fields[key]?.value?.trim().replace(',','.');if(!raw||!/^\d+(?:\.\d+)?$/.test(raw))throw new Error('Заполните числовые размеры для расчёта: '+key);const value=Number(raw);if(!Number.isFinite(value)||value<=0)throw new Error('Размер должен быть положительным: '+key);return value}
  const put=(key:string,value:number)=>{if(!Number.isFinite(value))throw new Error('Не удалось рассчитать '+key);result[key]={type:'string',value:String(value)}}
  if(code.toLowerCase()==='shit'){
    const volume=(prefix:string)=>Math.round(0.479*read(prefix+'_1')*read(prefix+'_2')*read(prefix+'_3')/1000*100)/100
    if(['r_dolya_1','r_dolya_2','r_dolya_3'].some(k=>fields[k]?.value.trim()))put('v1',volume('r_dolya'))
    if(['l_dolya_1','l_dolya_2','l_dolya_3'].some(k=>fields[k]?.value.trim()))put('v2',volume('l_dolya'))
    if(result.v1&&result.v2)put('sum',Math.round((Number(result.v1.value)+Number(result.v2.value))*100)/100)
  }else if(code.toLowerCase()==='eho_kg'){
    const kdr=fields.kdr?.value.trim()?read('kdr'):undefined,ksr=fields.ksr?.value.trim()?read('ksr'):undefined
    if(kdr!==undefined){const kdo=Math.round(7/(2.4+kdr)*kdr*kdr*kdr);if(kdo<=0)throw new Error('КДО округляется до нуля. Проверьте единицы измерения.');put('kdo',kdo)}
    if(ksr!==undefined)put('kso',Math.round(7/(2.4+ksr)*ksr*ksr*ksr))
    if(kdr!==undefined&&ksr!==undefined){
      const kdo=Number(result.kdo.value),kso=Number(result.kso.value)
      put('fv',Math.round((kdo-kso)/kdo*100));put('ydar_v',Math.round(kdo-kso));put('fy',Math.round((kdr-ksr)/kdr*100))
    }
    if(fields.mjld_tol?.value.trim()||fields.zslj_tol?.value.trim()){
      const size=read('kdr'),septum=read('mjld_tol'),wall=read('zslj_tol'),sum=size+wall+septum
      put('massa',Math.round(1.04*(sum*sum*sum-size*size*size)-1.36))
    }
  }else if(['ginekol','brooho'].includes(code.toLowerCase())){
    const groups=code.toLowerCase()==='ginekol'?[['r_obem','r_dlina','r_tolsh','r_shir'],['l_obem','l_dlina','l_tolsh','l_shir'],['matka_ob','matka_dl','matka_tol','matka_sh']]:[['jelch_ob','jelch_dl','jelch_tol','jelch_sh'],['sel_obem','sel_dl','sel_tol','sel_sh']]
    for(const [output,a,b,c] of groups){
      if(![a,b,c].some(k=>fields[k]?.value.trim()))continue
      const x=read(a),y=read(b),z=read(c)
      put(output,output==='matka_ob'?Math.round((x+y+z)*(x+y+z)*(x+y+z)/60.79)/1000:Math.round(0.523*x*y*z/1000*100)/100)
    }
  }else throw new Error('В исходной программе для этой формы нет перенесённых числовых расчётов.')
  if(!Object.keys(result).length)throw new Error('Заполните размеры для расчёта.')
  return result
}
