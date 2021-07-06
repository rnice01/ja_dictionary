import Vue from 'vue'
import Vuetify from 'vuetify/lib/framework'
import colors from 'vuetify/lib/util/colors'
import '@mdi/font/css/materialdesignicons.css'

Vue.use(Vuetify)

export default new Vuetify({
  theme: {
    dark: true,
    themes: {
      dark: {
        primary: colors.deepPurple.darken3,
        secondary: colors.amber.darken1,
        accent: colors.indigo.lighten4,
        background: colors.blueGrey.darken2
      },
    },
  },
})
