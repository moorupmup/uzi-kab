import {readFileSync,writeFileSync} from 'node:fs'
import {runInNewContext} from 'node:vm'
const catalog=JSON.parse(readFileSync('src/catalog.json','utf8')),versions=JSON.parse(readFileSync('src/legacy-versions.json','utf8'))
const report=[]
for(const key of [...new Set([...Object.entries(versions).map(([code,v])=>`${code}_${v}`),'eho_kg_1','ginekol_1'])]){
 const s=readFileSync(`legacy/forms/${key}.jsp`,'latin1'),functions=[];
 for(const match of s.matchAll(/function\s+(\w+)\s*\([^)]*\)\s*\{/g)){
  let level=1,end=match.index+match[0].length;for(;end<s.length&&level;end++){if(s[end]==='{')level++;else if(s[end]==='}')level--}
  const code=s.slice(match.index,end);if(!code.includes('.style.display'))continue;
  const inputs=[...new Set([...code.matchAll(/document\.protocol\.(\w+)\.value/g)].map(m=>m[1]))];
  const ids=[...new Set([...code.matchAll(/(\w+)\.style\.display/g)].map(m=>m[1]))];
  functions.push({name:match[1],inputs,ids,code});
 }
 report.push({key,functions})
}
writeFileSync('.tools/editor-condition-source.json',JSON.stringify(report,null,2));console.log(report.map(r=>({key:r.key,functions:r.functions.length,multi:r.functions.filter(f=>f.inputs.length!==1).map(f=>({name:f.name,inputs:f.inputs}))})))
