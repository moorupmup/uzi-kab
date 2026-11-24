import json
import re
from html.parser import HTMLParser
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
CATALOG = json.loads((ROOT / 'src/catalog.json').read_text(encoding='utf-8'))
MODELS = json.loads((ROOT / 'src/editor-conditions.json').read_text(encoding='utf-8'))
UNIT = re.compile(r'^\s*([мс]м(?:[23²³])?(?:\s+рт\.?\s*ст\.?)?|мл|м/с|см/с|г|кг|%|мс|уд/мин|нед(?:ель)?|лет|дней|году)(?![\w/])', re.I)


class LayoutParser(HTMLParser):
    def __init__(self):
        super().__init__()
        self.rows = []
        self.row = []
        self.cell = []
        self.seen = set()

    def finish_cell(self):
        if self.cell:
            self.row.append(self.cell)
            self.cell = []

    def finish_row(self):
        self.finish_cell()
        if self.row:
            self.rows.append(self.row)
            self.row = []

    def handle_starttag(self, tag, attrs):
        if tag in {'tr', 'table'}:
            self.finish_row()
        if tag in {'td', 'th'}:
            self.finish_cell()
        if tag == 'input':
            key = dict(attrs).get('data-field')
            if key and key not in self.seen:
                self.cell.append((key,))
                self.seen.add(key)

    def handle_endtag(self, tag):
        if tag in {'td', 'th'}:
            self.finish_cell()
        if tag in {'tr', 'table'}:
            self.finish_row()

    def handle_data(self, data):
        if data.strip():
            self.cell.append(data)


def clean(text):
    return ' '.join(text.split()).strip(' :;')


def compile_layout(key):
    source = (ROOT / 'legacy/forms' / (key + '.jsp')).read_text(encoding='cp1251')
    definitions = {field['key']: field for field in CATALOG[key]}
    source = re.sub(r'<script\b[^>]*>[\s\S]*?</script>', '', source, flags=re.I)
    source = re.sub(r'<%=\s*r\.\w+\("([^"]+)"[^%]*%>', lambda m:
                    '<input data-field="' + m[1] + '">' if m[1] in definitions else '', source)
    parser = LayoutParser()
    parser.feed(re.sub(r'<%[\s\S]*?%>', '', source))
    parser.finish_row()
    rows, units, captions = [], {}, {}
    for cells in parser.rows:
        row = []
        pending_label = ''
        for cell in cells:
            entries = [i for i, token in enumerate(cell) if isinstance(token, tuple)]
            if not entries:
                pending_label = clean(' '.join(cell))
                continue
            first = entries[0]
            prefix = clean(' '.join(cell[:first]))
            if row and (pending_label or (prefix and any(c.isalpha() for c in prefix))):
                rows.append(row)
                row = []
            if not row:
                row = [pending_label or prefix]
            pending_label = ''
            for index, at in enumerate(entries):
                field = cell[at][0]
                if index:
                    prefix = ' '.join(cell[entries[index-1]+1:at])
                    prefix = clean(UNIT.sub('', prefix))
                    if len(prefix)>1 and any(char.isalpha() for char in prefix):
                        captions[field] = prefix
                next_at = entries[index+1] if index+1 < len(entries) else len(cell)
                match = UNIT.match(' '.join(cell[at+1:next_at]))
                if match and definitions[field]['kind'] in {'getSizeInput','getTextInput','getHidden'}:
                    units[field] = clean(match[1])
                row.append(field)
        if row:
            rows.append(row)
    missing = set(definitions) - parser.seen
    if missing:
        raise ValueError(f'{key}: missing source fields: {sorted(missing)}')
    return {'rows':rows,'units':units,'captions':captions}


# The abdomen already has a dedicated layout based on the same source.
out = {key:compile_layout(key) for key in MODELS if key != 'brooho_1'}
(ROOT / 'src/editor-layouts.json').write_text(
    '{\n' + ',\n'.join('  '+json.dumps(key)+': '+json.dumps(value, ensure_ascii=False)
                        for key,value in out.items()) + '\n}\n', encoding='utf-8')
