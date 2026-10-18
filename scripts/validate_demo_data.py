"""Check packaged CSV primary keys and single-column foreign keys without MySQL."""
from pathlib import Path
import csv
import re
import sys

ROOT = Path(__file__).resolve().parents[1]
schema = (ROOT / 'sql/01_schema.sql').read_text(encoding='utf-8')
tables = re.findall(r'CREATE TABLE (\w+)\s*\((.*?)\n\);', schema, re.S)
data = {}
errors = []
for name, body in tables:
    with (ROOT / 'data/demo' / f'{name}.csv').open(encoding='utf-8', newline='') as f:
        data[name] = list(csv.DictReader(f))
    composite = re.search(r'PRIMARY KEY \(([^)]+)\)', body)
    inline = re.search(r'^\s*(\w+)[^\n]*PRIMARY KEY', body, re.M)
    keys = [x.strip() for x in composite.group(1).split(',')] if composite else [inline.group(1)]
    seen = set()
    for row in data[name]:
        key = tuple(row[k] for k in keys)
        if any(not x for x in key) or key in seen:
            errors.append(f'{name}: missing or duplicate primary key {key}')
        seen.add(key)
for name, body in tables:
    for column, parent, parent_column in re.findall(r'FOREIGN KEY \((\w+)\) REFERENCES (\w+)\((\w+)\)', body):
        valid = {row[parent_column] for row in data[parent]}
        missing = {row[column] for row in data[name] if row[column] and row[column] not in valid}
        if missing:
            errors.append(f'{name}.{column}: {len(missing)} unresolved values against {parent}.{parent_column}')
print(f'Checked {len(tables)} tables and {sum(map(len, data.values()))} rows.')
print('\n'.join(errors) if errors else 'Primary-key and foreign-key checks passed.')
sys.exit(bool(errors))
