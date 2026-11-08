"""One-way, read-only import from the recovered MySQL copy. Never overwrites a database."""
import argparse, datetime, decimal, hashlib, html, json, re, sqlite3, sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / '.tools/python'))
import pymysql

ROOT = Path(__file__).resolve().parents[1]

def text(v):
    if isinstance(v, bytes):
        return v.decode('cp1251', errors='strict')
    return '' if v is None else str(v)

def fields(blob):
    source = text(blob)
    result = {}
    for item in re.findall(r'<item>(.*?)</item>', source, re.S):
        def tag(name):
            m = re.search(fr'<{name}>(.*?)</{name}>', item, re.S)
            return html.unescape(m.group(1)) if m else ''
        result[tag('name')] = {'value': tag('value'), 'type': tag('type')}
    return result

def scalar(v):
    if isinstance(v, (datetime.date, datetime.datetime, decimal.Decimal)):
        return str(v)
    return v

def main():
    p = argparse.ArgumentParser()
    p.add_argument('--port', type=int, default=13307)
    p.add_argument('--output', type=Path, default=ROOT/'data/uzi.db')
    args = p.parse_args()
    if args.output.exists():
        raise SystemExit('Refusing to overwrite an existing database')
    src = pymysql.connect(host='127.0.0.1', port=args.port, user='root', database='vashdoctor', charset='latin1', use_unicode=False)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    temporary = args.output.with_suffix('.importing')
    if temporary.exists(): raise SystemExit('Unfinished import exists; inspect it first')
    dst = sqlite3.connect(temporary)
    report = {'tables': {}, 'decoded_protocols': 0, 'unparsed_protocols': 0}
    with dst:
        with src.cursor() as c:
            c.execute('SHOW TABLES')
            tables = [text(r[0]) for r in c.fetchall()]
            for table in tables:
                if not re.fullmatch('[a-zA-Z_0-9]+', table): raise ValueError('Unsafe table name')
                c.execute(f'SELECT * FROM `{table}`')
                columns = [d[0] for d in c.description]
                quoted = ','.join('"'+v+'"' for v in columns)
                dst.execute(f'CREATE TABLE "legacy_{table}" ({quoted})')
                count = 0
                digest = hashlib.sha256()
                for row in c:
                    values = tuple(scalar(v) for v in row)
                    dst.execute(f'INSERT INTO "legacy_{table}" VALUES ({",".join("?" for _ in values)})', values)
                    for v in values:
                        raw = v if isinstance(v,bytes) else repr(v).encode()
                        digest.update(len(raw).to_bytes(8,'big')); digest.update(raw)
                    count += 1
                report['tables'][table] = {'rows':count,'sha256':digest.hexdigest()}
                print(table, count, flush=True)
        dst.executescript((ROOT/'src-tauri/schema.sql').read_text(encoding='utf-8'))
        dst.row_factory = sqlite3.Row
        for row in dst.execute('SELECT * FROM legacy_pacient').fetchall():
            name=text(row['fio'])
            dst.execute('INSERT INTO patients(id,name,search_name,gender,birthdate,city,street,house,flat,hidden) VALUES(?,?,?,?,?,?,?,?,?,?)',
                        (row['id'],name,name.casefold().replace('ё','е'),text(row['gender']),text(row['birthdate']),text(row['city']),text(row['street']),text(row['house']),text(row['flat']),int(text(row['status_hidden']) or 0)))
        for row in dst.execute('SELECT * FROM legacy_users').fetchall():
            dst.execute('INSERT INTO doctors VALUES(?,?,?)',(row['id'],text(row['name']),int(text(row['status_hidden']) or 0)))
        for row in dst.execute('SELECT * FROM legacy_book WHERE level_id=2').fetchall():
            dst.execute('INSERT INTO templates VALUES(?,?,?)',(row['id'],text(row['name']),text(row['value'])))
        names={r['id']:r['name'] for r in dst.execute('SELECT * FROM templates')}
        for row in dst.execute('SELECT * FROM legacy_protocol').fetchall():
            parsed=fields(row['var_part'])
            report['decoded_protocols' if parsed or not row['var_part'] else 'unparsed_protocols']+=1
            dst.execute('INSERT INTO studies(id,patient_id,date,template_id,doctor_id,title,conclusion,addition,fields_json,legacy_version,origin,status) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)',
                        (row['id'],row['pacient_id'],text(row['date_end']),row['research_id'],row['doctor_id'],names.get(row['research_id'],f"Исследование {row['research_id']}"),text(row['decision_text']),text(row['addition']),json.dumps(parsed,ensure_ascii=False),text(row['version']),'legacy',f"legacy:{row['status']}"))
        report['orphan_studies']=dst.execute('SELECT count(*) FROM studies s LEFT JOIN patients p ON p.id=s.patient_id WHERE p.id IS NULL').fetchone()[0]
        report['integrity_check']=dst.execute('PRAGMA integrity_check').fetchone()[0]
        dst.execute('INSERT INTO metadata VALUES(?,?)',('migration',json.dumps(report,ensure_ascii=False)))
        dst.execute('PRAGMA user_version=1')
    # Byte-for-byte verification of each preserved source table, including BLOBs.
    for table, expected in report['tables'].items():
        digest=hashlib.sha256(); count=0
        for row in dst.execute(f'SELECT * FROM "legacy_{table}"'):
            for v in row:
                raw=v if isinstance(v,bytes) else repr(v).encode()
                digest.update(len(raw).to_bytes(8,'big')); digest.update(raw)
            count+=1
        if digest.hexdigest()!=expected['sha256'] or count!=expected['rows']: raise ValueError('Verification failed: '+table)
    dst.close(); src.close()
    temporary.rename(args.output)
    (ROOT/'docs/migration-report.json').write_text(json.dumps(report,ensure_ascii=False,indent=2),encoding='utf-8')
    print('Verified import:',args.output)

if __name__=='__main__': main()
