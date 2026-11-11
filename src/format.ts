export function date(value:string|null|undefined) {
  if(!value || value.startsWith('0000')) return 'Не указана'
  const [y,m,d]=value.slice(0,10).split('-')
  return `${d}.${m}.${y}`
}
export function age(value:string) {
  if(!value || value.startsWith('0000'))return ''
  const birth=new Date(value.slice(0,10)+'T00:00:00'); const now=new Date()
  let years=now.getFullYear()-birth.getFullYear()
  if(now.getMonth()<birth.getMonth() || (now.getMonth()===birth.getMonth()&&now.getDate()<birth.getDate())) years--
  if(!Number.isFinite(years)||years<0)return ''
  const mod=years%100; const last=years%10
  return `${years} ${mod>=11&&mod<=14?'лет':last===1?'год':last>=2&&last<=4?'года':'лет'}`
}
export function initials(name:string){return name.split(/\s+/).slice(0,2).map(n=>n[0]).join('')}
export const number=(n:number)=>new Intl.NumberFormat('ru-RU').format(n)
export const localDate=()=>{const d=new Date(); return `${d.getFullYear()}-${String(d.getMonth()+1).padStart(2,'0')}-${String(d.getDate()).padStart(2,'0')}`}

export const isDeleted=(status:string)=>['deleted','legacy:2'].includes(status)
export const studyStatus=(status:string)=>status==='deleted'?'Удалено':status==='legacy:0'?'Черновик архива':status==='legacy:2'?'Удалено в архиве':status==='legacy:1'?'Архив':status==='draft'?'Черновик':'Завершено'

const pluralRules=new Intl.PluralRules('ru')
export const counted=(n:number,one:string,few:string,many:string)=>number(n)+' '+(pluralRules.select(n)==='one'?one:pluralRules.select(n)==='few'?few:many)
