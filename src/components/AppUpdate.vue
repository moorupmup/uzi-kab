<script setup lang="ts">
import { computed, nextTick, onBeforeUnmount, onMounted, ref } from 'vue'
import { isNavigationFailure, useRouter } from 'vue-router'
import { getVersion } from '@tauri-apps/api/app'
import { listen, type UnlistenFn } from '@tauri-apps/api/event'
import { command, desktop, message } from '../api'
import metadata from '../../package.json'

const router = useRouter()
const current = ref(metadata.version), available = ref<string | null>(null)
const busy = ref(false), percent = ref(0), error = ref('')
const overlay = ref<HTMLElement>()
const shortVersion = (value: string) => value.endsWith('.0') ? value.slice(0, -2) : value
const status = computed(() => percent.value < 100 ? `Скачиваем обновление · ${percent.value}%` : 'Проверяем файл и готовим перезапуск…')
let timer: ReturnType<typeof setInterval> | undefined, unlisten: UnlistenFn | undefined
let checking = false, disposed = false
async function check() {
  if (!desktop || busy.value || checking) return
  checking = true
  try {
    const result = await command<{ current: string; version: string | null; error?: string }>('check_update')
    current.value = result.current
    available.value = result.version
    if (result.error) error.value = result.error
  } catch { /* Offline operation is normal; retry at the next scheduled check. */ }
  finally { checking = false }
}
async function update() {
  if (busy.value || !available.value) return
  busy.value = true; error.value = ''; percent.value = 0
  try {
    // Reuse the editor's leave guard before any download or application exit.
    const navigation = await router.push('/')
    if (isNavigationFailure(navigation) && router.currentRoute.value.path !== '/') return
    await nextTick(); overlay.value?.focus()
    await command('install_update', { expectedVersion: available.value })
  } catch (e) { error.value = message(e) }
  finally { busy.value = false }
}
onMounted(async () => {
  if (!desktop) return
  current.value = await getVersion().catch(() => metadata.version)
  const stop = await listen<number>('update-progress', event => { percent.value = event.payload })
  if (disposed) { stop(); return }
  unlisten = stop
  void check()
  timer = setInterval(() => void check(), 60 * 60 * 1000)
  window.addEventListener('online', check)
})
onBeforeUnmount(() => { disposed = true; clearInterval(timer); unlisten?.(); window.removeEventListener('online', check) })
</script>

<template>
  <div class="version app-version">
    <span class="app-version-name">Кабинет УЗИ</span>
    <div class="app-version-actions">
      <span :title="`Текущая версия ${current}`">{{ shortVersion(current) }}</span>
      <template v-if="available">
        <span class="update-badge" :aria-label="`Доступна версия ${available}`">{{ shortVersion(available) }}</span>
        <UTooltip text="Обновить программу" :delay-duration="150" :content="{ side: 'top', sideOffset: 8 }">
          <button type="button" class="update-button" aria-label="Обновить программу" :disabled="busy" @click="update">
            <UIcon name="i-lucide-refresh-cw" :class="{ 'update-spin': busy }" />
          </button>
        </UTooltip>
      </template>
    </div>
    <div v-if="error" class="update-error" role="alert">{{ error }}<template v-if="available"> Нажмите кнопку обновления, чтобы повторить.</template></div>
  </div>
  <Teleport to="body">
    <div v-if="busy && router.currentRoute.value.path === '/'" ref="overlay" class="update-overlay" role="dialog" aria-modal="true" aria-labelledby="update-title" tabindex="-1" @keydown.tab.prevent>
      <div class="update-progress-panel">
        <UIcon name="i-lucide-refresh-cw" class="update-spin update-progress-icon" />
        <h2 id="update-title">Обновляем программу</h2>
        <p role="status" aria-live="polite">{{ status }}</p>
        <progress :value="percent" max="100" aria-label="Загрузка обновления" />
        <p>После обновления программа откроется снова.</p>
      </div>
    </div>
  </Teleport>
</template>
