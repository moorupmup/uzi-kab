import type { Plugin } from 'vite'
import { DatabaseSync } from 'node:sqlite'
import { resolve } from 'node:path'

// Development only. No mutation endpoints; not included in the desktop application.
export function localArchivePreview():Plugin {
  return {name:'local-archive-preview',configureServer(server){
    server.middlewares.use('/__archive',async(req,res)=>{
      res.setHeader('Content-Type','application/json; charset=utf-8');res.setHeader('Cache-Control','no-store')
      if(req.method!=='POST'){res.statusCode=405;res.end('{}');return}
      let db:DatabaseSync|undefined
      try{
        if(req.headers.origin && req.headers.origin!==`http://${req.headers.host}`)throw new Error('Недопустимый источник запроса')
        let body='';for await(const chunk of req){body+=chunk;if(body.length>10000)throw new Error('Запрос слишком большой')}
        const a=JSON.parse(body||'{}'),name=req.url?.split('?')[0].slice(1)
        db=new DatabaseSync(resolve('data/uzi.db'),{readOnly:true})
        const all=(sql:string,...params:(string|number)[])=>db!.prepare(sql).all(...params)
        const one=(sql:string,...params:(string|number)[])=>db!.prepare(sql).get(...params)
        const pattern='%'+String(a.query||'').trim().toLowerCase().replaceAll('ё','е').replaceAll('\\','\\\\').replaceAll('%','\\%').replaceAll('_','\\_')+'%'
        const pageSize=Math.max(1,Math.min(500,Number(a.pageSize)||50))
        const offset=Math.max(0,Math.min(100000,Number(a.page)||0))*pageSize
        const patients=`SELECT p.id,p.name,p.gender,p.birthdate,p.city,p.street,p.house,p.flat,p.revision,(SELECT count(*) FROM studies s WHERE s.patient_id=p.id) AS studyCount,(SELECT max(s.date) FROM studies s WHERE s.patient_id=p.id) AS lastStudy FROM patients p`
        const studies=`SELECT s.id,s.patient_id AS patientId,s.date,s.title,s.origin,s.status,s.revision,s.template_id AS templateId,s.doctor_id AS doctorId,d.name AS doctor FROM studies s LEFT JOIN doctors d ON d.id=s.doctor_id`
        let result:unknown
        switch(name){
          case 'auth_status':result={setupRequired:false,user:{id:0,username:'preview',name:'Предпросмотр',role:'viewer',doctorId:null}};break
          case 'list_attachments':case 'patient_bundles':result=[];break
          case 'statistics':{
            const from=String(a.from||''),to=String(a.to||'');if(!/^\d{4}-\d{2}-\d{2}$/.test(from)||!/^\d{4}-\d{2}-\d{2}$/.test(to)||from>to)throw new Error('Проверьте период отчёта')
            const filter="WHERE substr(s.date,1,10)>=? AND substr(s.date,1,10)<=? AND s.status IN('final','legacy:1') AND s.patient_id<>0"
            result={summary:one(`SELECT count(*) AS studies,count(distinct patient_id) AS patients FROM studies s ${filter}`,from,to),byType:all(`SELECT s.title AS name,count(*) AS count FROM studies s ${filter} GROUP BY s.template_id,s.title ORDER BY count DESC`,from,to),byDoctor:all(`SELECT COALESCE(d.name,'Не указан') AS name,count(*) AS count FROM studies s LEFT JOIN doctors d ON d.id=s.doctor_id ${filter} GROUP BY s.doctor_id ORDER BY count DESC`,from,to),byMonth:all(`SELECT substr(s.date,1,7) AS name,count(*) AS count FROM studies s ${filter} GROUP BY substr(s.date,1,7) ORDER BY name`,from,to)};break
          }
          case 'user_templates':{
            const decode=(v:unknown)=>v instanceof Uint8Array?new TextDecoder('windows-1251').decode(v):String(v??'')
            result=one("SELECT name FROM sqlite_master WHERE type='table' AND name='legacy_book_users'")?all('SELECT * FROM legacy_book_users ORDER BY position,id').map(r=>({id:r.id,templateId:r.research_id,name:decode(r.name),key:decode(r.key_name),parentId:r.level_id,hidden:Boolean(r.status_hidden),folder:Boolean(r.status_root),value:decode(r.value)})):[];break
          }
          case 'database_info':result={path:resolve('data/uzi.db'),patients:one('SELECT count(*) AS n FROM patients WHERE hidden=0')!.n,studies:one('SELECT count(*) AS n FROM studies')!.n,templates:all('SELECT * FROM templates ORDER BY name'),doctors:all('SELECT id,name FROM doctors WHERE hidden=0 ORDER BY name'),migration:one("SELECT value FROM metadata WHERE key='migration'")!.value};break
          case 'list_patients':{const sort=String(a.sort??'lastStudy');const requestedDirection=a.direction??(sort==='lastStudy'?'desc':'asc');const direction=requestedDirection==='asc'?'ASC':requestedDirection==='desc'?'DESC':null;if(!direction)throw new Error('Неизвестное направление сортировки');const orders:Record<string,string>={name:`p.search_name ${direction},p.id ASC`,birthdate:`CASE WHEN p.birthdate IS NULL OR p.birthdate='' OR p.birthdate LIKE '0000%' THEN 1 ELSE 0 END ASC,p.birthdate ${direction},p.search_name ASC,p.id ASC`,lastStudy:`CASE WHEN lastStudy IS NULL OR lastStudy='' OR lastStudy LIKE '0000%' THEN 1 ELSE 0 END ASC,lastStudy ${direction},p.search_name ASC,p.id ASC`};const order=orders[sort];if(typeof order!=='string')throw new Error('Неизвестная колонка сортировки');const filter=` WHERE p.hidden=0 AND (COALESCE(p.search_name,'') LIKE ? ESCAPE '\\' OR CAST(p.id AS TEXT)=?) AND (?='' OR p.gender=?)`;const params=[pattern,String(a.query||'').trim(),String(a.gender||''),String(a.gender||'')];result={total:one('SELECT count(*) AS n FROM patients p'+filter,...params)!.n,items:all(patients+filter+` ORDER BY ${order} LIMIT ? OFFSET ?`,...params,pageSize,offset)};break}
          case 'patient_detail':{const patient=one(patients+' WHERE p.id=? AND p.hidden=0',Number(a.id));if(!patient)throw new Error('Пациент не найден');result={patient,studies:all(studies+' WHERE s.patient_id=? ORDER BY s.date DESC,s.id DESC',Number(a.id))};break}
          case 'study_detail':{const s=one('SELECT s.*,d.name AS doctor,p.name AS patientName,p.birthdate AS patientBirthdate,t.code AS templateCode FROM studies s LEFT JOIN patients p ON p.id=s.patient_id LEFT JOIN doctors d ON d.id=s.doctor_id LEFT JOIN templates t ON t.id=s.template_id WHERE s.id=?',Number(a.id));if(!s)throw new Error('Исследование не найдено');s.fields=JSON.parse(String(s.fields_json));delete s.fields_json;result=s;break}
          case 'list_studies':{const filter=` LEFT JOIN patients p ON p.id=s.patient_id WHERE (p.hidden=0 OR p.id IS NULL) AND (COALESCE(p.search_name,'') LIKE ? ESCAPE '\\' OR CAST(s.id AS TEXT)=?)`;result={total:one('SELECT count(*) AS n FROM studies s'+filter,pattern,String(a.query||'').trim())!.n,items:all(`SELECT s.id,s.patient_id AS patientId,p.name AS patientName,s.date,s.title,s.origin,s.status,s.revision,s.template_id AS templateId,s.doctor_id AS doctorId,d.name AS doctor FROM studies s LEFT JOIN doctors d ON d.id=s.doctor_id`+filter+' ORDER BY s.date DESC,s.id DESC LIMIT ? OFFSET ?',pattern,String(a.query||'').trim(),pageSize,offset)};break}
          default:throw new Error('Предпросмотр доступен только для чтения. Для сохранения запустите настольное приложение.')
        }
        res.end(JSON.stringify(result))
      }catch(error){res.statusCode=400;res.end(JSON.stringify({error:error instanceof Error?error.message:'Ошибка чтения базы'}))}finally{db?.close()}
    })
  }}
}

