<template>
  <div>
    <div class="form-group">
      <label for="dictionary-search">Search</label>
      <input id="dictionary-search" type="text" class="form-control" />
    </div>
    <div>
      <ul>
        <li v-for="r in results" v-bind:key="`s-r-${r.id}`">
          {{r.character}}
        </li>
      </ul>
    </div>
  </div>
</template>

<script lang="ts">
import { Vue } from 'vue-class-component'

export default class SearchBar extends Vue {
  currentSearch: ''
  results: []

  created () {
    fetch('/api/v1/kanji')
      .then(res => res.json())
      .then(data => {
        this.results = data.data.kanji
      })
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss">
</style>
