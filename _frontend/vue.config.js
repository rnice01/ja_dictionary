const path = require('path')

const pages = {
  main: {
    entry: 'src/main.ts'
  }
}

module.exports = {
  configureWebpack: {
    optimization: {
      splitChunks: false
    }
  },

  css: {
    extract: {
      filename: '/css/[name].css'
    }
  },

  pages: pages,
  filenameHashing: false,

  chainWebpack: config => {
    Object.keys(pages).forEach(page => {
      config.plugins.store.delete(`preload-${page}`)
      config.plugins.store.delete(`prefetch-${page}`)
    })
  },

  outputDir: path.resolve(__dirname, '../priv/static'),

  transpileDependencies: [
    'vuetify'
  ]
}
