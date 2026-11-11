import pymupdf,json
from pathlib import Path
doc=pymupdf.open('.tools/parity-stage6/a4.pdf');texts=[p.get_text() for p in doc];alltext='\n'.join(texts)
assert all(alltext.count(f'Проверка строки {i}.')==1 for i in range(1,25))
assert 'НЕ ЯВЛЯЕТСЯ МЕДИЦИНСКИМ ЗАКЛЮЧЕНИЕМ' in alltext and 'Подпись' in alltext
assert 'Тестовый пациент' in alltext and 'Сохранить черновик' not in alltext
assert all(abs(p.rect.width-595.28)<1 and abs(p.rect.height-841.89)<1 for p in doc)
bounds=[]
for i,p in enumerate(doc):
 p.get_pixmap(matrix=pymupdf.Matrix(1,1)).save(f'.tools/parity-stage6/a4-{i+1}.png')
 spans=[s for b in p.get_text('dict')['blocks'] if 'lines' in b for l in b['lines'] for s in l['spans']]
 assert all(s['bbox'][0]>=49 and s['bbox'][2]<=p.rect.width-49 for s in spans)
 bounds.append({'page':i+1,'width':round(p.rect.width,2),'height':round(p.rect.height,2),'textSpans':len(spans)})
images=doc[-1].get_images();assert len(images)==1
info=doc[-1].get_image_rects(images[0][0])[0];assert abs(info.width/info.height-640/360)<.01
result={'syntheticNativePrint':True,'pages':len(doc),'a4PageSize':True,'all24ParagraphsExactlyOnce':True,'noEditorControls':True,'signaturePresent':True,'imageAspectRatioPreserved':True,'imagePage':len(doc),'pagesTextBounds':bounds,'physicalPrinterPending':True}
Path('docs/parity-stage6-a4.json').write_text(json.dumps(result,ensure_ascii=False,indent=2),encoding='utf-8');print(json.dumps(result))
