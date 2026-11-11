import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import ui from '@nuxt/ui/vite'
import { localArchivePreview } from './tools/preview'

export default defineConfig({
  plugins: [vue(), ui({ colorMode: false, icon: { clientBundle: { scan: true } }, ui: { colors: { primary: 'teal', neutral: 'slate' }, button: { variants: { square: { false: { base: 'app-text-button' } } } } } }), localArchivePreview()],
  clearScreen: false,
  server: { strictPort: true, watch: { ignored: ['**/src-tauri/**','**/.tools/**','**/data/**','**/release/**'] } },
  build: { target: 'es2021' }
})

