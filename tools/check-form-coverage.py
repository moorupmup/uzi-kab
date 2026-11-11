"""Read-only inventory of every legacy form/version; never exports patient fields."""
import argparse, collections, hashlib, json, sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
p=argparse.ArgumentParser();p.add_argument('--database',required=True);args=p.parse_args()
db=Path(args.database).resolve();before=hashlib.sha256(db.read_bytes()).hexdigest()
c=sqlite3.connect(db.as_uri()+'?mode=ro',uri=True)
usage=dict(c.execute("SELECT lower(t.code)||'_'||s.legacy_version,count(*) FROM studies s JOIN templates t ON t.id=s.template_id WHERE s.origin='legacy' GROUP BY lower(t.code),s.legacy_version"));c.close()
read=lambda name:json.loads((ROOT/name).read_text(encoding='utf-8'))
old=read('docs/parity-audit/forms.json');catalog=read('src/catalog.json');printed=read('src/legacy-templates.json');conditions=read('src/editor-conditions.json');oracle=read('docs/template-parity.json');defaults=read('src/legacy-versions.json')
result=[]
for f in old:
 key=f['key'];fields={d['key'] for d in catalog.get(key,[])};source_form=ROOT/'legacy/forms'/Path(f['form'] or '__missing').name;source_view=ROOT/'legacy/views'/Path(f['view'] or '__missing').name
 missing=[k for k in f['missingExtractedFields'] if k not in fields]
 used=usage.get(key,0);ready=key in printed and key in conditions and not missing
 result.append({'key':key,'archiveRecords':used,'editorFields':len(fields),'missingKnownSourceFields':missing,'printAst':key in printed,'editorConditions':key in conditions,'historicalJspOracleSamples':oracle.get('byTemplate',{}).get(key,0),'defaultForNew':key in [code+'_'+version for code,version in defaults.items()],'sourceForm':f['form'],'sourcePrint':f['view'],'sourceFormSha256':hashlib.sha256(source_form.read_bytes()).hexdigest() if source_form.exists() else None,'sourcePrintSha256':hashlib.sha256(source_view.read_bytes()).hexdigest() if source_view.exists() else None,'status':'archive_used_technical_coverage' if used and ready else 'archive_used_gap' if used else 'no_archive_use_scope_unconfirmed','clinicalAcceptance':'pending'})
unknown=set(usage)-{f['key'] for f in old};after=hashlib.sha256(db.read_bytes()).hexdigest()
summary={'forms':len(result),'archiveVersions':sum(f['archiveRecords']>0 for f in result),'archiveRecords':sum(usage.values()),'usedTechnicalGaps':[f['key'] for f in result if f['status']=='archive_used_gap'],'unknownArchiveVersions':sorted(unknown),'noArchiveUseScopeUnconfirmed':sum(f['archiveRecords']==0 for f in result),'sourceDatabaseSha256Unchanged':before==after,'clinicalAcceptancePending':True,'note':'No archive records is evidence of no use in this archive, not proof that a form is unnecessary. Oracle checks printed text, not physician acceptance.'}
(ROOT/'docs/parity-audit/form-verification.json').write_text(json.dumps({'summary':summary,'forms':result},ensure_ascii=False,indent=2),encoding='utf-8')
lines=['# Проверка 187 версий форм','', 'Дата: 9 ноября 2026 года. Источник использования — отдельная копия архива после согласованного удаления пустых заготовок. Личные сведения в ведомость не выгружаются.','', 'Отсутствие записей не означает отказ от переноса. Для таких форм назначение и необходимость остаются неподтверждёнными. Техническое покрытие используемых форм не заменяет врачебную приёмку.','', '| Версия | Записей | Полей | Печать | Условия редактора | Сравнений с JSP | Результат |','| --- | ---: | ---: | --- | --- | ---: | --- |']
for f in result:lines.append(f"| {f['key']} | {f['archiveRecords']} | {f['editorFields']} | {'есть' if f['printAst'] else 'нет'} | {'есть' if f['editorConditions'] else 'не перенесены'} | {f['historicalJspOracleSamples']} | {'Архив: технически покрыта, приёмка врача открыта' if f['status']=='archive_used_technical_coverage' else 'Пробел используемой формы' if f['archiveRecords'] else 'В архиве не использовалась; объём не подтверждён'} |")
(ROOT/'docs/parity-audit/FORM-VERIFICATION.md').write_text('\n'.join(lines)+'\n',encoding='utf-8')
print(json.dumps(summary,ensure_ascii=False,indent=2))
if unknown or summary['usedTechnicalGaps'] or before!=after:raise SystemExit(1)
