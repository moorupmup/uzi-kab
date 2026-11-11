import { createServer } from 'vite'
import { chromium, expect } from '@playwright/test'
import fs from 'node:fs/promises'

// Transport fixtures only: the shipped component and navigation guards remain unchanged.
const server = await createServer({plugins:[{name:'updater-test-transport',enforce:'pre',transform(code,id){
  if(id.endsWith('/src/api.ts')) return code.replace('export const desktop = isTauri()','export const desktop = true').replace('if (desktop)', 'if (false)')
  if(id.endsWith('/src/views/StudyEditor.vue')) return code.replace('if(desktop)unlistenClose=', 'if(false)unlistenClose=')
  if(id.endsWith('/src/components/AppUpdate.vue')) return code.replace("import { getVersion } from '@tauri-apps/api/app'", "const getVersion = async () => '1.1.0'").replace("import { listen, type UnlistenFn } from '@tauri-apps/api/event'", "type UnlistenFn = () => void; const listen = async <T,>(_: string, cb: (e: {payload: T}) => void): Promise<UnlistenFn> => { (window as any).updateProgress = cb; return () => {} }")
}}],server:{host:'127.0.0.1',port:1467}})
await server.listen()
const browser = await chromium.launch({channel:'msedge',headless:true})
const page = await browser.newPage({viewport:{width:1440,height:940}})
let available = null, installs = 0
const errors=[];page.on('pageerror',e=>errors.push(e.message))
await page.route('**/__archive/*',async route=>{
  const name=route.request().url().split('/').at(-1)
  if(name==='install_update') { installs++; await new Promise(r=>setTimeout(r,500)); return route.fulfill({status:500,json:{error:'Тестовая ошибка скачивания'}}) }
  const data={auth_status:{setupRequired:false,user:{id:1,name:'Тестовый врач',role:'doctor',doctorId:1}},check_update:{current:'1.1.0',version:available},database_info:{patients:0,studies:0,templates:[{id:1,name:'Щитовидная железа',code:'shit'}],doctors:[{id:1,name:'Тестовый врач'}]},list_patients:{total:0,items:[]},patient_detail:{patient:{id:1,name:'Тестовый пациент',gender:'M',birthdate:'2000-01-01'},studies:[]},list_attachments:[],patient_bundles:[],decision_options:{groups:[],branches:[]}}[name]
  if(data===undefined)throw Error('Unexpected command: '+name)
  await route.fulfill({json:data})
})
try {
  await page.goto('http://127.0.0.1:1467')
  await expect(page.locator('.app-version')).toContainText('1.1')
  await expect(page.getByRole('button',{name:'Обновить программу',exact:true})).toHaveCount(0)
  available='1.2.0';await page.reload()
  const button=page.getByRole('button',{name:'Обновить программу',exact:true})
  await expect(button).toBeVisible();await expect(page.locator('.update-badge')).toHaveText('1.2')
  await button.hover();await expect(page.getByRole('tooltip')).toContainText('Обновить программу')
  await fs.mkdir('.tools/update-check',{recursive:true})
  for(const width of [1440,960]){
    await page.setViewportSize({width,height:940})
    await expect(button).toBeVisible()
    await page.locator('.sidebar-bottom').screenshot({path:`.tools/update-check/sidebar-${width}.png`})
    if(await page.locator('.sidebar-bottom').evaluate(el=>el.scrollWidth>el.clientWidth))throw Error('Sidebar overflow '+JSON.stringify(await page.locator('.sidebar-bottom').evaluate(el=>[el,...el.querySelectorAll('*')].map(e=>({tag:e.tagName,cls:e.className,w:e.getBoundingClientRect().width,scroll:e.scrollWidth,x:e.getBoundingClientRect().x})))) )
  }
  await button.click();await expect(page.getByRole('dialog',{name:'Обновляем программу'})).toBeVisible()
  await expect(page.getByRole('alert')).toContainText('Тестовая ошибка скачивания')
  if(installs!==1)throw Error('Duplicate install')
  await page.goto('http://127.0.0.1:1467/#/studies/new/1')
  await page.getByPlaceholder('Введите заключение…').fill('Несохранённое заключение')
  await button.click()
  await expect(page.getByRole('dialog')).toBeVisible()
  if(installs!==1)throw Error('Update bypassed unsaved changes')
  await page.getByRole('button',{name:'Продолжить редактирование',exact:true}).click()
  await expect(page.getByPlaceholder('Введите заключение…')).toHaveValue('Несохранённое заключение')
  await expect(button).toBeEnabled()
  if(installs!==1)throw Error('Cancelled update was installed')
  await button.click();await page.getByRole('button',{name:'Выйти без сохранения',exact:true}).click()
  await expect(page.getByRole('alert')).toContainText('Тестовая ошибка скачивания')
  if(installs!==2)throw Error('Confirmed update did not start')
  if(errors.length)throw Error(errors.join('\n'))
  const {writeFileSync}=await import('node:fs');writeFileSync('docs/parity-updater-ui.json',JSON.stringify({version:'1.1.0',mockedReleaseOnly:true,noUpdate:true,badgeAndTooltip:true,responsiveFooter:true,downloadError:true,unsavedChangesCancellation:true,pageErrors:errors},null,2));console.log('Passed: no update, available badge, tooltip, responsive footer, download error, unsaved changes cancellation.')
} finally { await browser.close();await server.close() }
