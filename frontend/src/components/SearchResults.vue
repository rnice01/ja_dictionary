<template>
  <div>
    <template v-if="hasResults">
      <v-row class="align-center d-flex flex-wrap-reverse">
        <v-col sm="12" md="6">
          <h4>{{totalResults}} results found</h4>
        </v-col>
        <v-col sm="12" md="6" class="d-flex justify-end">
          <Pagination :currentPage="currentPage" :totalPages="totalPages" @page-clicked="paginate" />
        </v-col>
      </v-row>
      <VocabResults :vocabResults="vocabResults" />
    </template>
    <v-row class="align-center">
      <template v-if="noResults">
        <p>No results found</p>
      </template>
      <template v-if="searching">
        <p>Search in progress...</p>
      </template>
    </v-row>
  </div>
</template>

<script lang="ts">
import VocabResults from './VocabResults.vue'
import Pagination from './Pagination.vue'
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
      currentPage: (state: any) => (state.search.currentPage),
      totalPages: (state: any) => (state.search.searchResults.totalPages + 1),
      showPrevious: (state: any) => state.search.searchResults.currentPage > 1,
      showNext: (state: any) => (state.search.searchResults.currentPage < state.search.searchResults.totalPages),
      searching: (state: any) => state.search.isSearching,
      totalResults: (state: any) => (state.search.searchResults.vocabResults.length * state.search.searchResults.totalPages)
    })
  },
  methods: {
    paginate (page: number) {
      this.$store.dispatch('paginate', page)
    }
  },
}
</script>
