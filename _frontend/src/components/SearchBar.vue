<template>
  <div>
    <div class="form-group">
      <label for="dictionary-search">Search by Kanji, Kana, or the English meaning</label>
      <input id="dictionary-search" type="text" class="form-control bg-dark text-gray-400" @keyup.enter="performSearch" v-model="state.searchTerm" />
         <v-text-field
              v-model="state.searchTerm"
              label="Last name"
              required
            ></v-text-field>
    </div>
    <div class="form-group mt-2 mb-3 pb-2">
      <button type="button" id="search-btn" class="btn btn-primary" @click="performSearch" >Search</button>
    </div>
    <SearchResults
      :isSearching="state.isSearching"
      :searchDone="state.searchDone"
      :resultsCount="state.resultsCount"
      :vocabResults="state.vocabResults"
      :currentPage="state.currentPage"
      :totalPages="state.totalPages"
      @paginate="paginate"
    />
  </div>
</template>

<script lang="ts">
import { reactive, defineComponent } from 'vue'
import { DictionaryApi } from '../api'
import { Vocab } from '../types/vocab'
import SearchResults from './SearchResults.vue'
import VTextField from './VTextField/VTextField.mjs'
import { useRoute, useRouter } from 'vue-router'


export default defineComponent({
  components: {
    SearchResults,
    VTextField
  },
  setup () {
    const vocabResults: Array<Vocab> = []
    const state = reactive({
      vocabResults: vocabResults,
      resultsCount: 0,
      searchTerm: '',
      isSearching: false,
      searchDone: false,
      currentPage: 0,
      totalPages: 0
    })

    const api = new DictionaryApi()
    const route = useRoute()
    const router = useRouter()

    const performSearch = () => {
      state.isSearching = true
      router.replace({ path: '/', query: { searchTerm: state.searchTerm } })
      api.search(state.searchTerm)
        .then(results => {
          state.isSearching = false
          state.searchDone = true
          state.vocabResults = results.vocabResults
          state.currentPage = results.currentPage
          state.totalPages = results.totalPages
          state.resultsCount = results.totalPages * results.resultsCount
        })
    }

    const paginate = (page: number) => {
      api.search(state.searchTerm, page)
        .then(results => {
          state.vocabResults = results.vocabResults
          state.currentPage = results.currentPage
          state.totalPages = results.totalPages
        })
    }

    if (route.query.searchTerm) {
      state.searchTerm = route.query.searchTerm as string
      performSearch()
    }

    return {
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
