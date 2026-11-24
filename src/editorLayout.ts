import layouts from './editor-layouts.json'
import { abdominalLayout, abdominalRows, abdominalUnit, originalAbdominalFields } from './abdominalLayout'
import { editorFields } from './editor-conditions'
import { groupFields } from './structuredGroups'
import type { FieldDefinition, FieldValue } from './types'

interface SourceLayout {
  rows: [label: string, ...keys: string[]][]
  units: Record<string, string>
  captions: Record<string, string>
}

const sourceLayouts = layouts as unknown as Record<string, SourceLayout>
const abdominalKey = 'brooho_1'
const uterusFields = new Set(['matka_neopred', 'matka_dl', 'matka_tol', 'matka_sh', 'matka_ob', 'forma_matka', 'forma_matka_text', 'struct_matka', 'str_miom'])

export function hasSourceLayout(key: string) {
  return key === abdominalKey || Object.hasOwn(sourceLayouts, key)
}

export function studyEditorDefinitions(key: string, definitions: FieldDefinition[], fields: Record<string, FieldValue>) {
  if (key === abdominalKey) return originalAbdominalFields(definitions, fields)
  const available = definitions.filter(field => !field.hidden)
  if (!hasSourceLayout(key)) return available

  const separator = key.lastIndexOf('_')
  const visible = editorFields(key.slice(0, separator), key.slice(separator + 1), available, fields, available.map(field => field.key))
  const positions = new Map(sourceLayouts[key].rows.flatMap(([, ...keys]) => keys).map((field, index) => [field, index]))
  return visible.sort((left, right) =>
    (positions.get(left.key) ?? Infinity) - (positions.get(right.key) ?? Infinity))
}

export function editorLayoutGroups(key: string, definitions: FieldDefinition[], fields: Record<string, FieldValue>) {
  if (key === abdominalKey) return abdominalLayout(definitions, fields)
  const grouped = key.startsWith('ginekol_')
    ? definitions.map(field => uterusFields.has(field.key) ? { ...field, group: 'Тело матки' } : field)
    : definitions
  return groupFields(grouped, fields).map(group => ({
    ...group,
    blocks: [{ name: undefined as string | undefined, fields: group.fields }],
  }))
}

export function editorLayoutRows(key: string, fields: FieldDefinition[]) {
  if (key === abdominalKey) return abdominalRows(fields)
  const source = sourceLayouts[key]
  const fieldRows = new Map<string, SourceLayout['rows'][number]>()
  for (const row of source?.rows ?? []) {
    for (const id of row.slice(1)) fieldRows.set(id, row)
  }
  const byKey = new Map(fields.map(field => [field.key, field]))
  const placed = new Set<string>()

  return fields.flatMap(field => {
    if (placed.has(field.key)) return []
    const [sourceLabel, ...keys] = fieldRows.get(field.key) ?? ['', field.key]
    const controls = keys.flatMap(id => {
      const control = byKey.get(id)
      return control ? [control] : []
    })
    controls.forEach(control => placed.add(control.key))
    const label = sourceLabel.length > 2 ? sourceLabel : field.label
    const checkboxOnly = controls.every(control => control.valueType === 'checkbox')
    return [{
      name: checkboxOnly && !sourceLabel ? '' : label,
      fields: controls,
    }]
  })
}

export function editorFieldUnit(key: string, field: FieldDefinition) {
  return key === abdominalKey ? abdominalUnit(field) : sourceLayouts[key]?.units[field.key] ?? ''
}

export function editorFieldCaption(key: string, field: FieldDefinition) {
  return sourceLayouts[key]?.captions[field.key] ?? ''
}
