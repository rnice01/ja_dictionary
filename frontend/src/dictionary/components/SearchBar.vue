<template>
  <div>
    <div class="form-group">
      <label for="dictionary-search">Search by kanji, kana, or the meaning</label>
      <input id="dictionary-search" type="text" class="form-control bg-dark text-gray-400" @keyup.enter="performSearch" v-model="state.searchTerm" />
    </div>
    <div class="form-group mt-2 mb-3">
      <button type="button" class="btn btn-primary" @click="performSearch" >Search</button>
    </div>
    <KanjiResults :kanjiResults="state.results"></KanjiResults>
  </div>
</template>

<script lang="ts">
import { reactive, onBeforeMount, defineComponent } from 'vue'
import { DictionaryApi } from '../../api'
import Kanji from '../../types/kanji'
import KanjiResults from './KanjiResults.vue'

export default defineComponent({
  components: {
    KanjiResults
  },
  setup () {
    const kanjiResults: Array<Kanji> = []
    const state = reactive({
      results: kanjiResults,
      searchTerm: ''
    })
    const api = new DictionaryApi()

    const performSearch = () => {
      api.searchKanjiDictionary(state.searchTerm)
        .then(kanji => {
          state.results = kanji
        })
    }

    return {
      state,
      performSearch
    }
  }
})
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss">
</style>
