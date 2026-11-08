import {describe,it,expect} from 'vitest'
import {existsSync,readFileSync,writeFileSync} from 'node:fs'
import {renderLegacy} from './legacy'
import type {FieldValue} from './types'

describe('Legacy rendering',()=>{
  it('does not execute inserted markup',()=>{
    const result=renderLegacy('BROOHO','1',{pechen:{type:'string',value:'<script>test()</script>'}})
    expect(result.supported).toBe(true)
    expect(result.html).toContain('&lt;script&gt;')
    expect(result.html).not.toContain('<script>')
  })
  it('never substitutes a different template version',()=>{
    expect(renderLegacy('ginekol','999',{}).supported).toBe(false)
  })
  it('keeps optional branches out of an empty protocol',()=>{
    const blank=renderLegacy('BROOHO','1',{})
    const size=renderLegacy('BROOHO','1',{kosoi_r:{type:'string',value:'140'}})
    expect(blank.html).not.toContain('размер правой доли 140')
    expect(size.html).toContain('140')
    expect(blank.activeFields).toContain('kosoi_r')
    expect(blank.activeFields).toContain('kosoi_l')
  })
  it.skipIf(!existsSync('.tools/oracle/cases.json'))('matches execution of the original JSP on the private corpus',()=>{
    const cases=JSON.parse(readFileSync('.tools/oracle/cases.json','utf8')) as {key:string;file:string;fields:Record<string,FieldValue>}[]
    const normalize=(html:string)=>html.replace(/<!--[\s\S]*?-->/g,'').replace(/<[^>]*>/g,'').replaceAll('&nbsp;',' ').replaceAll('&lt;','<').replaceAll('&gt;','>').replaceAll('&quot;','"').replaceAll('&#39;',"'").replaceAll('&amp;','&').replace(/\s+/g,' ').trim()
    const failed:string[]=[],byTemplate:Record<string,number>={}
    for(const sample of cases){
      const at=sample.key.lastIndexOf('_'),code=sample.key.slice(0,at),version=sample.key.slice(at+1)
      const result=renderLegacy(code,version,sample.fields)
      const oracle=readFileSync('.tools/oracle/'+sample.file+'.html','utf8')
      if(!result.supported||normalize(result.html)!==normalize(oracle))failed.push(sample.file)
      byTemplate[sample.key]=(byTemplate[sample.key]||0)+1
    }
    writeFileSync('docs/template-parity.json',JSON.stringify({samples:cases.length,byTemplate,mismatches:failed.length},null,2))
    if(failed.length)throw new Error('JSP parity mismatch in private cases: '+failed.join(', '))
  })
})
