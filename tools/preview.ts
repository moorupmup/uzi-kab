import type { Plugin } from 'vite'
import {archiveReader} from './archiveReader'
import {reportReader} from './reportReader'
import {templateReader} from './templateReader'
import {decisionReader} from './decisionReader'
import { DatabaseSync } from 'node:sqlite'
import { resolve } from 'node:path'
import catalogData from '../src/catalog.json'
import versionsData from '../src/legacy-versions.json'
import {reviseForm} from '../src/formRevisions'
import type {FieldDefinition} from '../src/types'

// Development only. No mutation endpoints; not included in the desktop application.
export function localArchivePreview():Plugin {
  return {name:'local-archive-preview',configureServer(server){
    server.middlewares.use('/__archive',async(req,res)=>{
      res.setHeader('Content-Type','application/json; charset=utf-8');res.setHeader('Cache-Control','no-store')
      if(req.method!=='POST'){res.statusCode=405;res.end('{}');return}
      let db:DatabaseSync|undefined
      try{
        if(req.headers.origin && req.headers.origin!==`http://${req.headers.host}`)throw new Error('Недопустимый источник запроса')
        let body='';for await(const chunk of req){body+=chunk;if(body.length>1_000_000)throw new Error('Запрос слишком большой')}
        const a=JSON.parse(body||'{}'),name=req.url?.split('?')[0].slice(1)
        db=new DatabaseSync(resolve('data/uzi.db'),{readOnly:true})
        const all=(sql:string,...params:(string|number)[])=>db!.prepare(sql).all(...params)
        const one=(sql:string,...params:(string|number)[])=>db!.prepare(sql).get(...params)
        const table=(name:string)=>Boolean(one("SELECT name FROM sqlite_master WHERE type='table' AND name=?",name))
        const form=(code:string,version:string,options:Record<string,unknown>={},revision=0)=>reviseForm({code,version,configurationRevision:revision,definitions:((catalogData as Record<string,FieldDefinition[]>)[code.toLowerCase()+'_'+version]||[]).map(d=>({...d,...(options[d.key]?{options:options[d.key] as FieldDefinition['options']}:{})}))})
        const pattern='%'+String(a.query||'').trim().toLowerCase().replaceAll('ё','е').replaceAll('\\','\\\\').replaceAll('%','\\%').replaceAll('_','\\_')+'%'
        const pageSize=Math.max(1,Math.min(500,Number(a.pageSize)||50))
        const offset=Math.max(0,Math.min(100000,Number(a.page)||0))*pageSize
        const patients=`SELECT p.id,p.name,p.gender,p.birthdate,p.city,p.street,p.house,p.flat,p.revision,(SELECT count(*) FROM studies s WHERE s.patient_id=p.id) AS studyCount,(SELECT max(s.date) FROM studies s WHERE s.patient_id=p.id) AS lastStudy FROM patients p`
        const studies=`SELECT s.id,s.patient_id AS patientId,s.date,s.title,s.origin,s.status,s.revision,s.template_id AS templateId,s.doctor_id AS doctorId,d.name AS doctor FROM studies s LEFT JOIN doctors d ON d.id=s.doctor_id`
        let result:unknown
        switch(name){
          case 'auth_status':result={setupRequired:false,user:{id:0,username:'preview',name:'Предпросмотр',role:'viewer',doctorId:null}};break
          case 'list_attachments':result=[];break
          case 'patient_bundles':result=archiveReader(db).bundles(Number(a.patientId));break
          case 'bundle_detail':result=archiveReader(db).bundle(Number(a.id));break
          case 'statistics_options':result=reportReader(db).options();break
          case 'statistics':result=reportReader(db).statistics(String(a.from||''),String(a.to||''),a.filters);break
          case 'statistics_details':result=reportReader(db).details(String(a.from||''),String(a.to||''),a.filters,Number(a.page)||0,pageSize);break
          case 'user_templates':result=templateReader(db);break
          case 'decision_options':result=decisionReader(db).options();break
          case 'database_info':result={path:resolve('data/uzi.db'),patients:one('SELECT count(*) AS n FROM patients WHERE hidden=0')!.n,studies:one('SELECT count(*) AS n FROM studies')!.n,templates:all("SELECT t.*,COALESCE((SELECT b.status_hidden FROM legacy_book b WHERE b.id=t.id),0) AS hidden FROM templates t ORDER BY name").map(t=>{const saved=table('template_config')?one('SELECT config_json FROM template_config WHERE template_id=?',Number(t.id)):null;const config=saved?JSON.parse(String(saved.config_json)):{...t,formCode:String(t.code).toLowerCase(),version:(versionsData as Record<string,string>)[String(t.code).toLowerCase()]||'1',revision:0,options:{}};return {...config,formSnapshot:form(config.formCode,config.version,config.options,config.revision)}}),doctors:all('SELECT id,name FROM doctors WHERE hidden=0 ORDER BY name'),migration:one("SELECT value FROM metadata WHERE key='migration'")!.value};break
          case 'list_patients':{const sort=String(a.sort??'lastStudy');const requestedDirection=a.direction??(sort==='lastStudy'?'desc':'asc');const direction=requestedDirection==='asc'?'ASC':requestedDirection==='desc'?'DESC':null;if(!direction)throw new Error('Неизвестное направление сортировки');const orders:Record<string,string>={name:`p.search_name ${direction},p.id ASC`,birthdate:`CASE WHEN p.birthdate IS NULL OR p.birthdate='' OR p.birthdate LIKE '0000%' THEN 1 ELSE 0 END ASC,p.birthdate ${direction},p.search_name ASC,p.id ASC`,lastStudy:`CASE WHEN lastStudy IS NULL OR lastStudy='' OR lastStudy LIKE '0000%' THEN 1 ELSE 0 END ASC,lastStudy ${direction},p.search_name ASC,p.id ASC`};const order=orders[sort];if(typeof order!=='string')throw new Error('Неизвестная колонка сортировки');const filter=` WHERE p.hidden=0 AND (COALESCE(p.search_name,'') LIKE ? ESCAPE '\\' OR CAST(p.id AS TEXT)=?) AND (?='' OR p.gender=?)`;const params=[pattern,String(a.query||'').trim(),String(a.gender||''),String(a.gender||'')];result={total:one('SELECT count(*) AS n FROM patients p'+filter,...params)!.n,items:all(patients+filter+` ORDER BY ${order} LIMIT ? OFFSET ?`,...params,pageSize,offset)};break}
          case 'patient_detail':{const patient=one(patients+' WHERE p.id=? AND p.hidden=0',Number(a.id));if(!patient)throw new Error('Пациент не найден');result={patient,studies:all(studies+' WHERE s.patient_id=? ORDER BY s.date DESC,s.id DESC',Number(a.id))};break}
          case 'study_detail':result=archiveReader(db).study(Number(a.id));break
          case 'list_studies':{const states:Record<string,string>={active:"s.status NOT IN('deleted','legacy:2')",all:'1=1',draft:"s.status IN('draft','legacy:0')",final:"s.status IN('final','legacy:1')",deleted:"s.status IN('deleted','legacy:2')"};const state=states[String(a.status||'active')];if(!state)throw new Error('Неизвестный фильтр состояния');const filter=` LEFT JOIN patients p ON p.id=s.patient_id WHERE (p.hidden=0 OR p.id IS NULL) AND (COALESCE(p.search_name,'') LIKE ? ESCAPE '\\' OR CAST(s.id AS TEXT)=?) AND (${state})`;result={total:one('SELECT count(*) AS n FROM studies s'+filter,pattern,String(a.query||'').trim())!.n,items:all(`SELECT s.id,s.patient_id AS patientId,p.name AS patientName,s.date,s.title,s.origin,s.status,s.revision,s.template_id AS templateId,s.doctor_id AS doctorId,d.name AS doctor FROM studies s LEFT JOIN doctors d ON d.id=s.doctor_id`+filter+' ORDER BY s.date DESC,s.id DESC LIMIT ? OFFSET ?',pattern,String(a.query||'').trim(),pageSize,offset)};break}
          default:throw new Error('Предпросмотр доступен только для чтения. Для сохранения запустите настольное приложение.')
        }
        res.end(JSON.stringify(result))
      }catch(error){res.statusCode=400;res.end(JSON.stringify({error:error instanceof Error?error.message:'Ошибка чтения базы'}))}finally{db?.close()}
    })
  }}
}

