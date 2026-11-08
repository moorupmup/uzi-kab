<script setup lang="ts">
import { number } from '../format'
defineProps<{ page:number; pageSize:number; total:number; loading:boolean }>()
const emit=defineEmits<{ 'update:page':[number]; 'update:pageSize':[number] }>()
const sizes=[50,100,200,500].map(value=>({label:String(value),value}))
</script>
<template>
  <div class="table-footer">
    <span>{{total?`${(page-1)*pageSize+1}–${Math.min(page*pageSize,total)} из ${number(total)}`:'Нет результатов'}}</span>
    <div class="table-pagination-controls">
      <label class="page-size-control"><span>Строк на странице</span><USelect :model-value="pageSize" @update:model-value="emit('update:pageSize',$event)" :items="sizes" aria-label="Строк на странице" class="w-24" :disabled="loading"/></label>
      <UPagination :page="page" @update:page="emit('update:page',$event)" :total="total" :items-per-page="pageSize" :sibling-count="1" :disabled="loading"/>
    </div>
  </div>
</template>
