import re,json,html
from pathlib import Path
base=Path(r'C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi/jsp/protocol_form')
result={}
for path in base.glob('*.jsp'):
 if path.stem in ['header','footer']:continue
 s=path.read_text(encoding='cp1251'); fields=[]; seen=set()
 for m in re.finditer(r'r\.(getSelect|getSizeInput|getCheckbox|getTextArea|getInput|getTextInput)\("([^"]+)"\)',s):
  kind,key=m.groups()
  if key in seen:continue
  seen.add(key)
  before=s[max(0,m.start()-220):m.start()]
  before=re.sub(r'<%.*?%>','',before,flags=re.S)
  labels=re.findall(r'<td[^>]*>([^<]+)(?:</td>|$)',before,re.I)
  label=html.unescape(labels[-1].strip()) if labels else ''
  if not label or len(label)>100:label=key
  fields.append({'key':key,'label':label,'kind':kind})
 result[path.stem.lower()]=fields
Path('src').mkdir(exist_ok=True)
Path('src/catalog.json').write_text(json.dumps(result,ensure_ascii=False,indent=2),encoding='utf-8')
print('Form versions:',len(result),'Fields:',sum(map(len,result.values())))
