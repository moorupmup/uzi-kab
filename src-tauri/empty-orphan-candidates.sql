SELECT s.id FROM studies s
WHERE s.origin='legacy' AND s.status='legacy:0'
  AND s.patient_id=0 AND s.template_id=0 AND s.revision=1
  AND COALESCE(s.conclusion,'')='' AND COALESCE(s.addition,'')=''
  AND json_valid(s.fields_json)
  AND json_type(CASE WHEN json_valid(s.fields_json) THEN s.fields_json ELSE 'null' END)='object'
  AND NOT EXISTS (
    SELECT 1 FROM json_each(CASE WHEN json_valid(s.fields_json) THEN s.fields_json ELSE '{}' END) f
    WHERE CASE WHEN f.type='object' THEN
      json_extract(f.value,'$.value') IS NOT ''
      OR json_type(f.value,'$.type') IS NOT 'text'
      OR EXISTS (SELECT 1 FROM json_each(f.value) p WHERE p.key NOT IN('value','type'))
    ELSE 1 END
  )
  AND NOT EXISTS (SELECT 1 FROM attachments a WHERE a.study_id=s.id)
  AND NOT EXISTS (SELECT 1 FROM bundle_items b WHERE b.study_id=s.id)
  AND NOT EXISTS (SELECT 1 FROM audit a WHERE a.entity='study' AND a.entity_id=s.id)
ORDER BY s.id
