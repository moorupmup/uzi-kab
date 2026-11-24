<script setup lang="ts">
import { computed, ref } from 'vue'
import { getLocalTimeZone, parseDate, today, type DateValue } from '@internationalized/date'

const model = defineModel<string>({ required: true })
const open = ref(false)
const selected = computed(() => {
  if (!model.value) return undefined
  try {
    return parseDate(model.value)
  } catch {
    return undefined
  }
})

function updateDate(value: DateValue | null | undefined) {
  model.value = value?.toString() ?? ''
}

function pickDate(value: DateValue | undefined) {
  if (!value) return
  updateDate(value)
  open.value = false
}
</script>

<template>
  <UInputDate
    class="study-date-field w-full"
    locale="ru-RU"
    required
    :model-value="selected"
    @update:model-value="updateDate"
  >
    <template #trailing>
      <UPopover v-model:open="open" :content="{ align: 'end', sideOffset: 6, 'aria-label': 'Календарь исследования' }" :ui="{ content: 'study-date-popup' }">
        <UButton class="study-date-trigger" type="button" icon="i-lucide-calendar-days" color="neutral" variant="ghost" aria-label="Открыть календарь" />
        <template #content>
          <UCalendar
            locale="ru-RU"
            :model-value="selected"
            :week-starts-on="1"
            weekday-format="short"
            :prev-month="{ 'aria-label': 'Предыдущий месяц' }"
            :next-month="{ 'aria-label': 'Следующий месяц' }"
            :prev-year="{ 'aria-label': 'Предыдущий год' }"
            :next-year="{ 'aria-label': 'Следующий год' }"
            prevent-deselect
            @update:model-value="pickDate"
          />
          <div class="study-date-actions">
            <UButton type="button" color="neutral" variant="ghost" @click="pickDate(today(getLocalTimeZone()))">Сегодня</UButton>
          </div>
        </template>
      </UPopover>
    </template>
  </UInputDate>
</template>
