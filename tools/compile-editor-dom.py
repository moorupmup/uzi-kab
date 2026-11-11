from pathlib import Path
import re,json
from html.parser import HTMLParser
catalog=json.loads(Path('src/catalog.json').read_text(encoding='utf-8'));source=json.loads(Path('.tools/editor-condition-source.json').read_text(encoding='utf-8'));output={}
for row in source:
 key=row['key'];s=Path('legacy/forms/'+key+'.jsp').read_text(encoding='cp1251');helpers=[]
 def helper(m):
  field,n,value=m.groups();helpers.append({'field':field,'id':'display'+n,'value':value});return '<div id="display'+n+'" style="display:none">'
 s=re.sub(r'<%=\s*r.getChangeHidden\("([^"]+)",\s*"([^"]+)",\s*"([^"]+)"\)\s*%>',helper,s)
 s=re.sub(r'<script\b[^>]*>[\s\S]*?</script>','',s,flags=re.I)
 def widget(m):return '<span data-field="'+m[1]+'"></span>' if m[1] in {f['key'] for f in catalog[key]} else ''
 s=re.sub(r'<%=\s*r\.\w+\("([^"]+)"[^%]*%>',widget,s);s=re.sub(r'<%[\s\S]*?%>','',s)
 class Dom(HTMLParser):
  def __init__(self):super().__init__();self.stack=[];self.initial={};self.fields={}
  def handle_starttag(self,tag,attrs):
   attrs=dict(attrs)
   if tag=='div':
    id=attrs.get('id');self.stack.append(id)
    if id:self.initial[id]=not bool(re.search(r'display\s*:\s*none',attrs.get('style',''),re.I))
   field=attrs.get('data-field')
   if field:self.fields.setdefault(field,[]).append([id for id in self.stack if id])
  def handle_endtag(self,tag):
   if tag=='div' and self.stack:self.stack.pop()
 dom=Dom();dom.feed(s);output[key]={'initial':dom.initial,'fields':dom.fields,'helpers':helpers}
Path('.tools/editor-dom.json').write_text(json.dumps(output,ensure_ascii=False,indent=2),encoding='utf-8')
