<template>
  <div>
    <template v-if="hasResults">
      <div class="row">
        <h4 class="col-6">{{totalResults}} results found</h4>
        <div class="col-6 d-flex justify-content-end">
          <Pagination :currentPage="currentPage" :totalPages="totalPages" @pageClicked="paginate" />
        </div>
      </div>
      <VocabResults :vocabResults="vocabResults" />
    </template>
    <template v-if="noResults">
      <p>No results found</p>
    </template>
    <template v-if="searching">
      <p>Search in progress...</p>
    </template>
  </div>
</template>

<script lang="ts">
import VocabResults from './VocabResults.vue'
import Pagination from './Pagination.vue'
import { SearchResults, SearchState } from '../store/index'
import { mapState } from 'vuex'

export default {
  components: { VocabResults, Pagination },
  data () {
    return {
    }
  },
  computed: {
    ...mapState({
      vocabResults: (state: any) => state.search.searchResults.vocabResults,
      hasResults: (state: any) => (state.search.searchPerformed && state.search.searchResults.vocabResults.length > 0),
      noResults: (state: any) => (state.search.searchPerformed && state.search.searchResults.vocabResults.length === 0),
      currentPage: (state: any) => state.search.searchResults.currentPage,
      currentPage: (state: any) => state.search.searchResults.totalPages,
      showPrevious: (state: any) => state.search.searchResults.currentPage > 1,
      showNext: (state: any) => (state.search.searchResults.currentPage < state.search.searchResults.totalPages),
      searching: (state: any) => state.search.isSearching,
      totalResults: (state: any) => (state.search.searchResults.vocabResults.length * state.search.searchResults.totalPages)
    })
  },
  methods: {
    paginate (page: number) {
      this.$store('paginate', page)
    }
  },
}
</script>
