<template>
  <v-form>
    <v-row>
      <v-col
        cols="12"
      >
       <v-text-field
          outlined 
          v-model="searchTerm"
          label="Search by Kanji, Kana, or the English meaning"
          required
          @keyup.enter="performSearch"
        ></v-text-field>
      </v-col>
      <v-btn 
        large 
        no-gutters
        class="secondary"
        @click="performSearch"
        :block="$vuetify.breakpoint.xsOnly"
      >Search</v-btn>
    </v-row>
    <v-row>
      <search-results />
    </v-row>
  </v-form>
</template>

<script lang="ts">
import SearchResults from './SearchResults.vue'

export default {
  data: () => {
    return {
      searchTerm: '',
    }
  },
  methods: {
    performSearch () {
      this.isSearching = true
      this.$router.replace({ path: '/', query: { searchTerm: this.searchTerm } })
      this.$store.dispatch('search', this.searchTerm)
    }
  },
  computed: {
    searchResults () {
      this.$store.getters.searchResults
    }
  },
  components: {
    SearchResults
  }
}
</script>
