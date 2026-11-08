import re,json,sqlite3,random,zipfile
from pathlib import Path
root=Path.cwd(); old=Path(r'C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test')
work=root/'.tools/oracle';work.mkdir(exist_ok=True)
for jar in (old/'resin/lib').glob('*.jar'):
 with zipfile.ZipFile(jar) as z:
  if 'javax/servlet/http/HttpServletRequest.class' in z.namelist():print('SERVLET',jar.name)
c=sqlite3.connect('data/uzi.db');c.row_factory=sqlite3.Row
compiled=json.loads((root/'src/legacy-templates.json').read_text(encoding='utf-8'));dictionary=json.loads((root/'src/legacy-dictionary.json').read_text(encoding='utf-8'))
keys=[];cases=[]
for row in c.execute('SELECT DISTINCT lower(t.code)||\'_\'||s.legacy_version AS key FROM studies s JOIN templates t ON t.id=s.template_id'):
 key=row['key']
 if key not in compiled:continue
 keys.append(key)
 rows=c.execute('SELECT s.fields_json FROM studies s JOIN templates t ON t.id=s.template_id WHERE lower(t.code)||\'_\'||s.legacy_version=? ORDER BY s.id',(key,)).fetchall()
 chosen=random.Random(741).sample(rows,min(100,len(rows)))
 for r in chosen:
  f=json.loads(r[0]); values={}
  for k,v in f.items():values[k]=dictionary.get(v['value'],'' if v['value']=='0' else v['value']) if v['type'] in ['select','checkbox'] else v['value']
  n=len(cases); cases.append({'key':key,'fields':f,'file':str(n)})
  def escape(s):return ''.join('\\u%04x'%ord(ch) for ch in s)
  (work/f'{n}.properties').write_text('\n'.join(escape(k)+'='+escape(v) for k,v in values.items()),encoding='ascii')
methods=[]
for key in keys:
 source=(root/'legacy/views'/f'{key}.jsp').read_text(encoding='cp1251');chunks=[]
 for token in re.split(r'(<%.*?%>)',source,flags=re.S):
  if not token:continue
  if not token.startswith('<%'):chunks.append('out.append('+json.dumps(token,ensure_ascii=True)+');')
  elif token.startswith('<%@'):continue
  elif token.startswith('<%='):chunks.append('out.append(String.valueOf('+token[3:-2].strip()+'));')
  else:
   code=re.sub(r'RequestWrapper\s+r\s*=\s*new RequestWrapper\(request\);','',token[2:-2]);chunks.append(code+'\n')
 methods.append('static String render_'+key+'(RequestWrapper r) throws Exception { StringBuilder out=new StringBuilder();\n'+'\n'.join(chunks)+'\nreturn out.toString();}')
java='''import java.io.*; import java.util.*; import java.lang.reflect.*; import javax.servlet.http.HttpServletRequest; import my_pack.tools.RequestWrapper;
public class LegacyOracle {\n'''+ '\n'.join(methods)+'''
public static void main(String[] args) throws Exception { BufferedReader list=new BufferedReader(new InputStreamReader(new FileInputStream(args[0]),"UTF-8")); String line; while((line=list.readLine())!=null){String[] parts=line.split("\\t");final Properties props=new Properties();FileInputStream input=new FileInputStream(args[1]+"/"+parts[1]+".properties");props.load(input);input.close();HttpServletRequest request=(HttpServletRequest)Proxy.newProxyInstance(LegacyOracle.class.getClassLoader(),new Class[]{HttpServletRequest.class},new InvocationHandler(){public Object invoke(Object p,Method m,Object[] a){if(m.getName().equals("getAttribute")||m.getName().equals("getParameter"))return props.getProperty((String)a[0]);return null;}});RequestWrapper r=new RequestWrapper(request);String result=(String)LegacyOracle.class.getDeclaredMethod("render_"+parts[0],RequestWrapper.class).invoke(null,r);Writer output=new OutputStreamWriter(new FileOutputStream(args[1]+"/"+parts[1]+".html"),"UTF-8");output.write(result);output.close();}list.close();}}
'''
(work/'LegacyOracle.java').write_text(java,encoding='utf-8');(work/'manifest.tsv').write_text('\n'.join(v['key']+'\t'+v['file'] for v in cases),encoding='utf-8');(work/'cases.json').write_text(json.dumps(cases,ensure_ascii=False),encoding='utf-8');print('CASES',len(cases),'TEMPLATES',len(keys))
