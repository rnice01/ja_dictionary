const path = require('path')

const pages = {
    dictionary: {
      entry: 'src/dictionary/main.ts',
    },
}

module.exports = {
  configureWebpack: {
    optimization: {
      splitChunks: false
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
  outputDir: path.resolve(__dirname, "../priv/static")
}
