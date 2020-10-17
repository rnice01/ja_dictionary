<template>
  <div>
    <div class="form-group">
      <label for="dictionary-search">Search Bar</label>
      <input id="dictionary-search" type="text" class="form-control" v-model="state.kanjiBeingSearched" />
    </div>
    <div class="form-group">
      <button type="button" class="btn btn-primary" @click="performSearch" @keyup.enter="performSearch">Search</button>
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
    const state = reactive({
      results: [],
      kanjiBeingSearched: '',
      kanji: {}
    })
    const api = new DictionaryApi()

    onBeforeMount(() => {
      fetch('/api/v1/dictionary/search')
        .then(res => res.json())
        .then(data => {
          state.results = data.data.kanji
        })
    })

    const performSearch = () => {
      api.findKanjiByCharacter(state.kanjiBeingSearched)
        .then(k => {
          state.kanji = k
        })
    }

    return {
      state,
      findKanjiByCharacter
    }
  }
})
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss">
</style>
