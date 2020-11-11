<template>
  <div>
    <div class="form-group">
      <label for="dictionary-search">Search by kanji, kana, or the english meaning</label>
      <input id="dictionary-search" type="text" class="form-control bg-dark text-gray-400" @keyup.enter="performSearch" v-model="state.searchTerm" />
    </div>
    <div class="form-group mt-2 mb-3 pb-2">
      <button type="button" class="btn btn-primary" @click="performSearch" >Search</button>
    </div>
    <template v-if="state.searchState == searchStates.SEARCH_DONE">
      <p>{{state.resultsCount}} results found</p>
      <VocabResults :vocabResults="state.vocabResults"></VocabResults>
    </template>
    <template v-if="state.searchState == searchStates.SEARCHING">
      <p>Search in progress...</p>
    </template>
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
    const searchStates = {
      NO_SEARCH: 0,
      SEARCHING: 1,
      SEARCH_DONE: 2
    }
    const state = reactive({
      vocabResults: vocabResults,
      resultsCount: 0,
      searchTerm: '',
      searchState: searchStates.NO_SEARCH
    })

    const api = new DictionaryApi()

    const performSearch = () => {
      state.searchState = searchStates.SEARCHING
      api.search(state.searchTerm)
        .then(results => {
          state.searchState = searchStates.SEARCH_DONE
          state.resultsCount = Number(results.resultsCount)
          state.vocabResults = results.vocabResults
        })
    }

    return {
      searchStates,
      state,
      performSearch
    }
  }
})
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss">
</style>
