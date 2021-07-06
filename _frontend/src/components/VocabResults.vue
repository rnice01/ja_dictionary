<template>
  <div class="d-flex flex-wrap justify-content-center col-12">
    <div v-for="v in vocabResults" :key="'vocab-result-' + v.id" class="card mb-3 col-md-3 col-6 mx-1 my-1 bg-dark">
      <div class="row g-0 card-body text-center">
        <template v-if="v.term">
          <strong class="display-5">{{v.term}}</strong>
          <strong>{{v.reading}}</strong>
        </template>
        <template v-else>
          <strong class="display-5">{{v.reading}}</strong>
        </template>
      </div>
      <div class="row g-0 card-body">
        <div class="card-text">{{v.partsOfSpeech}}</div>
      </div>
      <div class="card-footer p-2">
        <p>{{v.meanings}}</p>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { Vocab } from '../types/vocab'
import { defineComponent, computed, PropType } from 'vue'

export default defineComponent({
  props: {
    vocabResults: Array as PropType<Vocab[]>
  },
  setup (props) {
    const vocabResults = computed(() => {
      return props.vocabResults?.map((v: Vocab) => {
        return {
          term: v.term,
          reading: v.reading,
          meanings: v.meanings.join(', '),
          partsOfSpeech: v.partsOfSpeech.join(', ')
        }
      }) || []
    })
    return {
      vocabResults
    }
  }
})
</script>

<style lang="scss">
.kanji-result {
  &__character {
    font-size: 4rem;
  }
}
</style>
