<template>
  <div>
    <template v-if="hasResults">
        <p>{{resultsCount}} results found</p>
      <VocabResults :vocabResults="vocabResults" />
      <Pagination :currentPage="currentPage" :totalPages="totalPages" @pageClicked="emitPageClicked" />
    </template>
    <template v-if="noResults">
      <p>No results found</p>
    </template>
    <template v-if="searchInProgress">
      <p>Search in progress...</p>
    </template>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import VocabResults from './VocabResults.vue'
import Pagination from './Pagination.vue'

export default defineComponent({
  props: {
    isSearching: {
      type: Boolean,
      default: false 
    },
    searchDone: {
      type: Boolean,
      default: false
    },
    resultsCount: {
      type: Number,
      default: 0
    },
    vocabResults: {
      type: Array,
      default: () => { return [] }
    },
    currentPage: {
      type: Number,
      default: 1
    },
    totalPages: {
      type: Number,
      default: 1
    }
  },
  components: { VocabResults, Pagination },
  data () {
    return {
      localIsSearching: this.isSearching,
      vocabResults: this.vocabResults,
      resultsCount: this.resultsCount,
      searchDone: this.searchDone,
      currentPage: this.currentPage,
      totalPages: this.totalPages
    }
  },
  computed: {
    hasResults (): boolean {
      return this.searchDone && this.resultsCount > 0
    },
    noResults (): boolean {
      return this.searchDone && this.resultsCount === 0
    },
    previousPage (): number {
      return this.currentPage - 1
    },
    nextPage (): number {
      return this.currentPage + 1
    },
    showPrevious (): boolean {
      return this.currentPage > 1
    },
    showNext (): boolean {
      return this.currentPage < this.totalPages
    }
  },
  methods: {
    emitPageClicked (page: number) {
      this.$emit('paginate', page)
    }
  }
})
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss">
</style>
