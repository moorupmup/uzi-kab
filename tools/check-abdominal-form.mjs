import {createServer} from 'vite'
import {build} from 'esbuild'
import {chromium,expect} from '@playwright/test'
import fs from 'node:fs/promises'
await fs.mkdir('.tools/abdominal-check',{recursive:true})
await build({stdin:{contents:"import catalog from './src/catalog.json';import {reviseForm} from './src/formRevisions';export const original={code:'brooho',version:'1',configurationRevision:0,definitions:catalog.brooho_1};export const current=reviseForm(original);",resolveDir:process.cwd()},bundle:true,platform:'node',format:'esm',outfile:'.tools/abdominal-check/forms.mjs'})
const {current,original}=await import('../.tools/abdominal-check/forms.mjs')
const server=await createServer({plugins:[{name:'abdominal-test-transport',enforce:'pre',transform(code,id){
 if(id.endsWith('/src/api.ts'))return code.replace('export const desktop = isTauri()','export const desktop = true').replace('if (desktop)','if (false)')
 if(id.endsWith('/src/views/StudyEditor.vue'))return code.replace('if(desktop)unlistenClose=','if(false)unlistenClose=')
 if(id.endsWith('/src/components/AppUpdate.vue'))return code.replace("import { getVersion } from '@tauri-apps/api/app'","const getVersion=async()=>'1.1.0'").replace("import { listen, type UnlistenFn } from '@tauri-apps/api/event'","type UnlistenFn=()=>void;const listen=async()=>()=>{}")
}}],server:{host:'127.0.0.1',port:1468}})
await server.listen()
const browser=await chromium.launch({channel:'msedge',headless:true})
const page=await browser.newPage({viewport:{width:1440,height:1000}}),errors=[]
page.on('pageerror',e=>errors.push(e.message))
let saved
const study=(id,form,fields)=>({id,patient_id:1,date:'2026-11-11',template_id:80,doctor_id:1,title:'УЗИ брюшной полости',conclusion:'Тестовое заключение',addition:'',fields,legacy_version:'1',origin:'native',status:'draft',revision:1,doctor:'Тестовый врач',patientName:'Тестовый пациент',patientBirthdate:'2000-01-01',templateCode:'BROOHO',formSnapshot:form})
const entries=[{id:1,templateId:80,parentId:0,key:'CONFIG.USERS_PARAMS.BROOHO.STR_TEXT',name:'Структура',folder:true},{id:2,templateId:80,parentId:1,key:'',name:'Структура из справочника',value:'Изменения структуры <тест>',folder:false},{id:3,templateId:80,parentId:0,key:'CONFIG.USERS_PARAMS.BROOHO.V_POLOSTI',name:'Содержимое',folder:true},{id:4,templateId:80,parentId:3,key:'',name:'Содержимое из справочника',value:'Содержимое из справочника',folder:false}].map(e=>({...e,hidden:false,deleted:false,revision:0,position:e.id,value:e.value||''}))
await page.route('**/__archive/*',async route=>{
 const name=route.request().url().split('/').at(-1),args=route.request().postDataJSON()
 if(name==='save_study'){saved=args.input;return route.fulfill({json:100})}
 const data={auth_status:{setupRequired:false,user:{id:1,name:'Тестовый врач',role:'doctor',doctorId:1}},check_update:{current:'1.1.0',version:null},database_info:{patients:1,studies:1,templates:[{id:80,name:'УЗИ брюшной полости',code:'BROOHO',formCode:'brooho',version:'1',formSnapshot:current}],doctors:[{id:1,name:'Тестовый врач'}]},patient_detail:{patient:{id:1,name:'Тестовый пациент',gender:'M',birthdate:'2000-01-01'},studies:[]},list_attachments:[],user_templates:entries,study_detail:args.id===900?study(900,original,{description:{value:'Прежнее описание',type:'text'},one_o:{value:'631',type:'checkbox'}}):study(100,current,saved?.fields||{})}[name]
 if(data===undefined)throw Error('Unexpected command: '+name)
 return route.fulfill({json:data})
})
const field=key=>page.locator(`[data-field="${key}"]`)
async function choose(key,label){await field(key).getByRole('combobox').click();await page.getByRole('option',{name:label,exact:true}).click()}
try{
 await page.goto('http://127.0.0.1:1468/#/studies/new/1')
 await page.getByRole('combobox').first().click();await page.getByRole('option',{name:'УЗИ брюшной полости',exact:true}).click()
 await expect(page.getByLabel('Протокол',{exact:true})).toHaveCount(0)
 await page.getByRole('checkbox',{name:'Показать все поля шаблона',exact:true}).check()
 for(const key of ['one_o','one_obraz1','m_seg1','m_seg8','m_cdk','m_razot','m_razdo','pechen_str_text','jel_net'])await expect(field(key)).toHaveCount(0)
 await choose('kontur','четкие');await choose('stenki','утолщены');await choose('soderg','умеренное количество застойного содержимого')
 await choose('forma_izm','Сокращён на тощак')
 // The legacy blank code means the organ is visible. Choose it by its stable
 // list position: the placeholder precedes the original blank choice.
 await field('forma_izm').getByRole('combobox').click();await page.getByRole('option').nth(1).click()
 await choose('struktura','Выбрать из справочника')
 await expect(page.getByRole('dialog')).toBeVisible();await expect(page.locator('.template-card')).toHaveCount(1)
 await page.getByRole('button',{name:'Вставить',exact:true}).click()
 await expect(field('struktura')).toContainText('Изменения структуры <тест>')
 await field('v_polosti').getByRole('button',{name:'Выбрать из справочника',exact:true}).click()
 await expect(page.locator('.template-card')).toHaveCount(1);await page.getByRole('button',{name:'Вставить',exact:true}).click()
 await expect(field('v_polosti')).toContainText('Содержимое из справочника')
 await choose('struktura','однородная');await expect(field('struktura')).not.toContainText('Изменения структуры <тест>')
 await choose('struktura','Выбрать из справочника');await page.getByRole('button',{name:'Вставить',exact:true}).click()
 await page.getByPlaceholder('Введите заключение…').fill('Проверка новой формы')
 await page.getByRole('button',{name:'Сохранить черновик',exact:true}).click()
 await expect(page).toHaveURL(/studies\/100$/)
 if(saved.fields.pechen_str_text.value!=='Изменения структуры <тест>'||saved.fields.v_polosti.value!=='Содержимое из справочника'||saved.fields.struktura.value!=='125')throw Error('Dictionary choices did not survive save')
 await page.getByRole('button',{name:'Ещё',exact:true}).click();await page.getByRole('menuitem',{name:'Предпросмотр документа'}).click()
 await expect(page.locator('.legacy-protocol').last()).toContainText('Изменения структуры <тест>')
 await expect(page.locator('.legacy-protocol').last()).toContainText('Содержимое из справочника')
 await page.screenshot({path:'.tools/abdominal-check/preview.png',fullPage:true})
 await page.getByRole('button',{name:'Вернуться к редактированию',exact:true}).click()
 for(const width of [1440,960]){await page.setViewportSize({width,height:1000});await page.screenshot({path:`.tools/abdominal-check/editor-${width}.png`,fullPage:true});if(await page.evaluate(()=>document.documentElement.scrollWidth>innerWidth))throw Error('Page overflow at '+width)}
 await page.goto('http://127.0.0.1:1468/#/studies/900')
 await expect(page.getByLabel('Протокол',{exact:true})).toHaveValue('Прежнее описание')
 await page.getByRole('checkbox',{name:'Показать все поля шаблона',exact:true}).check();await expect(field('one_o')).toBeVisible()
 if(errors.length)throw Error(errors.join('\n'))
 await fs.writeFile('docs/abdominal-form-check.json',JSON.stringify({date:'2026-11-11',newForm:true,hiddenFields:true,dictionarySections:true,dictionarySave:true,printedText:true,oldFormPreserved:true,widths:[1440,960],pageErrors:errors},null,2)+'\n')
 console.log('Abdominal form: editor, dictionary selection, save, print and old snapshot passed')
}finally{await browser.close();await server.close()}
