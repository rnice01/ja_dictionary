<template>
  <div>
    <SearchBar />
  </div>
</template>

<script lang="ts">
import { Options, Vue } from 'vue-class-component'
import SearchBar from '../components/SearchBar.vue'

@Options({
  components: {
    SearchBar
  }
})
export default class Home extends Vue {}
</script>
