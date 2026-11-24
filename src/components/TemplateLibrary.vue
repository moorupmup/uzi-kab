<script setup lang="ts">
import {computed,onMounted,ref,watch} from 'vue'
import {command,message,desktop} from '../api'
import {useDatabase} from '../stores/database'
import {useAuth} from '../stores/auth'
import TemplateTreeManager from './TemplateTreeManager.vue'
import {templatePath,sectionItems,visibleTemplate,findTemplateSection,templateSectionRows,templatePhraseParts,composeTemplate,type TemplatePhrasePart,type UserTemplate} from '../userTemplates'
const props=defineProps<{templateId?:number;pick?:boolean;referenceKey?:string}>()
const referenceSection=computed(()=>props.referenceKey&&props.templateId!=null?findTemplateSection(entries.value,props.referenceKey,props.templateId):undefined)
const emit=defineEmits<{select:[entry:UserTemplate,text?:string]}>()
const treeOpen=ref(false),treeEntry=ref<UserTemplate>(),treeAction=ref('browse'),selectedSection=ref(0)
function openTree(action='browse',entry?:UserTemplate){treeAction.value=action;treeEntry.value=entry;treeOpen.value=true}
function createFolderAction(entry:UserTemplate){return {label:'Создать подраздел',icon:'i-lucide-folder-plus',onSelect:()=>openTree('create',entry)}}
function entryActions(entry:UserTemplate){return [{label:entry.folder?'Копировать ветвь':'Копировать',icon:'i-lucide-copy',onSelect:()=>openTree('copy',entry)},{label:'Переместить',icon:'i-lucide-folder-input',onSelect:()=>openTree('move',entry)},createFolderAction(entry),{label:'Выше в разделе',icon:'i-lucide-arrow-up',onSelect:()=>order(entry,'up')},{label:'Ниже в разделе',icon:'i-lucide-arrow-down',onSelect:()=>order(entry,'down')}]}
async function restoreEntry(entry:UserTemplate){saving.value=true;error.value='';try{const result=await command<{entries:UserTemplate[]}>('mutate_template_tree',{input:{action:'restore',id:entry.id,revision:entry.revision||0}});entries.value=result.entries;success.value='Заготовка восстановлена.'}catch(e){error.value=message(e)}finally{saving.value=false}}
async function order(entry:UserTemplate,direction:string){saving.value=true;error.value='';try{const result=await command<{entries:UserTemplate[]}>('mutate_template_tree',{input:{action:'order',id:entry.id,revision:entry.revision||0,direction}});entries.value=result.entries;success.value='Порядок изменён.'}catch(e){error.value=message(e)}finally{saving.value=false}}
const createOpen=ref(false),createType=ref<number>(),createParent=ref<number>(),createText=ref('')
const auth=useAuth(),editing=ref<UserTemplate>(),deleting=ref<UserTemplate>(),editText=ref(''),saving=ref(false),dialogError=ref(''),success=ref(''),showDeleted=ref(false)
const db=useDatabase(),entries=ref<UserTemplate[]>([]),query=ref(''),selectedType=ref<number>(props.templateId||0),showHidden=ref(false),error=ref(''),loading=ref(true)
watch(selectedType,()=>selectedSection.value=0)
async function load(){loading.value=true;error.value='';try{if(!db.info)await db.load();entries.value=await command<UserTemplate[]>('user_templates')}catch(e){error.value=message(e)}finally{loading.value=false}}
onMounted(load)
function edit(entry:UserTemplate){editing.value=entry;editText.value=entry.value||entry.name;dialogError.value=''}
function requestDelete(entry:UserTemplate){deleting.value=entry;dialogError.value=''}
async function save(entry:UserTemplate,text:string,deleted:boolean){
 saving.value=true;dialogError.value='';error.value='';success.value=''
 try{const result=await command<{text:string;deleted:boolean;revision:number}>('save_user_template',{id:entry.id,revision:entry.revision||0,text,deleted});Object.assign(entry,{value:result.text,deleted:result.deleted,revision:result.revision});editing.value=undefined;deleting.value=undefined;success.value=deleted?'Заготовка удалена. Её можно восстановить через «Показать удалённые».':'Заготовка сохранена.'}catch(e){if(editing.value||deleting.value)dialogError.value=message(e);else error.value=message(e)}finally{saving.value=false}
}

const viewMode=ref<'tree'|'sections'>(localStorage.getItem('uzi-template-view')==='sections'?'sections':'tree')
const showTree=computed(()=>!props.pick&&viewMode.value==='tree')
const catalogType=computed(()=>showTree.value?selectedType.value:0)
const toggledFolders=ref(new Set<number>())
watch(viewMode,mode=>localStorage.setItem('uzi-template-view',mode))
watch([selectedType,query],()=>toggledFolders.value.clear())
const items=computed(()=>[{label:'Все виды исследований',value:0},...(db.info?.templates||[]).filter(t=>!t.hidden||showHidden.value).map(t=>({label:t.name,value:t.id}))])
const sections=computed(()=>props.pick?[]:sectionItems(entries.value,catalogType.value,showHidden.value,showDeleted.value))
const folders=computed(()=>{
 const ids=new Set(sections.value.map(section=>section.value))
 return entries.value.filter(entry=>ids.has(entry.id))
})
const activeFolder=computed(()=>folders.value.find(folder=>folder.id===selectedSection.value))
const activePath=computed(()=>activeFolder.value?[...templatePath(activeFolder.value,entries.value),activeFolder.value]:[])
const rootFolders=computed(()=>{
 const ids=new Set(folders.value.map(folder=>folder.id))
 return folders.value.filter(folder=>!ids.has(folder.parentId)).map(folder=>{
  const children=folders.value.filter(child=>child.parentId===folder.id)
  const typeBranch=catalogType.value&&children.length===1&&children[0].templateId===catalogType.value?children[0]:undefined
  const sharedPhrases=entries.value.some(entry=>entry.parentId===folder.id&&!entry.folder)
  return {label:folder.name,value:typeBranch&&!sharedPhrases?typeBranch.id:folder.id,rootId:folder.id}
 })
})
const childFolders=computed(()=>activeFolder.value
 ? folders.value.filter(folder=>folder.parentId===activeFolder.value?.id).map(folder=>({label:folder.name,value:folder.id}))
 : rootFolders.value)
function displayPath(path:UserTemplate[]){
 const branch=rootFolders.value.find(folder=>folder.rootId===path[0]?.id&&folder.value===path[1]?.id)
 if(!branch)return path
 return [{id:branch.value,name:branch.label},...path.slice(2)]
}
const breadcrumbs=computed(()=>displayPath(activePath.value))
watch(folders,()=>{if(selectedSection.value&&!activeFolder.value)selectedSection.value=0})
watch(items,()=>{if(!items.value.some(item=>item.value===selectedType.value))selectedType.value=0})
function createKindFor(folder:UserTemplate){
 const path=[...templatePath(folder,entries.value),folder]
 const templateId=folder.templateId||path.find(node=>node.templateId)?.templateId
 const kind=db.info?.templates.find(template=>template.id===templateId&&!template.hidden)
 return kind&&path.every(node=>!node.hidden&&!node.deleted)?kind.id:undefined
}
const canCreate=computed(()=>activeFolder.value&&createKindFor(activeFolder.value))
const destination=computed(()=>{
 const folder=folders.value.find(entry=>entry.id===createParent.value)
 return folder?displayPath([...templatePath(folder,entries.value),folder]).map(node=>node.name).join(' / '):''
})
const catalogActions=computed(()=>[[
 {label:'Показать скрытые',type:'checkbox' as const,checked:showHidden.value,onUpdateChecked:(checked:boolean)=>{showHidden.value=checked}},
 ...(auth.canWrite?[{label:'Показать удалённые',type:'checkbox' as const,checked:showDeleted.value,onUpdateChecked:(checked:boolean)=>{showDeleted.value=checked}}]:[]),
],[
 {label:'Обновить',icon:'i-lucide-refresh-cw',disabled:loading.value||saving.value,onSelect:load},
 ...(auth.canWrite?[{label:'Управление разделами',icon:'i-lucide-folder-tree',disabled:!desktop||loading.value||saving.value,onSelect:()=>openTree()}]:[]),
]])
function beginCreate(folder=activeFolder.value){
 if(!folder)return
 const kind=createKindFor(folder)
 if(!kind)return
 createType.value=kind
 createParent.value=folder.id
 createText.value=''
 dialogError.value=''
 createOpen.value=true
}
async function create(){
 if(!createType.value||!createParent.value||!createText.value.trim())return
 saving.value=true;dialogError.value='';success.value=''
 try{const entry=await command<UserTemplate>('create_user_template',{templateId:createType.value,parentId:createParent.value,text:createText.value});entries.value.unshift(entry);query.value='';toggledFolders.value.delete(createParent.value);createOpen.value=false;success.value='Новая заготовка добавлена.'}catch(e){dialogError.value=message(e)}finally{saving.value=false}
}
const rows=computed(()=>{
 const search=query.value.trim().toLocaleLowerCase('ru')
 if(!props.pick&&!showTree.value&&!activeFolder.value&&!search)return []
 const candidates=props.pick
  ? templateSectionRows(entries.value,referenceSection.value,props.templateId??0,showHidden.value)
  : entries.value.filter(e=>!e.folder).map(entry=>({entry,path:templatePath(entry,entries.value)})).filter(({entry,path})=>
     visibleTemplate(entry,path,showHidden.value,showDeleted.value)
     &&(!catalogType.value||entry.templateId===catalogType.value||(!entry.templateId&&path.some(p=>p.templateId===catalogType.value)))
     &&(showTree.value||!activeFolder.value||(search?path.some(p=>p.id===activeFolder.value?.id):entry.parentId===activeFolder.value.id)))
 return candidates.filter(({entry,path})=>[...path.map(p=>p.name),entry.name,entry.value].join(' ').toLocaleLowerCase('ru').includes(search))
  .map(row=>({...row,parts:props.pick&&referenceSection.value?templatePhraseParts(row.entry,row.path,referenceSection.value.id):[]}))
})

const phraseEntry=ref<UserTemplate>(),phraseParts=ref<TemplatePhrasePart[]>([]),phraseSelected=ref<number[]>([])
const phraseText=computed(()=>composeTemplate(phraseParts.value,phraseSelected.value))
function assemble(entry:UserTemplate,parts:TemplatePhrasePart[]){
 phraseParts.value=parts
 phraseSelected.value=parts.filter(part=>part.checked).map(part=>part.id)
 phraseEntry.value=entry
}
function selectPhrasePart(id:number,checked:boolean){
 phraseSelected.value=checked?[...phraseSelected.value,id]:phraseSelected.value.filter(value=>value!==id)
}
function insertPhrase(){
 if(!phraseEntry.value||!phraseText.value)return
 emit('select',phraseEntry.value,phraseText.value)
 phraseEntry.value=undefined
}

const defaultExpanded=computed(()=>Boolean(selectedType.value||query.value.trim()))
function toggleFolder(id:number){
 if(toggledFolders.value.has(id))toggledFolders.value.delete(id)
 else toggledFolders.value.add(id)
}
const treeRows=computed(()=>{
 if(!showTree.value)return []
 const searching=Boolean(query.value.trim())
 const visibleIds=new Set(rows.value.flatMap(({path})=>path.map(folder=>folder.id)))
 const eligibleFolders=folders.value.filter(folder=>!searching||visibleIds.has(folder.id))
 const nodes=new Map<number,UserTemplate>([...eligibleFolders,...rows.value.map(({entry})=>entry)].map(entry=>[entry.id,entry]))
 const children=new Map<number,UserTemplate[]>()
 for(const entry of nodes.values()){
  const parent=nodes.has(entry.parentId)?entry.parentId:0
  const siblings=children.get(parent)||[]
  siblings.push(entry)
  children.set(parent,siblings)
 }
 const result:{entry:UserTemplate;label:string;depth:number;expanded:boolean;hasChildren:boolean}[]=[]
 const seen=new Set<number>()
 function visit(entry:UserTemplate,depth:number,label=entry.name){
  if(seen.has(entry.id))return
  seen.add(entry.id)
  const branch=children.get(entry.id)||[]
  const expanded=defaultExpanded.value!==toggledFolders.value.has(entry.id)
  result.push({entry,label,depth,expanded,hasChildren:branch.length>0})
  if(expanded)for(const child of branch)visit(child,depth+1)
 }
 const roots=new Map(rootFolders.value.map(folder=>[folder.rootId,folder]))
 for(const entry of children.get(0)||[]){
  const root=roots.get(entry.id)
  const branch=root&&nodes.get(root.value)
  if(branch&&branch.id!==entry.id)visit(branch,0,root.label)
  else visit(entry,0)
 }
 return result
})
function treeEntryActions(entry:UserTemplate){
 if(entry.folder){
  if(entry.key)return [createFolderAction(entry)]
  if(entry.deleted||entry.hidden)return [{label:'Восстановить',icon:'i-lucide-undo-2',onSelect:()=>openTree('restore',entry)}]
  return [
   {label:'Изменить',icon:'i-lucide-pencil',onSelect:()=>openTree('edit',entry)},
   ...entryActions(entry),
   {label:'Удалить',icon:'i-lucide-trash-2',onSelect:()=>openTree('delete',entry)},
  ]
 }
 if(entry.deleted||entry.hidden)return [{label:'Восстановить',icon:'i-lucide-undo-2',onSelect:()=>restoreEntry(entry)}]
 return [
  {label:'Изменить',icon:'i-lucide-pencil',onSelect:()=>edit(entry)},
  ...entryActions(entry),
  {label:'Удалить',icon:'i-lucide-trash-2',onSelect:()=>requestDelete(entry)},
 ]
}
</script>
<template>
<div>
  <UAlert v-if="success" color="success" :description="success" class="mb-5"/>
  <UAlert v-if="error" color="error" :description="error" class="mb-5"/>

  <div class="flex flex-wrap items-end gap-3 mb-5">
    <UFormField v-if="showTree" label="Вид исследования" class="w-full sm:w-72">
      <USelect v-model="selectedType" :items="items" class="w-full"/>
    </UFormField>
    <UFormField :label="pick?undefined:'Поиск по тексту и разделу'" class="min-w-0 flex-1">
      <UInput v-model="query" :aria-label="pick?'Поиск по тексту и разделу':undefined" icon="i-lucide-search" placeholder="Найти заготовку…" class="w-full"/>
    </UFormField>
    <UDropdownMenu v-if="!pick" :items="catalogActions">
      <UButton variant="outline" color="neutral" icon="i-lucide-ellipsis" aria-label="Действия справочника"/>
    </UDropdownMenu>
  </div>
  <UCheckbox v-if="pick" v-model="showHidden" label="Показать скрытые" class="mb-5"
    :ui="{root:'items-center',container:'h-auto',label:'block'}"/>

  <p v-if="loading" role="status">Загружаем справочник…</p>
  <template v-else>
    <div v-if="!pick" class="flex flex-wrap items-center gap-2 mb-4" role="group" aria-label="Вид справочника">
      <UButton v-for="option in [{value:'tree',label:'Дерево',icon:'i-lucide-list-tree'},{value:'sections',label:'По разделам',icon:'i-lucide-folders'}] as const"
        :key="option.value" size="sm" :icon="option.icon" :aria-pressed="viewMode===option.value"
        :variant="viewMode===option.value?'soft':'ghost'" :color="viewMode===option.value?'primary':'neutral'" @click="viewMode=option.value">{{option.label}}</UButton>
    </div>
    <ul v-if="showTree&&treeRows.length" class="template-tree rounded-lg border border-default" aria-label="Разделы и заготовки">
      <li v-for="{entry,label,depth,expanded,hasChildren} in treeRows" :key="entry.id" class="template-tree-row"
        :style="{paddingInlineStart:`${Math.min(depth,10)*16+8}px`}">
        <button v-if="entry.folder&&hasChildren" type="button" class="template-tree-control template-tree-branch"
          :aria-expanded="expanded" @click="toggleFolder(entry.id)">
          <UIcon :name="expanded?'i-lucide-chevron-down':'i-lucide-chevron-right'" aria-hidden="true"/>
          <UIcon name="i-lucide-folder" aria-hidden="true"/>
          <span>{{label}}</span>
        </button>
        <div v-else class="template-tree-branch" :class="{'font-medium':entry.folder}">
          <UIcon :name="entry.folder?'i-lucide-folder':'i-lucide-file-text'" class="template-tree-leaf-icon" aria-hidden="true"/>
          <span class="whitespace-pre-line">{{entry.folder?label:entry.value||entry.name}}</span>
        </div>
        <span v-if="entry.hidden||entry.deleted" class="text-xs text-muted">{{entry.deleted?'Удалено':'Скрыто'}}</span>
        <button v-if="entry.folder&&auth.canWrite&&selectedType&&createKindFor(entry)" type="button" class="template-tree-control template-tree-icon"
          :aria-label="`Добавить заготовку в «${label}»`" title="Новая заготовка" :disabled="!desktop||saving" @click="beginCreate(entry)">
          <UIcon name="i-lucide-plus" aria-hidden="true"/>
        </button>
        <UDropdownMenu v-if="auth.canWrite&&(!entry.folder||!entry.key||(!entry.deleted&&!entry.hidden))" :items="treeEntryActions(entry)">
          <UButton variant="ghost" color="neutral" icon="i-lucide-ellipsis" class="template-tree-menu"
            :aria-label="entry.folder?`Действия с разделом «${label}»`:'Действия с заготовкой'" :disabled="!desktop||saving"/>
        </UDropdownMenu>
      </li>
    </ul>
    <p v-else-if="showTree" class="text-muted">{{query.trim()?'Заготовок не найдено.':'Разделов пока нет.'}}</p>
    <template v-else>
    <template v-if="!pick">
      <div class="flex flex-wrap justify-between items-center gap-3 mb-4">
        <nav v-if="activeFolder" aria-label="Путь раздела" class="template-breadcrumbs flex flex-wrap items-center gap-1">
          <UButton variant="ghost" color="neutral" size="sm" @click="selectedSection=0">Разделы</UButton>
          <template v-for="folder in breadcrumbs" :key="folder.id">
            <UIcon name="i-lucide-chevron-right" class="text-muted" aria-hidden="true"/>
            <span v-if="folder.id===activeFolder.id" aria-current="page" class="template-breadcrumb-current">{{folder.name}}</span>
            <UButton v-else variant="ghost" color="neutral" size="sm" @click="selectedSection=folder.id">{{folder.name}}</UButton>
          </template>
        </nav>
        <h2 v-else class="text-lg font-semibold">Разделы</h2>
        <UButton v-if="auth.canWrite && canCreate" icon="i-lucide-plus" :disabled="!desktop||saving" @click="beginCreate()">Новая заготовка</UButton>
      </div>
      <ul v-if="childFolders.length&&!query.trim()" class="grid gap-2 sm:grid-cols-2 mb-5">
        <li v-for="folder in childFolders" :key="folder.value">
          <UButton block variant="outline" color="neutral" icon="i-lucide-folder" trailing-icon="i-lucide-chevron-right"
            class="justify-start text-start whitespace-normal" @click="selectedSection=folder.value">{{folder.label}}</UButton>
        </li>
      </ul>
    </template>
    <p v-if="pick&&!referenceSection">Для этого поля ещё нет раздела справочника. Администратор может создать его через «Настройки» → «Настройки видов» → «Синхронизировать разделы».</p>
    <p v-else-if="!pick&&!activeFolder&&!query.trim()&&!childFolders.length" class="text-muted">Разделов пока нет.</p>
    <p v-else-if="!rows.length && (pick||query.trim()||(activeFolder&&!childFolders.length))" class="text-muted">Заготовок не найдено.</p>
    <ul class="template-card-list">
  <li v-for="{entry,path,parts} in rows" :key="entry.id" class="template-card">
    <p class="template-card-path">{{displayPath(path).map(p=>p.name).join(' / ')}}<span v-if="entry.deleted"> · Удалена</span><span v-else-if="path.some(p=>p.deleted)"> · Раздел удалён</span><span v-if="entry.hidden"> · Скрытая запись</span></p>
    <p class="template-card-text preserve-lines">{{entry.value||entry.name}}</p>
    <div v-if="pick&&!entry.deleted||!pick&&auth.canWrite" class="template-card-actions">
      <template v-if="pick&&!entry.deleted"><UButton variant="ghost" icon="i-lucide-plus" aria-label="Вставить" title="Вставить заготовку" @click="emit('select',entry)"/><UButton v-if="parts.length>1" variant="ghost" color="neutral" icon="i-lucide-list-tree" aria-label="Собрать фразу" title="Собрать фразу" @click="assemble(entry,parts)"/></template>
      <template v-else-if="!entry.deleted&&!entry.hidden">
        <UButton variant="ghost" color="neutral" icon="i-lucide-pencil" aria-label="Изменить" title="Изменить заготовку" :disabled="!desktop||saving" @click="edit(entry)"/>
        <UButton variant="ghost" color="error" icon="i-lucide-trash-2" aria-label="Удалить" title="Удалить заготовку" :disabled="!desktop||saving" @click="requestDelete(entry)"/>
      <UDropdownMenu :items="entryActions(entry)"><UButton icon="i-lucide-ellipsis" variant="ghost" color="neutral" aria-label="Действия с заготовкой" title="Действия с заготовкой" :disabled="!desktop||saving"/></UDropdownMenu></template>
      <UButton v-else variant="ghost" icon="i-lucide-undo-2" aria-label="Восстановить" title="Восстановить заготовку" :disabled="!desktop||saving" @click="restoreEntry(entry)"/>
    </div>
  </li>
</ul></template></template>
<UModal :open="Boolean(phraseEntry)" @update:open="(open:boolean)=>{if(!open)phraseEntry=undefined}"
  title="Составная фраза" description="Отметьте фрагменты, которые нужно вставить.">
  <template #body>
    <div class="grid gap-3 mb-5">
      <UCheckbox v-for="part in phraseParts" :key="part.id" :model-value="phraseSelected.includes(part.id)"
        :label="part.text" @update:model-value="selectPhrasePart(part.id,Boolean($event))"/>
    </div>
    <UFormField label="Будет вставлено">
      <p class="rounded-md bg-elevated p-3 preserve-lines" aria-live="polite">{{phraseText||'Выберите хотя бы один фрагмент'}}</p>
    </UFormField>
  </template>
  <template #footer>
    <UButton color="neutral" variant="outline" @click="phraseEntry=undefined">Отмена</UButton>
    <UButton :disabled="!phraseText" @click="insertPhrase">Вставить фразу</UButton>
  </template>
</UModal>
<TemplateTreeManager v-if="treeOpen" v-model:open="treeOpen" :entries="entries" :initial-entry="treeEntry" :initial-action="treeAction" @changed="entries=$event"/>
<UModal :open="createOpen" @update:open="(value:boolean)=>{if(!saving)createOpen=value}" :dismissible="!saving" title="Новая заготовка" :description="destination"><template #body><UAlert v-if="dialogError" color="error" :description="dialogError" class="mb-4"/><div class="grid gap-5"><UFormField label="Текст заготовки" required><UTextarea v-model="createText" :rows="6" autoresize class="w-full" :disabled="saving"/></UFormField></div></template><template #footer><UButton color="neutral" variant="outline" :disabled="saving" @click="createOpen=false">Отмена</UButton><UButton :loading="saving" :disabled="saving||!createType||!createParent||!createText.trim()" @click="create">Добавить</UButton></template></UModal>
<UModal :open="Boolean(editing)" @update:open="(value:boolean)=>{if(!value&&!saving)editing=undefined}" :dismissible="!saving" title="Изменить заготовку" description="Изменения будут использоваться при следующих вставках. Текст сохранённых исследований останется прежним."><template #body><p v-if="editing" class="text-sm text-slate-500 mb-4">{{templatePath(editing,entries).map(p=>p.name).join(' / ')}}</p><UAlert v-if="dialogError" color="error" :description="dialogError" class="mb-4"/><UFormField label="Текст заготовки" required><UTextarea v-model="editText" :rows="8" autoresize class="w-full" :disabled="saving"/></UFormField></template><template #footer><UButton color="neutral" variant="outline" :disabled="saving" @click="editing=undefined">Отмена</UButton><UButton :loading="saving" :disabled="saving||!editText.trim()" @click="editing&&save(editing,editText,false)">Сохранить</UButton></template></UModal>
<UModal :open="Boolean(deleting)" @update:open="(value:boolean)=>{if(!value&&!saving)deleting=undefined}" :dismissible="!saving" title="Удалить заготовку?" description="Она исчезнет из списка вставки. Сохранённые исследования не изменятся. Заготовку можно будет восстановить."><template #body><UAlert v-if="dialogError" color="error" :description="dialogError" class="mb-4"/><p class="preserve-lines">{{deleting?.value||deleting?.name}}</p></template><template #footer><UButton color="neutral" variant="outline" :disabled="saving" @click="deleting=undefined">Отмена</UButton><UButton color="error" :loading="saving" :disabled="saving" @click="deleting&&save(deleting,deleting.value||deleting.name,true)">Удалить заготовку</UButton></template></UModal>
</div></template>
