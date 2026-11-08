"""Compile the supported JSP subset into a data-only AST, never executable JS.

Unknown Java statements reject the whole template. Original sources remain beside
the compiler for audit; no patient information is exported into application assets.
"""
import hashlib, html, json, re, shutil, sqlite3
from html.parser import HTMLParser
from pathlib import Path

ROOT=Path(__file__).resolve().parents[1]
SOURCE=Path(r'C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi')
DEST=ROOT/'legacy'

class Expression:
    def __init__(self,source):
        self.tokens=[]; self.i=0
        while source.strip():
            m=re.match(r'\s*("(?:\\.|[^"\\])*"|&&|\|\||[!+().,]|[A-Za-z_]\w*)',source)
            if not m: raise ValueError('Unsupported expression: '+source[:100])
            self.tokens.append(m[1]);source=source[m.end():]
    def peek(self):return self.tokens[self.i] if self.i<len(self.tokens) else None
    def take(self,want=None):
        t=self.peek()
        if t is None or want is not None and want!=t:raise ValueError('Expected '+str(want)+', got '+str(t))
        self.i+=1;return t
    def parse(self):
        e=self.binary(0)
        if self.peek() is not None:raise ValueError('Trailing expression: '+str(self.tokens[self.i:]))
        return e
    def binary(self,level):
        if level==3:return self.atom()
        op=['||','&&','+'][level]; e=self.binary(level+1)
        while self.peek()==op:self.take();e=[op,e,self.binary(level+1)]
        return e
    def atom(self):
        t=self.take()
        if t=='!':e=['!',self.atom()]
        elif t=='(':e=self.binary(0);self.take(')')
        elif t.startswith('"'):e=['literal',json.loads(t)]
        elif t=='r':
            self.take('.');method=self.take()
            if method not in ['get','empty','getSelect','getCheckbox']:raise ValueError('Unsupported method '+method)
            self.take('(');arg=self.binary(0);self.take(')');e=['empty' if method=='empty' else 'get',arg]
        elif t in ['true','false']:e=['literal',t=='true']
        else:e=['variable',t]
        while self.peek()=='.':
            self.take('.');method=self.take();self.take('(')
            if method=='toString':self.take(')')
            elif method=='equals':e=['equals',e,self.binary(0)];self.take(')')
            else:raise ValueError('Unsupported suffix '+method)
        return e

def expr(s):return Expression(s).parse()

class StaticHTML(HTMLParser):
    allowed={'b','strong','br','p','div','span','table','tbody','thead','tr','td','th','i','em','u','h3','h4','sup','sub','hr'}
    def __init__(self):super().__init__(convert_charrefs=False);self.out=[];self.blocked=0
    def handle_starttag(self,tag,attrs):
        if tag in ['script','style']:self.blocked+=1
        if not self.blocked and tag in self.allowed:
            attrs=''.join(' '+k+'="'+html.escape(v or '',quote=True)+'"' for k,v in attrs if k in ['colspan','rowspan'])
            self.out.append('<'+tag+attrs+'>')
    def handle_endtag(self,tag):
        if tag in ['script','style']:self.blocked=max(0,self.blocked-1);return
        if not self.blocked and tag in self.allowed:self.out.append('</'+tag+'>')
    def handle_data(self,data):
        if not self.blocked:self.out.append(data)
    def handle_entityref(self,name):self.handle_data('&'+name+';')
    def handle_charref(self,name):self.handle_data('&#'+name+';')

def compile_template(source):
    if re.search(r'<script\b',source,re.I):raise ValueError('Embedded script is not part of the print subset')
    if re.search(r'<%@\s*(?:include|taglib)',source,re.I):raise ValueError('Template include requires explicit compilation')
    root=[];target=root;stack=[]
    for token in re.split(r'(<%.*?%>)',source,flags=re.S):
        if not token:continue
        if not token.startswith('<%'):
            parser=StaticHTML();parser.feed(token)
            if parser.out:target.append(['html',''.join(parser.out)])
            continue
        body=token[2:-2].strip()
        if body.startswith('@'):continue
        if body.startswith('='):target.append(['output',expr(body[1:].strip())]);continue
        body=re.sub(r'//[^\n]*','',body).strip()
        body=re.sub(r'RequestWrapper\s+r\s*=\s*new RequestWrapper\(request\);','',body).strip()
        while body:
            if body.startswith('}'):
                if not stack:raise ValueError('Unbalanced closing block')
                target=stack[-1][0];node=stack.pop()[1];body=body[1:].strip()
                if body.startswith('else'):
                    body=body[4:].strip()
                    if body.startswith('{'):stack.append((target,node));target=node[3];body=body[1:].strip()
                    elif body.startswith('if'):stack.append((target,node));target=node[3]
                    else:raise ValueError('Malformed else')
                continue
            if body.startswith('if'):
                m=re.match(r'if\s*\((.*)\)\s*\{',body,re.S)
                if not m:raise ValueError('Malformed if: '+body[:100])
                node=['if',expr(m[1]),[],[]];target.append(node);stack.append((target,node));target=node[2];body=body[m.end():].strip();continue
            m=re.match(r'(?:String\s+)?([A-Za-z_]\w*)\s*=\s*(.*?);',body,re.S)
            if m:target.append(['set',m[1],expr(m[2])]);body=body[m.end():].strip();continue
            raise ValueError('Unsupported Java block: '+body[:120])
    if stack:raise ValueError('Unclosed block')
    return root

def main():
    DEST.mkdir(exist_ok=True)
    for source,target in [(SOURCE/'jsp/protocol_view',DEST/'views'),(SOURCE/'jsp/protocol_form',DEST/'forms'),(SOURCE/'WEB-INF/classes/researches',DEST/'definitions')]:
        target.mkdir(exist_ok=True)
        for p in source.iterdir() if source.exists() else []:
            if p.suffix in ['.jsp','.properties'] and not (target/p.name).exists():shutil.copyfile(p,target/p.name)
    db=sqlite3.connect(ROOT/'data/uzi.db');db.row_factory=sqlite3.Row
    def text(v):return v.decode('cp1251') if isinstance(v,bytes) else v
    book=[{k:text(v) for k,v in dict(row).items()} for row in db.execute('SELECT * FROM legacy_book')]
    dictionary={str(row['id']):row['name'] for row in book}
    roots={row['key_name'].lower():row for row in book if row['key_name']}
    versions={row['key_name'].split('.')[-1].lower():str(row['value']) for row in book if row['key_name'] and row['key_name'].startswith('CONFIG.VERSION.')}
    children={}
    for row in sorted(book,key=lambda r:(r['position'],r['id'])):children.setdefault(row['level_id'],[]).append(row)
    templates={};failures={};hashes={};catalog=json.loads((ROOT/'src/catalog.json').read_text(encoding='utf-8'))
    labels=json.loads((DEST/'labels.json').read_text(encoding='utf-8')) if (DEST/'labels.json').exists() else {}
    for path in (DEST/'views').glob('*.jsp'):
        key=path.stem.lower();hashes[key]=hashlib.sha256(path.read_bytes()).hexdigest()
        try:templates[key]=compile_template(path.read_text(encoding='cp1251'))
        except ValueError as e:failures[key]=str(e)
    for key,definitions in catalog.items():
        path=DEST/'definitions'/f'{key}.properties'
        # Source filenames differ in case; Windows lookup is case-insensitive.
        if not path.exists():continue
        metadata={}
        for line in path.read_text(encoding='latin1').splitlines():
            if '=' in line and not line.lstrip().startswith(('#','!')):
                name,value=line.split('=',1);parts=[p.strip() for p in value.split(',')];metadata[name.strip()]=parts
        code=key.rsplit('_',1)[0]
        source=(DEST/'forms'/f'{key}.jsp').read_text(encoding='cp1251') if (DEST/'forms'/f'{key}.jsp').exists() else ''
        existing={f['key']:f for f in definitions}
        ordered=[]
        for match in re.finditer(r'r\.(get\w*)\("([^"\n]+)"',source):
            method,name=match.groups()
            if name not in metadata or name in {'count','research'} or any(f['key']==name for f in ordered):continue
            field=existing.get(name,{'key':name,'label':name,'kind':method})
            before=source[max(0,match.start()-500):match.start()]
            before=re.sub(r'<%[^%]*$','',before)
            cell=re.split(r'<td\b[^>]*>',before,flags=re.I)[-1]
            cell=re.sub(r'<%.*?%>','',cell,flags=re.S)
            label=html.unescape(re.sub(r'<[^>]+>',' ',cell)).strip()
            label=re.sub(r'\s+',' ',label)
            row=re.split(r'<tr\b[^>]*>',before,flags=re.I)[-1]
            def plain(value):return re.sub(r'\s+',' ',html.unescape(re.sub(r'<[^>]+>',' ',re.sub(r'<%.*?%>','',value,flags=re.S)))).strip()
            if not label:
                candidates=[plain(value) for value in re.findall(r'<td\b[^>]*>(.*?)</td>',row,re.I|re.S)]
                label=next((value for value in reversed(candidates) if value and len(value)<100 and value not in ['мм','см','мл','%','г']), '')
            if not label:
                references=re.findall(r'r\.\w+\("([^"\n]+)"',row)
                for reference in reversed(references):
                    meta=metadata.get(reference,[])
                    if meta and meta[0] in ['select','checkbox']:
                        location=meta[1] if len(meta)>1 else reference
                        parent=roots.get(('CONFIG.PARAMS.'+code+'.'+location).lower())
                        if parent:label=parent['name']+': уточнение';break
            field['label']=label if label and len(label)<100 else name
            headings=re.findall(r'<b\b[^>]*>([^<]+)</b>',source[:match.start()],re.I)
            field['group']=next((plain(h).strip(':') for h in reversed(headings) if plain(h).strip(':').lower() not in ['размеры','контуры','структура','эхогенность'] and not plain(h).isdigit()),'')
            ordered.append(field)
        definitions[:]=ordered
        for field in definitions:
            meta=metadata.get(field['key'],['string']);field['valueType']=meta[0]
            if meta[0] in ['select','checkbox']:
                location=meta[1] if len(meta)>1 else field['key']
                parent=roots.get(('CONFIG.PARAMS.'+code+'.'+location).lower())
                options=([parent] if meta[0]=='checkbox' else children.get(parent['id'],[])) if parent else []
                field['options']=[{'label':o['name'],'value':str(o['id'])} for o in options]
                if parent and (field['label']==field['key'] or '<%' in field['label']):field['label']=parent['name']
        specific={
          'shit':{'r_dolya_1':'Правая доля: a (мм)','r_dolya_2':'Правая доля: b (мм)','r_dolya_3':'Правая доля: c (мм)','l_dolya_1':'Левая доля: a (мм)','l_dolya_2':'Левая доля: b (мм)','l_dolya_3':'Левая доля: c (мм)','v1':'V1 — объём правой доли','v2':'V2 — объём левой доли','sum':'Суммарный объём'},
          'eho_kg':{'kdr':'КДР (см)','ksr':'КСР (см)','kdo':'КДО (мл)','kso':'КСО (мл)','fv':'ФВ (%)','fy':'ФУ (%)','ydar_v':'Ударный объём (мл)','massa':'Масса миокарда (г)','mjld_tol':'Межжелудочковая перегородка: толщина (см)','zslj_tol':'Задняя стенка левого желудочка: толщина (см)'}
        }
        for field in definitions:
            if field['key'] in specific.get(code,{}):field['label']=specific[code][field['key']]
            if field['key'] in labels.get(code,{}):field['label']=labels[code][field['key']]
    (ROOT/'src/legacy-templates.json').write_text(json.dumps(templates,ensure_ascii=False,separators=(',',':')),encoding='utf-8')
    (ROOT/'src/legacy-dictionary.json').write_text(json.dumps(dictionary,ensure_ascii=False,separators=(',',':')),encoding='utf-8')
    (ROOT/'src/legacy-versions.json').write_text(json.dumps(versions,ensure_ascii=False,indent=2),encoding='utf-8')
    (ROOT/'src/catalog.json').write_text(json.dumps(catalog,ensure_ascii=False,indent=2),encoding='utf-8')
    report={'compiled':sorted(templates),'unsupported':failures,'source_sha256':hashes}
    (ROOT/'docs/template-compilation.json').write_text(json.dumps(report,ensure_ascii=False,indent=2),encoding='utf-8')
    print('Compiled:',len(templates),'Unsupported:',len(failures))
    for key in ['brooho_1','ginekol_1','ginekol_11','shit_1','moloch_1','pochki_1','eho_kg_1','eho_kg_2']:print(key,'OK' if key in templates else failures.get(key))

if __name__=='__main__':main()
