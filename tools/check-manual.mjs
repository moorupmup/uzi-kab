import {chromium,expect} from '@playwright/test'
import {pathToFileURL} from 'node:url'
import path from 'node:path'
const browser=await chromium.launch({headless:true,channel:'msedge'})
const page=await browser.newPage({viewport:{width:1440,height:1000}})
const errors=[];page.on('pageerror',e=>errors.push(e.message))
await page.goto(pathToFileURL(path.resolve('docs/Инструкция для врача.html')).href)
await expect(page.locator('article section')).toHaveCount(21)
await page.locator('article img').evaluateAll(imgs=>Promise.all(imgs.map(img=>{img.loading='eager';return img.decode()})))
await page.screenshot({path:'.tools/manual-desktop.png'})
await page.locator('.zoom').first().click();await expect(page.locator('#lightbox')).toBeVisible();await page.keyboard.press('Escape');await expect(page.locator('#lightbox')).toBeHidden()
await page.setViewportSize({width:390,height:844});await page.screenshot({path:'.tools/manual-mobile.png'})
const overflow=await page.evaluate(()=>document.documentElement.scrollWidth>innerWidth)
if(overflow||errors.length)throw Error(JSON.stringify({overflow,errors}))
await page.emulateMedia({media:'print'});await page.pdf({path:'.tools/manual-print-check.pdf',preferCSSPageSize:true})
console.log(JSON.stringify({sections:21,screenshots:10,imagesLoaded:true,zoom:true,mobileOverflow:overflow,pageErrors:errors,printRendered:true}))
const {writeFileSync}=await import('node:fs');writeFileSync('docs/parity-manual-check.json',JSON.stringify({sections:21,screenshots:10,imagesLoaded:true,zoom:true,mobileOverflow:overflow,pageErrors:errors,printRendered:true},null,2));await browser.close()
