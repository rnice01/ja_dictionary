import Vue from 'vue'
import Dictionary from './Dictionary.vue'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(Dictionary, {
      props: {}
    })
  }).$mount()
  document.body.appendChild(app.$el)
})
