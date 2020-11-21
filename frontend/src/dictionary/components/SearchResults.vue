<template>
  <div>
    <template v-if="hasResults">
        <p>{{resultsCount}} results found</p>
        <div class="btn-group" role="group" aria-label="Basic outlined example">
        <button
         :disabled=!showPrevious
          type="button"
          class="btn btn-outline-primary"
          data-test-id="previous-page-btn"
          @click="() => { pageClicked(previousPage) }"
        ><i class="gg-chevron-left"></i></button>
      <button
       :disabled=!showNext
        type="button"
        class="btn btn-outline-primary"
        data-test-id="next-page-btn"
        @click="() => { pageClicked(nextPage) }"
        ><i class="gg-chevron-right"></i></button>
      </div>
      <VocabResults :vocabResults="vocabResults"></VocabResults>
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
import 'css.gg/icons/css/chevron-right.css'
import 'css.gg/icons/css/chevron-left.css'


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
  components: { VocabResults },
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
    pageClicked (page: number) {
      this.$emit('page-clicked', page)
    }
  }
})
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss">
</style>
