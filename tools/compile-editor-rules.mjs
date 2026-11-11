import {readFileSync,writeFileSync} from 'node:fs'
import {runInNewContext} from 'node:vm'
const dom=JSON.parse(readFileSync('.tools/editor-dom.json','utf8')),source=JSON.parse(readFileSync('.tools/editor-condition-source.json','utf8')),catalog=JSON.parse(readFileSync('src/catalog.json','utf8'))
let cases=0;
for(const row of source){const model=dom[row.key];model.rules=[];
 for(const f of row.functions){const refs=[...new Set([...f.code.matchAll(/document\.protocol\.(\w+)\.(value|checked)/g)].map(m=>m[1]))];if(refs.length!==1)throw Error(row.key+' multi input '+f.name);const field=refs[0],checked=f.code.includes('.checked');const values=new Set(['','0','__other',...(catalog[row.key].find(d=>d.key===field)?.options||[]).map(o=>o.value),...[...f.code.matchAll(/(?:==|!=)\s*"([^"]*)"/g)].map(m=>m[1])]);const outcomes={};
 for(const value of values){const ctx={document:{protocol:{[field]:{value,checked:checked&&value!==''&&value!=='0'}}}};const changed={};for(const id of f.ids){let display=model.initial[id]===false?'none':'';ctx[id]={style:Object.defineProperty({},'display',{get:()=>display,set:v=>{display=v;changed[id]=v!=='none'}})}};runInNewContext(f.code+';'+f.name+'();',ctx,{timeout:100});outcomes[value]=changed;cases++}
 model.rules.push({field,checked,defaultValue:checked?'':(catalog[row.key].find(d=>d.key===field)?.options?.[0]?.value||''),outcomes});
 }
 delete model.helpers;
 // RequestWrapper.getChangeHidden emits a hidden div and a selector equality function.
 const helpers=JSON.parse(readFileSync('.tools/editor-dom.json','utf8'))[row.key].helpers;
 for(const h of helpers)model.rules.push({field:h.field,equals:h.value,id:h.id,defaultValue:catalog[row.key].find(d=>d.key===h.field)?.options?.[0]?.value||''});
}
writeFileSync('src/editor-conditions.json',JSON.stringify(dom,null,2));writeFileSync('docs/editor-condition-compilation.json',JSON.stringify({versions:Object.keys(dom),functionCases:cases,runtimeEvaluation:false},null,2));console.log({versions:Object.keys(dom).length,cases});
