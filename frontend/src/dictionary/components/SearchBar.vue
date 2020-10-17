<template>
  <div>
    <div class="form-group">
      <label for="dictionary-search">Search Bar</label>
      <input id="dictionary-search" type="text" class="form-control" @keyup.enter="performSearch" v-model="state.searchTerm" />
    </div>
    <div class="form-group">
      <button type="button" class="btn btn-primary" @click="performSearch" >Search</button>
    </div>
    <div>
      <ul>
        <li v-for="r in state.results" v-bind:key="`s-r-${r.id}`">
          {{r.character}}
        </li>
      </ul>
    </div>
  </div>
</template>

<script lang="ts">
import { reactive, onBeforeMount, defineComponent } from 'vue'
import { DictionaryApi } from '../../api'
import Kanji from '../../types/kanji'

export default defineComponent({
  setup () {
    const kanjiResults: Array<Kanji> = []
    const state = reactive({
      results: kanjiResults,
      searchTerm: '',
    })
    const api = new DictionaryApi()

    const performSearch = () => {
      api.searchKanjiDictionary(state.searchTerm)
        .then(kanji => {
          state.results = kanji
        })
    }

    return {
      state,
      performSearch
    }
  }
})
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss">
</style>
