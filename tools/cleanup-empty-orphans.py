"""Remove verified empty imported stubs using the same predicate as the desktop upgrade."""
import argparse
import datetime
import json
import sqlite3
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
MARKER = 'empty_orphan_cleanup_v1'

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('database', type=Path)
    parser.add_argument('--apply', action='store_true')
    args = parser.parse_args()
    path = args.database.resolve(strict=True)
    connection = sqlite3.connect(path.as_uri() + '?mode=rw', uri=True, timeout=15)
    connection.execute('PRAGMA foreign_keys=ON')
    connection.execute('PRAGMA trusted_schema=OFF')
    if connection.execute('PRAGMA user_version').fetchone()[0] != 2:
        raise RuntimeError('Open this database in the new application to upgrade it first')
    if args.apply:
        connection.execute('PRAGMA locking_mode=EXCLUSIVE')
        connection.executescript('BEGIN EXCLUSIVE; COMMIT;')
    query = (ROOT / 'src-tauri/empty-orphan-candidates.sql').read_text(encoding='utf-8')
    ids = [row[0] for row in connection.execute(query)]
    before = connection.execute('SELECT count(*) FROM studies').fetchone()[0]
    if not args.apply:
        print(json.dumps({'candidates': len(ids), 'studies': before, 'applied': False}))
        connection.close()
        return
    previous = connection.execute('SELECT value FROM metadata WHERE key=?', (MARKER,)).fetchone()
    if previous:
        print(json.dumps({'alreadyCompleted': True, 'report': json.loads(previous[0])}, ensure_ascii=True))
        connection.close()
        return
    backup_path = None
    if ids:
        folder = path.parent / 'backups'
        folder.mkdir(exist_ok=True)
        backup_path = folder / ('before-empty-cleanup-' + datetime.datetime.now().strftime('%Y%m%d-%H%M%S-%f') + '.db')
        pending = backup_path.with_suffix('.pending')
        if pending.exists() or backup_path.exists():
            raise FileExistsError('Backup already exists')
        backup = sqlite3.connect(pending)
        try:
            connection.backup(backup)
            if backup.execute('PRAGMA integrity_check').fetchone()[0] != 'ok':
                raise RuntimeError('Backup verification failed; nothing deleted')
            if backup.execute('SELECT count(*) FROM studies').fetchone()[0] != before:
                raise RuntimeError('Backup row count differs; nothing deleted')
        finally:
            backup.close()
        pending.rename(backup_path)
    report = {'removed': len(ids), 'backup': str(backup_path) if backup_path else None,
              'date': datetime.datetime.now(datetime.timezone.utc).isoformat()}
    with connection:
        connection.executemany('DELETE FROM studies WHERE id=?', ((id,) for id in ids))
        connection.execute('INSERT INTO metadata(key,value) VALUES(?,?)', (MARKER, json.dumps(report)))
        if ids:
            connection.execute("INSERT INTO access_audit(action,details) VALUES('cleanup_empty_orphans',?)", (json.dumps(report),))
        after = connection.execute('SELECT count(*) FROM studies').fetchone()[0]
        if after != before - len(ids) or connection.execute('PRAGMA integrity_check').fetchone()[0] != 'ok':
            raise RuntimeError('Cleanup verification failed; transaction rolled back')
    connection.close()
    print(json.dumps({**report, 'before': before, 'after': after, 'applied': True}, ensure_ascii=True))

if __name__ == '__main__':
    main()
