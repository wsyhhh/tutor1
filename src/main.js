import Vue from 'vue'
import BootstrapVue from 'bootstrap-vue'
import VueCodemirror from 'vue-codemirror'

import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import 'codemirror/lib/codemirror.css'

import App from './App.vue'
import router from './router'
import store from './store'

Vue.config.productionTip = false
Vue.use(BootstrapVue)
Vue.use(VueCodemirror)

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
