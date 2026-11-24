import {createServer} from 'vite'
import {build} from 'esbuild'
import {chromium,expect} from '@playwright/test'
import fs from 'node:fs/promises'
await fs.mkdir('.tools/abdominal-check',{recursive:true})
await build({stdin:{contents:"import catalog from './src/catalog.json';import {reviseForm} from './src/formRevisions';export const original={code:'brooho',version:'1',configurationRevision:0,definitions:catalog.brooho_1};export const current=reviseForm(original);export {catalog}; export {default as models} from './src/editor-conditions.json';",resolveDir:process.cwd()},bundle:true,platform:'node',format:'esm',outfile:'.tools/abdominal-check/forms.mjs'})
const {current,original,catalog,models}=await import('../.tools/abdominal-check/forms.mjs')
const server=await createServer({plugins:[{name:'abdominal-test-transport',enforce:'pre',transform(code,id){
 if(id.endsWith('/src/api.ts'))return code.replace('export const desktop = isTauri()','export const desktop = true').replace('if (desktop)','if (false)')
 if(id.endsWith('/src/views/StudyEditor.vue'))return code.replace('if(desktop)unlistenClose=','if(false)unlistenClose=')
 if(id.endsWith('/src/components/AppUpdate.vue'))return code.replace("import { getVersion } from '@tauri-apps/api/app'","const getVersion=async()=>'1.1.0'").replace("import { listen, type UnlistenFn } from '@tauri-apps/api/event'","type UnlistenFn=()=>void;const listen=async()=>()=>{}")
}}],server:{host:'127.0.0.1',port:24681}})
await server.listen()
const browser=await chromium.launch({channel:'msedge',headless:true})
const page=await browser.newPage({viewport:{width:1440,height:1000}}),errors=[]
page.on('pageerror',e=>errors.push(e.message))
let saved
const study=(id,form,fields)=>({id,patient_id:1,date:'2026-11-11',template_id:80,doctor_id:1,title:'УЗИ брюшной полости',conclusion:'Тестовое заключение',addition:'',fields,legacy_version:'1',origin:'native',status:'draft',revision:1,doctor:'Тестовый врач',patientName:'Тестовый пациент',patientBirthdate:'2000-01-01',templateCode:'BROOHO',formSnapshot:form})
const sourceForms=Object.keys(models).map(key=>{
 const separator=key.lastIndexOf('_')
 return {code:key.slice(0,separator),version:key.slice(separator+1),configurationRevision:0,definitions:catalog[key]}
})
const entries=[
 [1,80,0,'CONFIG.USERS_PARAMS.BROOHO.STR_TEXT','Структура'],
 [2,80,1,'','Изменения структуры <тест>'],
 [3,80,0,'CONFIG.USERS_PARAMS.BROOHO.V_POLOSTI','Содержимое'],
 [4,80,3,'','Содержимое из справочника'],
 [5,80,0,'BASE.DECISION.BROOHO','Заключения'],
 [6,80,5,'','Фраза заключения'],
 [15,80,5,'','Группа'],
 [16,80,15,'','Начало фразы.'],
 [17,80,16,'',', продолжение фразы.'],
 [7,80,0,'CONFIG.ADDITION.BROOHO','Дополнения'],
 [8,80,7,'','Фраза рекомендации'],
 [9,22,0,'BASE.DECISION.POCHKI','Другой вид'],
 [10,22,9,'','Фраза другого вида'],
 [11,80,0,'CONFIG.USERS_PARAMS.BROOHO.POCHKA_TEXT','Дополнительные сведения о почках'],
 [12,80,11,'','Фраза для обеих почек'],
 [13,80,0,'CONFIG.USERS_PARAMS.BROOHO.DESCRIPTION','Свободное описание'],
 [14,80,13,'','Фраза общего описания'],
].map(([id,templateId,parentId,key,name])=>({id,templateId,parentId,key,name,folder:Boolean(key)||id===15||id===16,includeInPhrase:id!==15,hidden:false,deleted:false,revision:0,position:id,value:key?'':name}))
await page.route('**/__archive/*',async route=>{
 const name=route.request().url().split('/').at(-1),args=route.request().postDataJSON()
 const fixture=sourceForms[args.id-1000]
 if(name==='study_detail'&&fixture)return route.fulfill({json:{
  ...study(args.id,fixture,{}),title:fixture.code,legacy_version:fixture.version,templateCode:fixture.code
 }})
 if(name==='save_study'){saved=args.input;return route.fulfill({json:100})}
 const data={auth_status:{setupRequired:false,user:{id:1,name:'Тестовый врач',role:'doctor',doctorId:1}},check_update:{current:'1.1.0',version:null},database_info:{patients:1,studies:1,templates:[{id:80,name:'УЗИ брюшной полости',code:'BROOHO',formCode:'brooho',version:'1',formSnapshot:current}],doctors:[{id:1,name:'Тестовый врач'}]},patient_detail:{patient:{id:1,name:'Тестовый пациент',gender:'M',birthdate:'2000-01-01'},studies:[]},list_attachments:[],user_templates:entries,study_detail:args.id===900?study(900,original,{description:{value:'Прежнее описание',type:'text'},one_o:{value:'631',type:'checkbox'}}):study(100,current,saved?.fields||{})}[name]
 if(data===undefined)throw Error('Unexpected command: '+name)
 return route.fulfill({json:data})
})
const field=key=>page.locator(`[data-field="${key}"]`)
async function choose(key,label){await field(key).getByRole('combobox').click();await page.getByRole('option',{name:label,exact:true}).click()}
async function openTemplates(control,expected){
 const size=await control.evaluate(button=>({width:button.offsetWidth,height:button.offsetHeight}))
 expect(size).toEqual({width:34,height:34})
 await control.click()
 const dialog=page.getByRole('dialog')
 await expect(dialog.locator('.template-card-text')).toHaveText(expected)
 await expect(dialog.getByLabel('Куда вставить')).toHaveCount(0)
 await expect(dialog.getByLabel('Вид исследования')).toHaveCount(0)
 return dialog
}
try{
 await page.goto('http://127.0.0.1:24681/#/studies/new/1')
 await page.getByRole('combobox').first().click();await page.getByRole('option',{name:'УЗИ брюшной полости',exact:true}).click()
 const calendarTrigger=page.getByRole('button',{name:'Открыть календарь'})
 await calendarTrigger.click()
 const datePopup=page.locator('.study-date-popup')
 await expect(datePopup).toBeVisible()
 await page.screenshot({path:'.tools/abdominal-check/study-date-picker.png'})
 await datePopup.locator('[data-slot="cellTrigger"]').getByText('5',{exact:true}).first().click()
 await expect(datePopup).toBeHidden()
 await expect(page.locator('.document-header')).toContainText(/05\.\d{2}\.\d{4}/)
 await calendarTrigger.click()
 await datePopup.getByRole('button',{name:'Сегодня'}).click()
 await expect(datePopup).toBeHidden()
 await expect(page.getByLabel('Протокол',{exact:true})).toHaveCount(0)
 await expect(page.getByRole('checkbox',{name:'Показать все поля шаблона',exact:true})).toHaveCount(0)
 for(const key of ['one_o','one_obraz1','m_seg1','m_seg8','m_cdk','m_razot','m_razdo','jel_net'])await expect(field(key)).toHaveCount(0)
 await expect(page.getByRole('button',{name:'Пересчитать',exact:true})).toHaveCount(0)
 await expect(page.getByRole('switch',{name:'Группировка как в оригинале'})).toHaveCount(0)
 await expect(page.locator('.source-form-layout')).toHaveCount(6)
 await field('kosoi_r').locator('input').fill('123')
 await page.screenshot({path:'.tools/abdominal-check/source-layout.png'})

 await choose('struktura','неоднородная за счет')
 await expect(page.getByRole('dialog')).toHaveCount(0)
 await expect(field('one_o')).toBeVisible()
 await expect(field('one_obraz1')).toHaveCount(0)
 await field('one_o').getByRole('checkbox').check()
 for(const key of ['one_obraz1','one_obraz2','one_obraz3','r1_obraz1'])await expect(field(key)).toBeVisible()
 await field('r1_obraz1').locator('input').fill('12')
 await field('one_o').getByRole('checkbox').uncheck()
 await expect(field('r1_obraz1')).toHaveCount(0)
 await field('one_o').getByRole('checkbox').check()
 await expect(field('r1_obraz1').locator('input')).toHaveValue('12')
 await field('many_o').getByRole('checkbox').check()
 for(const key of ['m_seg1','m_seg8','m_cdk','m_razot','m_razdo'])await expect(field(key)).toBeVisible()
 await field('m_seg1').getByRole('checkbox').check()
 await page.screenshot({path:'.tools/abdominal-check/conditional-fields.png',fullPage:true})
 await choose('struktura','однородная')
 await expect(field('one_o')).toHaveCount(0)
 await expect(field('m_seg1')).toHaveCount(0)
 await choose('struktura','неоднородная за счет')
 await expect(field('r1_obraz1').locator('input')).toHaveValue('12')
 await expect(field('m_seg1').getByRole('checkbox')).toBeChecked()
 await choose('forma_izm','не визуализируется')
 await expect(field('jelch_dl')).toHaveCount(0)
 await expect(field('jelch_p')).toBeVisible()
 await field('forma_izm').getByRole('combobox').click();await page.getByRole('option').nth(1).click()
 await expect(field('jelch_dl')).toBeVisible()
 await choose('pod_jel','не просматривается')
 await expect(field('golov')).toHaveCount(0)
 await expect(field('jel_net')).toBeVisible()
 await field('pod_jel').getByRole('combobox').click();await page.getByRole('option').nth(1).click()
 await expect(field('golov')).toBeVisible()
 await field('jelch_dl').locator('input').fill('60')
 await field('jelch_tol').locator('input').fill('20')
 await field('jelch_sh').locator('input').fill('30')
 await expect(field('jelch_ob').locator('input')).toHaveValue('18.83')
 await field('jelch_sh').locator('input').fill('')
 await expect(field('jelch_ob').locator('input')).toHaveValue('')
 await choose('kontur','четкие');await choose('stenki','утолщены');await choose('soderg','умеренное количество застойного содержимого')
 await choose('forma_izm','Сокращён на тощак')
 // The legacy blank code means the organ is visible. Choose it by its stable
 // list position: the placeholder precedes the original blank choice.
 await field('forma_izm').getByRole('combobox').click();await page.getByRole('option').nth(1).click()
 await choose('struktura','неоднородная за счет')
 await (await openTemplates(field('pechen_str_text').getByRole('button',{name:/Шаблоны для поля/}),['Изменения структуры <тест>'])).getByRole('button',{name:'Вставить',exact:true}).click()
 await page.keyboard.press('Escape')
 await expect(field('pechen_str_text').locator('textarea')).toHaveValue('Изменения структуры <тест>')
 const contentsTemplates=await openTemplates(field('v_polosti').getByRole('button',{name:'Выбрать из справочника',exact:true}),['Содержимое из справочника'])
 await contentsTemplates.getByRole('button',{name:'Вставить',exact:true}).click()
 await page.keyboard.press('Escape')
 await expect(field('v_polosti')).toContainText('Содержимое из справочника')
 await choose('struktura','однородная')
 await choose('struktura','неоднородная за счет')
 await expect(field('pechen_str_text').locator('textarea')).toHaveValue('Изменения структуры <тест>')
 await choose('r_pochka','расположена в обычном месте')
 await choose('l_pochka','расположена в обычном месте')
 for(const side of ['r','l']){
  const chash=`${side}_chash`
  await choose(chash,current.definitions.find(definition=>definition.key===chash).options.find(option=>option.value==='140').label)
  const key=`${side}_pochka_text`
  const dialog=await openTemplates(field(key).getByRole('button',{name:/Шаблоны для поля/}),['Фраза для обеих почек'])
  await page.keyboard.press('Escape')
  await expect(dialog).toBeHidden()
  await expect(field(key).locator('textarea')).toHaveValue('')
 }
 const addition=await openTemplates(page.getByRole('button',{name:'Шаблоны для поля «Дополнение и рекомендации»'}),['Фраза рекомендации'])
 await addition.getByRole('button',{name:'Вставить',exact:true}).click()
 await page.keyboard.press('Escape')
 await expect(page.getByPlaceholder('При необходимости')).toHaveValue('Фраза рекомендации')
 const conclusion=page.getByPlaceholder('Введите заключение…')
 await conclusion.fill('До после')
 await conclusion.evaluate(input=>input.setSelectionRange(3,3))
 const conclusionTemplates=await openTemplates(page.getByRole('button',{name:'Шаблоны для поля «Заключение»'}),['Фраза заключения',', продолжение фразы.'])
 await conclusionTemplates.getByRole('button',{name:'Вставить',exact:true}).first().click()
 await expect(conclusionTemplates).toBeVisible()
 await conclusionTemplates.getByRole('button',{name:'Собрать фразу',exact:true}).click()
 const compose=page.getByRole('dialog',{name:'Составная фраза'})
 await expect(compose.getByRole('checkbox',{name:'Группа'})).not.toBeChecked()
 await expect(compose.getByRole('checkbox',{name:'Заключения'})).toHaveCount(0)
 await compose.getByRole('checkbox',{name:'Группа'}).check()
 await expect(compose.getByText('Группа Начало фразы, продолжение фразы.',{exact:true})).toBeVisible()
 await compose.getByRole('checkbox',{name:'Группа'}).uncheck()
 await compose.getByRole('button',{name:'Вставить фразу'}).click()
 await expect(compose).toBeHidden()
 await conclusionTemplates.getByRole('button',{name:'Вставить',exact:true}).first().click()
 await page.keyboard.press('Escape')
 await expect(conclusion).toHaveValue('До после Фраза заключения Начало фразы, продолжение фразы. Фраза заключения')
 await expect(conclusion).toBeFocused()
 await page.getByRole('button',{name:'Сохранить черновик',exact:true}).click()
 await expect(page).toHaveURL(/studies\/100$/)
 if(saved.fields.r1_obraz1.value!=='12'||saved.fields.m_seg1.value!=='609')throw Error('Hidden values did not survive save')
 if(saved.fields.pechen_str_text.value!=='Изменения структуры <тест>'||saved.fields.v_polosti.value!=='Содержимое из справочника'||saved.fields.struktura.value!=='125')throw Error('Dictionary choices did not survive save')
 await page.getByRole('button',{name:'Ещё',exact:true}).click();await page.getByRole('menuitem',{name:'Предпросмотр документа'}).click()
 await expect(page.locator('.legacy-protocol').last()).toContainText('Изменения структуры <тест>')
 await expect(page.locator('.legacy-protocol').last()).toContainText('Содержимое из справочника')
 await page.screenshot({path:'.tools/abdominal-check/preview.png',fullPage:true})
 await page.getByRole('button',{name:'Вернуться к редактированию',exact:true}).click()
 await page.locator('.study-contents a').filter({hasText:'Левая почка'}).click()
 await expect(page.locator('.structured-group').filter({has:page.getByRole('heading',{name:'Левая почка',exact:true})})).toBeInViewport()
 const stickyTop=await page.locator('.study-contents').evaluate(el=>el.getBoundingClientRect().top)
 if(stickyTop<0||stickyTop>30)throw Error('Contents did not remain sticky: '+stickyTop)
 for(const width of [1440,960,600]){await page.setViewportSize({width,height:1000});await page.screenshot({path:`.tools/abdominal-check/editor-${width}.png`,fullPage:true});if(await page.evaluate(()=>document.documentElement.scrollWidth>innerWidth))throw Error('Page overflow at '+width)}
 await page.goto('http://127.0.0.1:24681/#/studies/900')
 await expect(page.getByLabel('Протокол',{exact:true})).toHaveValue('Прежнее описание')
 await openTemplates(page.getByRole('button',{name:'Шаблоны для поля «Протокол»'}),['Фраза общего описания'])
 await page.keyboard.press('Escape')
 await expect(page.getByRole('checkbox',{name:'Показать все поля шаблона',exact:true})).toHaveCount(0);await choose('struktura','неоднородная за счет');await expect(field('one_o')).toBeVisible()
 // Exercise each supported version through the actual study editor, including archived versions.
 for(const [index,form] of sourceForms.entries()){
  await page.goto('http://127.0.0.1:24681/#/studies/'+(1000+index))
  await expect(page.getByRole('heading',{name:form.code,exact:true})).toBeVisible()
  if(form.definitions.length){
   await expect(page.locator('.source-form-layout .source-field-row').first()).toBeVisible()
   const formKey=`${form.code}_${form.version}`
   const branch={
    pochki_1:['r_chash','935','r_chash_size'],
    moloch_1:['moloch_protok','470','m_protok_mm'],
    koleno_1:['r_opred_gyd','351','r_jid_opred']
   }[formKey]
   if(branch){
    const [control,value,dependent]=branch
    const option=form.definitions.find(definition=>definition.key===control).options.find(option=>option.value===value)
    await expect(field(dependent)).toHaveCount(0)
    await choose(control,option.label)
    await expect(field(dependent)).toBeVisible()
    await choose(control,'Не указано')
    await expect(field(dependent)).toHaveCount(0)
   }
   if(formKey==='pos_pojas_1'){
    await expect(field('vir_izm')).toHaveCount(0)
    await field('struk_izm').getByRole('checkbox').check()
    await expect(field('vir_izm')).toBeVisible()
    await field('struk_izm').getByRole('checkbox').uncheck()
    await expect(field('vir_izm')).toHaveCount(0)
   }
   if(formKey==='shit_1'||formKey.startsWith('eho_kg_')||formKey==='beremen14_1'){
    await page.setViewportSize({width:1440,height:1000})
    await page.screenshot({path:`.tools/abdominal-check/${formKey}.png`})
   }
   for(const width of [1440,960,600]){
    await page.setViewportSize({width,height:1000})
    if(await page.evaluate(()=>document.documentElement.scrollWidth>innerWidth))
     throw Error(`Page overflow for ${form.code}_${form.version} at ${width}`)
   }
  }
  else await expect(page.getByLabel('Протокол',{exact:true})).toBeVisible()
 }
 if(errors.length)throw Error(errors.join('\n'))
 await fs.writeFile('docs/abdominal-form-check.json',JSON.stringify({date:'2026-11-18',defaultSourceLayout:true,newForm:true,hiddenFields:true,dictionarySections:true,dictionarySave:true,printedText:true,oldFormPreserved:true,widths:[1440,960,600],sourceVersions:sourceForms.length,pageErrors:errors},null,2)+'\n')
 console.log('Abdominal form: editor, dictionary selection, save, print and old snapshot passed')
}finally{await browser.close();await server.close()}
