<template>
  <div>
    <div class="form-group">
      <label for="dictionary-search">Search by kanji, kana, or the english meaning</label>
      <input id="dictionary-search" type="text" class="form-control bg-dark text-gray-400" @keyup.enter="performSearch" v-model="state.searchTerm" />
    </div>
    <div class="form-group mt-2 mb-3">
      <button type="button" class="btn btn-primary" @click="performSearch" >Search</button>
    </div>
    <VocabResults :vocabResults="state.results"></VocabResults>
  </div>
</template>

<script lang="ts">
import { reactive, onBeforeMount, defineComponent } from 'vue'
import { DictionaryApi } from '../../api'
import { Vocab } from '../../types/vocab'
import VocabResults from './VocabResults.vue'

export default defineComponent({
  components: {
    VocabResults
  },
  setup () {
    const vocabResults: Array<Vocab> = []
    const state = reactive({
      results: vocabResults,
      searchTerm: ''
    })
    const api = new DictionaryApi()

    const performSearch = () => {
      api.search(state.searchTerm)
        .then(vocab => {
          state.results = vocab
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
