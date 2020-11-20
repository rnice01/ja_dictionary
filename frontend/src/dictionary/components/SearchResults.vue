<template>
  <div>
    <template v-if="hasResults">
        <p>{{resultsCount}} results found</p>
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
    }
  },
  components: { VocabResults },
  data () {
    return {
      searchInProgress: this.isSearching,
      vocabResults: this.vocabResults,
      resultsCount: this.resultsCount,
      searchDone: this.searchDone
    }
  },
  computed: {
    hasResults (): boolean {
      return this.searchDone && this.resultsCount > 0
    },
    noResults (): boolean {
      return this.searchDone && this.resultsCount === 0
    }
  }
})
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss">
</style>
