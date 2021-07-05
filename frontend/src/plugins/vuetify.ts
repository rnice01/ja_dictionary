import Vue from 'vue'
import Vuetify from 'vuetify/lib/framework'
import colors from 'vuetify/lib/util/colors'

Vue.use(Vuetify)

export default new Vuetify({
  theme: {
    dark: true,
    themes: {
      dark: {
        primary: colors.deepPurple.darken3,
        secondary: colors.amber.darken1,
        accent: colors.indigo.base,
        background: colors.grey.darken2
      },
    },
  },
})
