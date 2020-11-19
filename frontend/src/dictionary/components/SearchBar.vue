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
      <Pagination :currentPage="state.currentPage" :totalPages="state.totalPages" @pageClicked="paginate" />
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
import Pagination from './Pagination.vue'

export default defineComponent({
  components: {
    VocabResults,
    Pagination
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
      searchState: searchStates.NO_SEARCH,
      currentPage: 0,
      totalPages: 0 
    })

    const api = new DictionaryApi()

    const performSearch = () => {
      state.searchState = searchStates.SEARCHING
      api.search(state.searchTerm)
        .then(results => {
          state.searchState = searchStates.SEARCH_DONE
          state.vocabResults = results.vocabResults
          state.currentPage = results.currentPage
          state.totalPages = results.totalPages
          state.resultsCount = results.totalPages * results.resultsCount
        })
    }

    const paginate = (page: Number) => {
      api.search(state.searchTerm, page)
        .then(results => {
        state.vocabResults = results.vocabResults
        state.currentPage = results.currentPage
        state.totalPages = results.totalPages
      })
    }

    return {
      searchStates,
      state,
      performSearch,
      paginate
    }
  }
})
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss">
</style>
