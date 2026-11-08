import { chromium } from '@playwright/test'
import fs from 'node:fs/promises'
const browser=await chromium.launch({headless:true,channel:'msedge'})
const page=await browser.newPage({viewport:{width:1440,height:1000},deviceScaleFactor:1})
page.setDefaultTimeout(15000)
page.on('pageerror',e=>console.log('UI:',e.message))
const patient={id:1001,name:'Иванова Анна Сергеевна',gender:'F',birthdate:'1985-04-12',city:'Учебный город',street:'Примерная',house:'10',flat:'5',revision:1,studyCount:2,lastStudy:'2026-11-06'}
const doctor={id:1,name:'Петрова Е. А.'}
const template={id:1,name:'УЗИ щитовидной железы',code:'shit'}
const study={id:2001,patient_id:1001,patientId:1001,patientName:patient.name,patientBirthdate:patient.birthdate,date:'2026-11-06',template_id:1,templateId:1,doctor_id:1,doctorId:1,doctor:doctor.name,title:template.name,origin:'native',status:'final',revision:1,legacy_version:'1',templateCode:'shit',fields:{description:{value:'Учебный пример. Здесь врач описывает результаты исследования.',type:'text'}},conclusion:'Учебный пример заключения. Не является медицинским документом.',addition:''}
let signed=false
await page.route('**/src/api.ts',async route=>{const r=await route.fetch();let s=await r.text();s=s.replace('export const desktop = isTauri();','export const desktop = true;').replace('if (desktop)', 'if (isTauri())');await route.fulfill({response:r,body:s})})
await page.route('**/__archive/*',async route=>{const name=new URL(route.request().url()).pathname.split('/').pop();const data={auth_status:{user:signed?{id:1,name:doctor.name,username:'doctor',role:'admin',doctorId:1}:null,setupRequired:false},database_info:{path:'C:\\Кабинет УЗИ\\uzi.db',patients:2,studies:2,templates:[template],doctors:[doctor],migration:'{"integrity_check":"ok"}'},list_patients:{total:2,items:[patient,{...patient,id:1002,name:'Смирнов Алексей Николаевич',gender:'M',birthdate:'1974-09-20',studyCount:0,lastStudy:null}]},patient_detail:{patient,studies:[study,{...study,id:2000,date:'2026-10-20',status:'draft'}]},study_detail:study,patient_bundles:[],list_attachments:[],list_backups:[{name:'manual-2026-11-06.db',bytes:5242880,modified:'2026-11-06'}],statistics:{summary:{studies:12,patients:10},byType:[{name:template.name,count:12}],byDoctor:[{name:doctor.name,count:12}],byMonth:[{name:'2026-11',count:12}]}}[name];if(data===undefined)throw Error('Unexpected command '+name);await route.fulfill({json:data})})
await fs.mkdir('docs/manual-images',{recursive:true})
async function shot(name){await page.locator('h1').waitFor();await page.waitForTimeout(800);await page.screenshot({path:`docs/manual-images/${name}.png`,fullPage:true})}
await page.goto('http://127.0.0.1:1421');await shot('01-login');signed=true;await page.reload();await page.getByText(patient.name,{exact:true}).waitFor();await shot('02-patients')
await page.getByRole('button',{name:'Новый пациент',exact:true}).click();await page.getByRole('dialog').waitFor();await shot('03-patient-form');await page.getByRole('button',{name:'Отмена',exact:true}).click()
await page.goto('http://127.0.0.1:1421/#/patients/1001');await page.getByRole('heading',{name:patient.name,exact:true}).waitFor();await shot('04-card')
await page.goto('http://127.0.0.1:1421/#/studies/2001');await page.getByRole('heading',{name:'Редактирование исследования',exact:true}).waitFor();await shot('05-editor')
await page.goto('http://127.0.0.1:1421/#/statistics');await shot('06-statistics')
await page.goto('http://127.0.0.1:1421/#/database');await shot('07-backups')
await browser.close();console.log('Saved 7 screenshots using fictional data; live database not accessed.')



