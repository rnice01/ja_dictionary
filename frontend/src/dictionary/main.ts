import { createApp } from 'vue'
import App from './App.vue'
import '../registerServiceWorker'
import router from './router'
import store from './store'
import 'css.gg/icons/css/chevron-right.css'
import 'css.gg/icons/css/chevron-left.css'

createApp(App).use(store).use(router).mount('#app')
