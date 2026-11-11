from pathlib import Path
import re,json,hashlib,sqlite3,struct,collections
ROOT=Path(__file__).resolve().parents[1]
OLD=Path('C:/Users/pumpu/Documents/Codex/2026-11-05/new-chat/outputs/UZI-test/webapps/uzi')
OUT=ROOT/'docs/parity-audit'
def read(p):return p.read_text(encoding='cp1251' if p.is_relative_to(OLD) else 'utf-8',errors='replace')
def digest(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def constants(p):
 b=p.read_bytes();n=struct.unpack_from('>H',b,8)[0];pos=10;i=1;out=[]
 while i<n:
  t=b[pos];pos+=1
  if t==1:
   l=struct.unpack_from('>H',b,pos)[0];pos+=2;out.append(b[pos:pos+l].decode('utf-8',errors='replace'));pos+=l
  elif t in (3,4):pos+=4
  elif t in (5,6):pos+=8;i+=1
  elif t in (7,8,16,19,20):pos+=2
  elif t in (9,10,11,12,17,18):pos+=4
  elif t==15:pos+=3
  else:raise ValueError(t)
  i+=1
 return out
files=[];definitions=collections.defaultdict(list)
for p in sorted(OLD.rglob('*')):
 if not p.is_file() or 'CVS' in p.parts:continue
 rel=p.relative_to(OLD).as_posix()
 if p.suffix not in ('.jsp','.php','.html','.class','.js'):continue
 if rel.startswith(('php/lib/','php/template/','php/img/','js/','WEB-INF/lib/')) or 'config.php' in rel:continue
 s=read(p) if p.suffix!='.class' else ''
 for m in re.finditer(r'function\s+(\w+)\s*\(',s):definitions[m[1]].append({'file':rel,'line':s[:m.start()].count('\n')+1})
 files.append({'file':rel,'sha256':digest(p),'lines':len(s.splitlines()) if s else None})
php_actions=[]
for rel in ['php/index.php','php/modules/statistic/index.php']:
 s=read(OLD/rel)
 for m in re.finditer(r"\$action\s*==\s*['\"]([^'\"]+)",s):php_actions.append({'action':m[1],'source':rel,'line':s[:m.start()].count('\n')+1})
commands=[]
for p in sorted((OLD/'WEB-INF/classes/my_pack/commands').glob('*.class')):
 cs=constants(p);commands.append({'command':p.stem,'source':p.relative_to(OLD).as_posix(),'views':[s for s in cs if s.endswith('.jsp')], 'sqlTables':sorted(set(t.lower() for s in cs for t in re.findall(r'\b(?:FROM|JOIN|UPDATE|INTO)\s+([a-z_]+)',s,re.I)))})
cat=json.loads((ROOT/'src/catalog.json').read_text(encoding='utf-8'));compiled=json.loads((ROOT/'src/legacy-templates.json').read_text(encoding='utf-8'));versions=json.loads((ROOT/'src/legacy-versions.json').read_text(encoding='utf-8'));oracle=json.loads((ROOT/'docs/template-parity.json').read_text(encoding='utf-8'))
c=sqlite3.connect('file:'+str(ROOT/'data/uzi.db').replace('\\','/')+'?mode=ro',uri=True)
configured=[]
for id,name,code in c.execute('SELECT * FROM templates'):
 hidden=c.execute('SELECT status_hidden FROM legacy_book WHERE id=?',[id]).fetchone()[0];key=code.lower()+'_'+versions.get(code.lower(),'1')
 configured.append({'id':id,'name':name,'code':code,'key':key,'sourceHidden':bool(hidden),'catalog':key in cat,'fields':len(cat.get(key,[])),'printSupported':key in compiled})
usage={str(code)+'_'+str(version):count for code,version,count in c.execute('SELECT lower(t.code),s.legacy_version,count(*) FROM studies s JOIN templates t ON t.id=s.template_id GROUP BY lower(t.code),s.legacy_version')}
forms=[]
keys=set(cat)|{p.stem.lower() for p in (OLD/'jsp/protocol_view').glob('*.jsp') if p.stem.lower() not in ('header','footer','header19092010','footer19092010','header николаеву','protocol','protocol19092010')}
for key in sorted(keys):
 fp=OLD/'jsp/protocol_form'/f'{key}.jsp';vp=OLD/'jsp/protocol_view'/f'{key}.jsp'
 s=read(fp) if fp.exists() else ''
 fields=set(re.findall(r'r\.(?:getSelect|getSizeInput|getCheckbox|getTextArea|getInput|getTextInput)\("([^"]+)"\)',s));actual={f['key'] for f in cat.get(key,[])}
 funcs=re.findall(r'function\s+(\w+)\s*\(',s)
 forms.append({'key':key,'form':fp.relative_to(OLD).as_posix() if fp.exists() else None,'view':vp.relative_to(OLD).as_posix() if vp.exists() else None,'catalog':key in cat,'sourceFieldCount':len(fields),'editorFieldCount':len(actual),'missingExtractedFields':sorted(fields-actual),'missingFieldSources':[{'key':keyname,'file':fp.relative_to(OLD).as_posix(),'line':s[:s.index('\"'+keyname+'\"')].count('\n')+1} for keyname in sorted(fields-actual)],'printSupported':key in compiled,'baselineRecords':usage.get(key,0),'historicalOracleSamples':oracle['byTemplate'].get(key,0),'javascriptFunctions':funcs,'currentDefaultFor':[v['id'] for v in configured if v['key']==key]})
screens=[]
for f in files:
 rel=f['file']
 if rel.endswith('.jsp') or (rel.endswith('.html') and (rel.startswith('php/html/') or rel.startswith('php/modules/')) or rel=='reference.html'):
  s=read(OLD/rel);screens.append({**f,'actions':sorted(set(re.findall(r"(?:setAction\(|action=)['\"]?([a-z_]+)",s))),'forms':len(re.findall(r'<form\b',s,re.I))})
facts={'date':'2026-11-08','oldRoot':str(OLD),'baselineDatabase':'data/uzi.db','baselineDatabaseSha256':digest(ROOT/'data/uzi.db'),'activeMenu':[{'id':r[0],'name':r[1].decode('cp1251') if isinstance(r[1],bytes) else r[1],'action':r[2].decode('cp1251') if isinstance(r[2],bytes) else r[2]} for r in c.execute('SELECT * FROM legacy_menu')],'legacyFusionSets':c.execute('SELECT count(*) FROM legacy_container').fetchone()[0],'legacyFusionLinks':c.execute('SELECT count(*) FROM legacy_research').fetchone()[0],'legacyStatuses':dict(c.execute('SELECT status,count(*) FROM legacy_protocol GROUP BY status')),'legacyPicturesDeclared':c.execute('SELECT count(*) FROM legacy_protocol WHERE jpg_amount>0').fetchone()[0],'legacyVideosDeclared':c.execute('SELECT count(*) FROM legacy_protocol WHERE avi_amount>0').fetchone()[0],'configuredTemplates':configured,'usedVersions':usage,'sourceFiles':len(files),'screenFiles':len(screens),'commands':len(commands),'phpActions':len(php_actions),'forms':len(forms),'printCompiled':len(compiled),'fieldCatalogVersions':len(cat)}
extra=[r[1] for r in c.execute('PRAGMA table_info(legacy_pacient)') if r[1] not in ['id','fio','gender','birthdate','city','street','house','flat','status_hidden']]
filled=collections.Counter()
for record in c.execute('SELECT '+','.join(extra)+' FROM legacy_pacient'):
    for key,value in zip(extra,record):
        if isinstance(value,bytes):value=value.decode('cp1251')
        if str(value or '').strip().lower() not in ('','null','none','0','0000-00-00'):filled[key]+=1
facts['filledExtraPatientFields']=dict(filled)
facts['emptyModuleTables']={t:c.execute('SELECT count(*) FROM '+t).fetchone()[0] for t in ['legacy_cabinets','legacy_lpu','legacy_lpu_doctor','legacy_price','legacy_price_name']}
facts['missingModuleTables']=[t for t in ['legacy_schedule','legacy_registration','legacy_pay','legacy_schet'] if not c.execute("SELECT count(*) FROM sqlite_master WHERE type='table' AND name=?",[t]).fetchone()[0]]
for name,obj in [('source-files.json',files),('screens.json',screens),('actions.json',php_actions),('java-commands.json',commands),('forms.json',forms),('facts.json',facts),('php-functions.json',dict(definitions))]:
 (OUT/name).write_text(json.dumps(obj,ensure_ascii=False,indent=2),encoding='utf-8')
print(json.dumps({k:v for k,v in facts.items() if k not in ['activeMenu','configuredTemplates','usedVersions']},ensure_ascii=False,indent=2))
print('missing fields',[(f['key'],f['missingExtractedFields']) for f in forms if f['missingExtractedFields']])
# Enrich the inventories with reviewed scenario coverage and render a standalone report.
import html,datetime
scenarios=json.loads((OUT/'scenarios.json').read_text(encoding='utf-8'))
scenarios.extend([
 dict(id='Z01',area='Служебные части',title='Общие шапки, подвал, ошибки, паспортная вставка',status='Служебное',priority='—',scope='Общие части экранов',old=[],new=[],note='Общие фрагменты не считаются отдельным пользовательским сценарием. Их функции сопоставляются с родительскими экранами.',acceptance='Проверить состав родительского экрана.',verification='Инвентаризация файлов'),
 dict(id='Z02',area='Служебные части',title='Тестовые/пробные JSP и базовые классы команд',status='Требует проверки',priority='—',scope='Технические артефакты архива',old=[],new=[],note='Наличие файла или класса само по себе не доказывает рабочий сценарий в установленном кабинете.',acceptance='Не включать в обязательную функциональность без подтверждения назначения.',verification='Инвентаризация файлов')
])
scenarios=list({s['id']:s for s in scenarios}.values())
byid={s['id']:s for s in scenarios}
command_map={'AddBookCommand':'D07','AddPacientCommand':'P03','Command':'Z02','DeleteFusionProtocolCommand':'F04','DeleteImageCommand':'F05','DeletePacientCommand':'P05','DeleteProtocolCommand':'S12','DoIdentifyCommand':'A01','EditBookCommand':'D07','FusionProtocolCommand':'F02','NotSavedCommand':'S11','NullCommand':'Z02','PrepareAddBookCommand':'D07','PrepareAddPacientCommand':'P03','PrepareChoiceResearchCommand':'S01','PrepareDoctorCommand':'A02','PrepareEditBookCommand':'D07','PrepareEditPacientCommand':'P04','PrepareEditProtocolCommand':'S14','PrepareIdentifyCommand':'A01','PrepareNotSavedCommand':'S11','PrepareResearchCommand':'S01','PrepareSearchPacientCommand':'P02','prepareViewFusionProtocolCommand':'F03','PrepareViewProtocolCommand':'F01','SaveAndPrintProtocolCommand':'S10','SaveEditPacientCommand':'P04','SaveProtocolCommand':'S10','SearchCommand':'P02','SelectResearchCommand':'S01','ViewAllPacientCommand':'P01','ViewAllProtocolCommand':'S13','ViewBookCommand':'D07'}
exact={
'main_menu':'P01','select_research':'S01','search_pacient':'P02','show_pacient_list':'P01','show_add_pacient':'P03','do_add_pacient':'P03','add_pacient':'P03','show_edit_pacient':'P04','save_edit_pacient':'P04','prepare_delete_pacient':'P05','do_delete_pacient':'P05',
'main_administration':'A03','edit_users':'A04','show_add_users':'A04','do_add_user':'A04','delete_user':'A04','show_edit_user_name':'A04','save_edit_user_name':'A04','edit_groups':'A03','show_add_groups':'A03','do_add_group':'A03','delete_group':'A03','show_edit_group_name':'A03','save_edit_group_name':'A03','edit_permits':'A03','save_edit_permits':'A03',
'update_book_users':'D10','prepare_edit_decision':'D01','show_add_decision':'D02','do_add_decision':'D02','edit_research_decision':'D03','do_save_edit_decision':'D03','delete_research_decision':'D03','set_position':'D06','main_research':'D08','prepare_create_research':'D08','create_research':'D08','prepare_edit_book':'D07','prepare_copy_replace_data':'D05','insert_records_book':'D05','edit_main_book_record':'D07','save_edit_book_record':'D07','main_research_user':'D01','prepare_edit_book_user':'D04','prepare_copy_replace_data_user':'D05','insert_records_book_user':'D05',
'prepare_otchet_vyrab':'R02','view_vyrabotka':'R02','prepare_research':'R01','view_research':'R01','prepare_decision':'R03','view_decision':'R03','prepare_napr_lpu':'R04','view_napr_lpu':'R04','prepare_z_otchet':'R05','show_zett_otchet':'R05','prepare_reg_records':'R05','view_reg_records':'R05',
'prepare_karta_pacient':'X04','karta_search_pacient':'X04','karta_user_card':'X04','karta_first_request':'X04','karta_zakl_list':'X04','karta_priviv_list':'X04','karta_control_posesch':'X04','do_add_control':'X04','do_save_edit_control':'X04','delete_control_pos':'X04','karta_stac_list':'X04','karta_invaz_list':'X04','karta_disp_list':'X04','karta_rentgen_list':'X04','karta_issled_list':'X04',
'get_price':'X03','do_add_prihod_rashod':'X03','prepare_document':'X03','choise_document':'X03','show_soglasen_document':'X03','show_otkaz_document':'X03','show_operaciya_document':'X03','prepare_pay':'X03','set_payed':'X03','print_karta':'P06','show_print_karta':'P06','prepare_line':'X03','print_line':'X03','main_dogovor':'X03','prepare_search_pacient_dogovor':'X03','search_pacient_dogovor':'X03','dogovor_pacient_info':'X03','show_create_contract':'X03','prepare_print_check':'X03','replace_temp_price':'X03','show_koresh_document_new':'X03','prinyat_numeraciu':'X03','show_protocols_reg_pacient':'X02','show_add_ambulance':'X02','save_registration':'X02','prepare_replace':'X02','delete_record':'X02','main_registratura':'X02','prepare_registration':'X02',
'edit_cabinets':'X01','show_add_cabinets':'X01','do_add_cabinet':'X01','delete_cabinet':'X01','show_lpu':'X01','add_lpu':'X01','save_edit_lpu':'X01','save_edit_lpu_doctor':'X01','add_lpu_doctor':'X01','delete_lpu_doctor':'X01','delete_lpu':'X01'}
def action_id(a):
 if a in exact:return exact[a]
 if 'schedule' in a:return 'X02'
 if a.startswith(('prepare_po_','preveiw_po_')):return 'R05'
 raise ValueError('Unclassified action '+a)
for a in php_actions:a['scenario']=action_id(a['action']);a['status']=byid[a['scenario']]['status']
for cmd in commands:cmd['scenario']=command_map[cmd['command']];cmd['status']=byid[cmd['scenario']]['status']
def screen_id(f):
 path=f['file'];name=Path(path).stem.lower()
 if path in ('reference.html','reference.jsp','jsp/proba.jsp'):return 'D11'
 if path.startswith('jsp/protocol_form/'):
  return 'Z01' if name in ('header','footer','passport_1') else 'S04' if name in ('brooho_1','pochki_1','ginekol_11') else 'S15'
 if path.startswith('jsp/protocol_view/'):
  return 'F02' if name.startswith('protocol') else 'Z01' if name.startswith(('header','footer')) else 'S15'
 if '/book/' in path:return 'D07'
 if '/search/' in path:return 'S13' if 'protocol' in name else 'P02'
 if path.startswith('jsp/'):
  return {'add_pacient':'P03','edit_pacient':'P04','find_pacient':'P02','fio_choice':'P02','view_all_pacient':'P01','view_all_protocol':'S13','identify':'A01','not_saved_research':'S11','prepare_protocol':'S01','select_research':'S01','choice_research':'S01','after_save_protocol':'S10','view_protocol':'F01','protocol':'Z02','proba':'Z02','view_proba':'Z02','menu':'P01','header':'Z01','footer':'Z01','line':'X03','error':'Z01','error_new':'Z01'}.get(name,'Z02')
 if '/administration/' in path:
  return 'A03' if any(s in name for s in ('group','permit','main_administration')) else 'A04' if 'user' in name else 'X01' if any(s in name for s in ('cabinet','lpu')) else 'Z01'
 if '/research_user/' in path:return 'D04' if name=='edit_main_book_record' else 'D05' if name=='edit_book_user' else 'D01'
 if '/research/' in path:return 'D08' if name in ('prepare_create_research','show_main_research') else 'D07'
 if '/statistic/' in path or '/statistic/' in path.replace('\\','/'):
  return 'R03' if 'decision' in name else 'R02' if 'vyrabotka' in name else 'R04' if 'napr_lpu' in name else 'R01' if 'research' in name else 'R05' if any(s in name for s in ('zett','reg_records')) else 'Z01' if name in ('header','footer') else 'R01'
 if '/tools/' in path:
  return 'P01' if name=='show_pacient_list' else 'P06' if name=='show_add_edit_pacient' else 'S01' if name=='select_research' else 'X03' if name=='show_add_prihod' else 'X02'
 if 'registration' in path:return 'X02'
 return 'Z02'
for f in screens:f['scenario']=screen_id(f);f['status']=byid[f['scenario']]['status'];f['scope']=byid[f['scenario']]['scope']
for name,obj in [('scenarios.json',scenarios),('screens.json',screens),('actions.json',php_actions),('java-commands.json',commands)]: (OUT/name).write_text(json.dumps(obj,ensure_ascii=False,indent=2),encoding='utf-8')
from html.parser import HTMLParser
class SurfaceParser(HTMLParser):
    def __init__(self,file):super().__init__(convert_charrefs=False);self.file=file;self.modals=[];self.buttons=[]
    def handle_starttag(self,tag,attrs):
        attrs=dict(attrs)
        if tag=='umodal':self.modals.append({'file':self.file,'line':self.getpos()[0],'title':attrs.get('title') or attrs.get(':title') or 'Без статического заголовка','state':attrs.get('v-model:open') or attrs.get(':open') or ''})
        if tag=='ubutton':self.buttons.append({'file':self.file,'line':self.getpos()[0],'action':attrs.get('@click') or ('submit '+attrs.get('form','') if attrs.get('type')=='submit' else ''),'label':attrs.get('aria-label') or attrs.get('title') or attrs.get('label') or ''})
new_modals=[];new_buttons=[]
for file in sorted((ROOT/'src').rglob('*.vue')):
    parser=SurfaceParser(file.relative_to(ROOT).as_posix());parser.feed(read(file));new_modals.extend(parser.modals);new_buttons.extend(parser.buttons)
new_routes=re.findall(r"path:\s*'([^']+)'",read(ROOT/'src/main.ts'))
(OUT/'new-surfaces.json').write_text(json.dumps({'routes':new_routes,'modals':new_modals,'buttons':new_buttons},ensure_ascii=False,indent=2),encoding='utf-8')
counts=collections.Counter(s['status'] for s in scenarios);p1=[s for s in scenarios if s['priority']=='P1']
validation={'oldScreenFilesClassified':len(screens),'phpActionsClassified':len(php_actions),'javaCommandsClassified':len(commands),'formVersionsListed':len(forms),'unclassifiedScreens':0,'unclassifiedActions':0,'baselineDatabaseUnchanged':digest(ROOT/'data/uzi.db')==facts['baselineDatabaseSha256'],'sourceFilesUnchanged':all(digest(OLD/f['file'])==f['sha256'] for f in files),'scenarioStatusCounts':dict(counts),'priority1Scenarios':[s['id'] for s in p1]}
(OUT/'coverage.json').write_text(json.dumps(validation,ensure_ascii=False,indent=2),encoding='utf-8')
def refsmd(items,old=False):
 base=OLD if old else ROOT
 return '<br>'.join(f"[{e['path']}:{e['line']}](<{(base/e['path']).as_posix()}:{e['line']}>)" for e in items) or '—'
def esc(s):return str(s).replace('|','\\|').replace('\n',' ')
intro=f'''# Сверка функциональности старой и новой программы УЗИ

Дата: 8 ноября 2026 года. **Полного функционального соответствия сейчас нет.**

Сверены {facts['sourceFiles']} файлов исходников и классов: {len(screens)} файлов экранов/шаблонов, {len(php_actions)} ветки действий PHP, {len(commands)} класса Java-команд и {len(forms)} версии форм. Это инвентаризация файлов и сценариев, а не заявление о прохождении всех комбинаций состояний. Общие шапки и подвалы включены в число шаблонов, но не считаются отдельными рабочими экранами.

**Как читать:** «Есть аналог» означает, что соответствующее действие найдено, но не обещает попиксельное или клиническое совпадение. Колонка проверки отдельно показывает, что проверено тестом, а что только по исходникам. «Нет» для архивного общего модуля не означает, что этот модуль использовался врачом.

**Охват установки.** В исходном меню три пункта: администрирование, пользовательский справочник, работа с видами исследований; JSP-интерфейс УЗИ имеет собственное меню. Регистратура, расписание, касса, полная амбулаторная карта и часть отчётности найдены в общем архиве, но не подтверждены как работавшие модули этого кабинета. Таблиц расписания/регистрации/оплаты в перенесённой базе нет, справочники кабинетов и ЛПУ пусты. Их нельзя ни молча обещать, ни автоматически исключить из будущего объёма.

**Метод и ограничения.** Старый сервер и всё оборудование в этой сверке не запускались. Выполнены статическое сопоставление, текущие 22 Rust-теста и 17 Vitest-тестов, проверка открытия новых экранов на вымышленных данных и повторная проверка цикла заготовки. Браузерные проверки с имитацией IPC проверяют UI, но не заменяют проверку настоящего exe с SQLite. Старые отчёты native-acceptance и сравнения текста используются только как историческое свидетельство. Рабочая база не изменялась.

## Исправить в первую очередь

'''
md=intro+'\n'.join(f"- **{s['id']} — {s['title']}.** {s['note']}" for s in p1)
md+='''

## Существенные цифры и выводы

- В 16 реально встречавшихся версиях сохранённых исследований исторически сравнивался итоговый текст на 1 189 записях без расхождений после нормализации пробелов. Это не проверка ввода всех полей, всех ветвей и всех сценариев.
- В рабочих формах найдены четыре отсутствующих элемента: `sel_vena` и `r_chash_size` в `brooho_1`, `r_chash_size` в `pochki_1`, вычисляемое `matka_ob` в `ginekol_11`. Поля подтверждены в исходных JSP, не только поиском по словам. Архивные значения могут показываться как дополнительные; в новой пустой форме заполнить их тем же способом нельзя.
- Из 187 версий в каталоге 174 поддерживаются печатным компилятором. Среди остальных есть 11 исходных печатных шаблонов с неподдерживаемыми конструкциями и две формы без самостоятельного печатного файла. Полный перечень приведён ниже.
- В исходной базе 5 объединений и 10 связей протоколов. Они сохранены в `legacy_*`, но не доступны как комплекты в новом интерфейсе.
- Из 15 импортированных видов два были скрыты (`478`, `1063`), а новая таблица видов не хранит этот признак. `1063 / BEREMEN2` дополнительно не имеет исходной формы в доступном архиве.
- Старый пользовательский справочник поддерживал не только CRUD текстов: вложенность, порядок, копирование и перенос. Новые CRUD текстов не закрывают эти сценарии.
- После согласованной очистки 5 070 пустых заготовок остаётся 41 исходное незавершённое исследование. Они не потеряны, но отдельного фильтра для их продолжения нет.
- Протоколов с заявленными старыми снимками/видео — 0. Поддержка новых вложений проверялась на синтетических файлах; перенос не доказывает интеграцию с аппаратом.

## Порядок закрытия пробелов

1. Восстановить поля и пройти все ветви рабочих форм; проверить тексты и расчёты на обезличенных примерах.
2. Восстановить доступ к старым объединениям и добавить безопасное удаление исследования/комплекта, список черновиков.
3. Закрыть сценарии справочника: разделы, вложенность, перемещение/копирование, порядок. Отдельно — базовый справочник вариантов и управление видами.
4. Сохранить скрытие видов и согласовать ограничения по полу/версиям.
5. Согласовать необходимый объём статистики, ролей, общих административных и клинических модулей.
6. Пройти приёмку с врачом: один чек-лист на каждый используемый вид, печать на целевом принтере, реальные файлы с аппарата.

Исправления в программе в рамках этой сверки не вносились: это зафиксированный список работ. Для каждой строки ниже указан критерий приёмки, чтобы следующая проверка не сводилась к «экран открывается».

## Матрица сценариев

| ID | Область / сценарий | Статус / приоритет | Где было | Где сейчас | Различие и проверка |
| --- | --- | --- | --- | --- | --- |
'''
for s in scenarios:md+=f"| {s['id']} | {esc(s['area'])}: **{esc(s['title'])}**<br>{esc(s['scope'])} | {s['status']} / {s['priority']} | {refsmd(s['old'],True)} | {refsmd(s['new'])} | {esc(s['note'])}<br>**Проверка:** {esc(s['verification'])}.<br>**Приёмка:** {esc(s['acceptance'])} |\n"
md+='\n## Виды исследований текущего кабинета\n\n| ID | Название | Новая версия | Скрыт в старой | Поля / печать |\n| --- | --- | --- | --- | --- |\n'
for t in configured:md+=f"| {t['id']} | {t['name']} | {t['key']} | {'да' if t['sourceHidden'] else 'нет'} | {t['fields']} / {'есть' if t['printSupported'] else 'нет'} |\n"
md+='\n## Реестр всех версий форм\n\nНаличие каталога или скомпилированного шаблона не подтверждает интерактивную эквивалентность. «Пропуски» — сравнение прямых вызовов полей; для рабочих форм S04 проверены строки JSP. Для остальных это кандидаты на ручную проверку. `passport_1` — общая вставка. Число записей относится к исходному набору до очистки.\n\n| Версия | Поля в каталоге | Печать | Записей / исторических образцов | Пропуски прямых полей | JS-функций в оригинале |\n| --- | --- | --- | --- | --- | --- |\n'
for f in forms:md+=f"| {f['key']} | {f['editorFieldCount']} | {'есть' if f['printSupported'] else 'нет'} | {f['baselineRecords']} / {f['historicalOracleSamples']} | {', '.join(f['missingExtractedFields']) or '—'} | {len(f['javascriptFunctions'])} |\n"
md+='\n## Каждый исходный экран/шаблон\n\nПолный индекс, включая общие фрагменты и архивные формы. Привязка к сценарию обозначает область проверки, а не успешный динамический проход каждого файла.\n\n| Файл | Сценарий | Статус области | Контекст |\n| --- | --- | --- | --- |\n'
for f in screens:md+=f"| {f['file']} | {f['scenario']} | {f['status']} | {f['scope']} |\n"
md+='\n## Новые маршруты и диалоги\n\nОткрытие основных маршрутов проверено на вымышленных данных. Ниже — также полный список объявленных диалогов; не все их состояния прошли динамическую приёмку.\n\nМаршруты: '+', '.join('`'+r+'`' for r in new_routes)+'.\n\n| Файл:строка | Диалог | Состояние |\n| --- | --- | --- |\n'
for dialog in new_modals:md+=f"| {dialog['file']}:{dialog['line']} | {esc(dialog['title'])} | {esc(dialog['state'])} |\n"
md+='\n## Каждая PHP-ветка действия\n\nВетка диспетчера подтверждает наличие маршрута в коде; не гарантирует наличие всех зависимостей или фактическое использование.\n\n| Диспетчер:строка | Действие | Сценарий | Статус области |\n| --- | --- | --- | --- |\n'
for a in php_actions:md+=f"| {a['source']}:{a['line']} | {a['action']} | {a['scenario']} | {a['status']} |\n"
md+='\n## Каждый класс Java-команды\n\n| Класс | Сценарий | Статус области |\n| --- | --- | --- |\n'
for a in commands:md+=f"| {a['command']} | {a['scenario']} | {a['status']} |\n"
md+='''
## Доказательства и актуальность проверок

- `current-tests.json`: текущие запуски Vitest и Rust; отдельные тесты не означают весь функциональный паритет.
- `current-ui-check.json`: открытие экранов с имитацией IPC; `current-template-cycle.json`: создание/вставка/правка/удаление/восстановление заготовки в том же режиме.
- `coverage.json`: полнота классификации индексов и проверка неизменности исходников и исходной базы.
- `source-files.json`: перечень и SHA-256 файлов; `screens.json`, `actions.json`, `java-commands.json`, `forms.json`, `facts.json`, `scenarios.json`: полные машиночитаемые индексы.
- `../template-parity.json`: историческая выборка печатного текста. Она не проверяет редактор.
- `../forms-native-check.json` и часть прежних отчётов содержат старый признак `finalizationBlockedUntilRecalculation=true`. После согласованного снятия блокировки он устарел и не принимается как актуальная проверка поведения.
- `../native-acceptance.json`: исторические испытания настоящего exe на синтетических данных; не свежая приёмка всех последующих изменений.

Полное соответствие можно подтвердить только после закрытия пропусков и прохождения приёмочных сценариев. Текущий итог — **полного паритета нет**, список известных различий зафиксирован.
'''
(OUT/'REPORT.md').write_text(md,encoding='utf-8')
# HTML report: native controls, local-only data, no external dependencies.
def H(x):return html.escape(str(x))
def code_refs(items):return '<br>'.join(f"<code>{H(e['path'])}:{e['line']}</code>" for e in items) or '—'
def table(headers,rows):return '<table><thead><tr>'+''.join('<th>'+H(h)+'</th>' for h in headers)+'</tr></thead><tbody>'+''.join('<tr>'+''.join('<td>'+c+'</td>' for c in row)+'</tr>' for row in rows)+'</tbody></table>'
parts=[]
parts.append('<section><h2>Что исправить сначала</h2><ol>'+''.join('<li><b>'+H(s['id']+' · '+s['title'])+'</b><p>'+H(s['note'])+'</p></li>' for s in p1)+'</ol></section>')
parts.append('<section id="matrix"><h2>Сценарии</h2><div class="filters"><label>Поиск <input id="search" placeholder="Например: справочник, печать, S04"></label><label>Статус <select id="status"><option value="">Все</option>'+''.join('<option>'+H(k)+'</option>' for k in counts)+'</select></label><label>Приоритет <select id="priority"><option value="">Все</option><option>P1</option><option>P2</option><option>P3</option></select></label><span id="found" role="status"></span></div><div class="scenario-list">')
for s in scenarios:
 parts.append(f'<article class="scenario" data-status="{H(s["status"])}" data-priority="{s["priority"]}"><div class="scenario-head"><b>{s["id"]} · {H(s["title"])}</b><span>{H(s["status"])} · {s["priority"]}</span></div><p class="scope">{H(s["area"])} · {H(s["scope"])}</p><p>{H(s["note"])}</p><p><b>Доказательство:</b> {H(s["verification"])}</p><p><b>Критерий приёмки:</b> {H(s["acceptance"])}</p><details><summary>Где в исходниках</summary><div class="refs"><div><b>Старая система</b><p>{code_refs(s["old"])}</p></div><div><b>Новая программа</b><p>{code_refs(s["new"])}</p></div></div></details></article>')
parts.append('</div></section>')
parts.append('<section><h2>Текущие виды исследований</h2>'+table(['ID','Название','Версия','Раньше скрыт','Поля / печать'],[[str(t['id']),H(t['name']),H(t['key']),'Да' if t['sourceHidden'] else 'Нет',str(t['fields'])+' / '+('Есть' if t['printSupported'] else 'Нет')] for t in configured])+'</section>')
parts.append('<section><h2>Все версии форм</h2><p>Печать означает поддержку синтаксиса, а не полную проверку редактора. Поля сравнивались автоматически; найденные пропуски рабочих форм проверены вручную в JSP. Полный индекс содержит пути и список JS-функций в forms.json.</p>'+table(['Версия','Полей','Печать','Исходных записей','Образцов текста','Пропущенные поля'],[[H(f['key']),str(f['editorFieldCount']),'Есть' if f['printSupported'] else 'Нет',str(f['baselineRecords']),str(f['historicalOracleSamples']),H(', '.join(f['missingExtractedFields']) or '—')] for f in forms])+'</section>')
parts.append('<section><h2>Новые маршруты и диалоги</h2><p>Маршруты: '+H(', '.join(new_routes))+'. Полный список диалогов ниже; открытие основного экрана не доказывает все состояния его диалогов.</p><details><summary>Диалоги новой программы: '+str(len(new_modals))+'</summary>'+table(['Источник','Диалог','Состояние'],[[H(d['file'])+':'+str(d['line']),H(d['title']),H(d['state'])] for d in new_modals])+'</details></section>')
parts.append('<section><h2>Полный индекс экранов и действий</h2><p>Это файлы экранов/шаблонов, включая служебные вставки; не число самостоятельных рабочих окон. Общий статус относится к связанному сценарию, а не к динамическому прохождению каждого файла.</p><details><summary>Все '+str(len(screens))+' файлов экранов и шаблонов</summary>'+table(['Файл','Сценарий','Статус области'],[[H(f['file']),f['scenario'],H(f['status'])] for f in screens])+'</details><details><summary>Все '+str(len(php_actions))+' ветки PHP</summary>'+table(['Источник','Действие','Сценарий'],[[H(a['source'])+':'+str(a['line']),H(a['action']),a['scenario']] for a in php_actions])+'</details><details><summary>Все '+str(len(commands))+' класса Java-команд</summary>'+table(['Класс','Сценарий'],[[H(a['command']),a['scenario']] for a in commands])+'</details></section>')
page='''<!doctype html><html lang="ru"><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Сверка старой и новой программы УЗИ</title><style>
*{box-sizing:border-box}body{font:15px/1.65 "Segoe UI",Arial,sans-serif;color:#253449;background:#f5f7fa;margin:0}main{max-width:1200px;margin:auto;padding:36px 28px 80px}h1{font-size:30px;line-height:1.2;margin:0 0 12px}h2{font-size:22px;margin:0 0 18px}p{margin:8px 0}section{margin-top:34px}a{color:#0f766e}header,article{background:#fff;border:1px solid #dfe6ed;border-radius:10px;padding:22px}.verdict{font-weight:650;color:#9f3b20;font-size:20px}.lead{font-size:17px}.meta,.scope{color:#647287}.stats{display:flex;gap:12px;flex-wrap:wrap;margin:20px 0}.stats>span{background:#e7f3f0;padding:10px 16px;border-radius:6px}.filters{display:flex;gap:16px;align-items:end;flex-wrap:wrap;margin-bottom:20px}.filters label{display:grid;gap:6px;min-width:0;max-width:100%}input,select{height:44px;border:1px solid #b9c5d1;border-radius:6px;padding:0 12px;font:inherit;max-width:100%}input{width:360px}table{width:100%;border-collapse:collapse;font-size:14px;background:white}td,th{padding:10px 12px;border:1px solid #dfe6ed;text-align:left;vertical-align:top;overflow-wrap:anywhere}th{background:#edf3f4}details{margin-top:12px}summary{cursor:pointer;color:#0f766e;padding:8px 0;font-weight:600}.scenario-list{display:grid;gap:12px}.scenario-head{display:flex;justify-content:space-between;gap:18px;flex-wrap:wrap}.scenario-head>span{color:#526176}.refs{display:grid;grid-template-columns:1fr 1fr;gap:24px}code{font-size:13px;overflow-wrap:anywhere}li{margin-bottom:16px}li p{margin:4px 0}.notice{padding:16px 20px;background:#fff4df;border-inline-start:4px solid #b7791f;margin:20px 0}.hidden{display:none}@media(max-width:650px){main{padding:24px 16px}header,article{padding:16px}.refs{grid-template-columns:1fr}h1{font-size:25px}table{font-size:12px}td,th{padding:7px}}@media print{body{background:white}main{max-width:none;padding:0}.filters{display:none}article{break-inside:avoid}details{display:block}}
</style><main><header><p class="meta">8 ноября 2026 · функциональная сверка</p><h1>Старая и новая программа УЗИ</h1><p class="verdict">Полного соответствия сейчас нет</p><p class="lead">Найдены пропуски в рабочих формах, управлении справочниками, удалении исследований и доступе к старым объединениям.</p><div class="stats">'''+''.join('<span><b>'+str(n)+'</b> '+H(t)+'</span>' for n,t in [(len(scenarios),'сценария / служебных групп'),(len(screens),'файлов экранов'),(len(php_actions),'PHP-действия'),(len(commands),'Java-команды'),(len(forms),'версий форм')])+'''</div><p>«Есть аналог» не означает полного совпадения. Для каждого сценария отдельно указаны различия, уровень доказательства и критерий приёмки.</p><p>Старая установка состоит из JSP-интерфейса УЗИ и PHP-модулей. В основном меню PHP только три пункта. Часть общего архива — регистратура, касса, расписание, полная амбулаторная карта — не подтверждена как работавшая в этом кабинете; нужных таблиц в перенесённой базе нет.</p><div class="notice"><b>Границы проверки.</b> Проведены инвентаризация и статическая сверка, текущие 22 Rust- и 17 Vitest-тестов, открытие экранов и сценарии заготовок на вымышленных данных. UI-проверки с имитацией IPC не заменяют native-приёмку с SQLite. Все состояния 187 форм, старый сервер, принтер и аппарат не запускались. Рабочая база не изменялась.</div><p><a href="#matrix">Перейти к матрице</a> · <a href="REPORT.md">Полный текстовый отчёт</a> · <a href="coverage.json">Контроль охвата</a></p></header>'''+''.join(parts)+'''<section><h2>Следующие шаги</h2><ol><li>Восстановить недостающие поля и пройти ветви рабочих форм.</li><li>Открыть старые объединения, добавить удаление исследований/комплектов и список черновиков.</li><li>Закрыть управление деревом справочника, порядком и переносом; отдельно — базовыми вариантами и видами исследований.</li><li>Сохранить скрытие видов и согласовать роли, ограничения и нужную отчётность.</li><li>Пройти приёмку с врачом на целевом компьютере и принтере.</li></ol><p>Исправления программы в рамках этой сверки не вносились. Это список работ и проверок.</p><p>Исторический forms-native-check.json содержит устаревшее требование обязательного пересчёта. Оно уже снято; прежний отчёт нельзя считать актуальной приёмкой. Сравнение текста 1 189 исследований в 16 версиях также не доказывает полноту экранов ввода.</p><p>Исходные файлы и базовый снимок базы проверены на неизменность. Все индексы и текущие результаты проверок лежат рядом с этим отчётом.</p></section></main><script>
const search=document.querySelector('#search'),status=document.querySelector('#status'),priority=document.querySelector('#priority'),cards=[...document.querySelectorAll('.scenario')];function filter(){const q=search.value.trim().toLocaleLowerCase('ru');let shown=0;for(const c of cards){const show=(!q||c.textContent.toLocaleLowerCase('ru').includes(q))&&(!status.value||c.dataset.status===status.value)&&(!priority.value||c.dataset.priority===priority.value);c.classList.toggle('hidden',!show);if(show)shown++}document.querySelector('#found').textContent='Показано: '+shown+' из '+cards.length}for(const el of [search,status,priority])el.addEventListener('input',filter);filter();
</script></html>'''
(OUT/'report.html').write_text(page,encoding='utf-8')
print('Report:',len(scenarios),'scenarios;',len(p1),'P1;',dict(counts))
