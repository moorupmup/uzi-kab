<script setup lang="ts">
import { useTemplateRef } from 'vue'

defineProps<{ label?: string; rows: number; placeholder?: string }>()
const value = defineModel<string>({ required: true })
const emit = defineEmits<{ reference: [target: HTMLTextAreaElement] }>()
const input = useTemplateRef<{ textareaRef: HTMLTextAreaElement }>('input')

function openReference() {
  const textarea = input.value?.textareaRef
  if (textarea) emit('reference', textarea)
}
</script>

<template>
  <div class="flex items-start gap-2">
    <UTextarea ref="input" v-model="value" :rows="rows" :placeholder="placeholder" autoresize class="min-w-0 flex-1" />
    <UButton v-if="label" type="button" color="neutral" variant="outline" size="sm" icon="i-lucide-book-open" class="study-template-trigger"
      :aria-label="`Шаблоны для поля «${label}»`" aria-haspopup="dialog" title="Вставить фразу из справочника" @click="openReference" />
  </div>
</template>
