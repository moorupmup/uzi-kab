from pathlib import Path
import json,hashlib
root=Path(__file__).resolve().parents[1];read=lambda p:json.loads((root/p).read_text(encoding='utf-8-sig'));sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
rows=read('docs/parity-audit/scenario-verification.json');assert len(rows)==64
for row in rows:
 for e in row['evidence']:assert (root/'docs/parity-audit'/e).exists(),e
assert read('package.json')['version']==read('src-tauri/tauri.conf.json')['version']=='1.1.0'
scope=read('docs/parity-scope-native.json');manifest=read('docs/parity-package.json');folder=root/'release/Кабинет УЗИ';assert sha(folder/'Кабинет УЗИ — новая версия.exe')==scope['exeSha256']==manifest['exeSha256'].lower()
for f in manifest['files']:assert sha(folder/f['name'])==f['sha256'].lower()
manual=(root/'docs/Инструкция для врача.html').read_text(encoding='utf-8');assert '21. Памятка' in manual and 'Группы заключений' not in manual and 'Указать группу для отчёта' not in manual
assert (folder/'Кабинет УЗИ v1.0.exe').exists()
assert manifest['workingDatabaseUnchanged'] and manifest['existingReleaseDatabasePreserved']
result={'version':'1.1.0','scenariosWithExistingEvidence':len(rows),'versionConsistent':True,'packagedExeMatchesNativeTestedExe':True,'allPackagedHashesMatch':True,'manualSections':21,'previousExePreserved':True,'workingDatabaseUnchangedDuringPackaging':True,'existingReleaseDatabasePreserved':True,'externalClinicalAndHardwareAcceptancePending':True}
(root/'docs/parity-release-verification.json').write_text(json.dumps(result,ensure_ascii=False,indent=2),encoding='utf-8');print(json.dumps(result,ensure_ascii=False,indent=2))
