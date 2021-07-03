<template>
  <search-bar/>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import SearchBar from '../components/SearchBar.vue'

export default defineComponent({
  name: 'Home',

  components: {
    SearchBar
  }
})
</script>
