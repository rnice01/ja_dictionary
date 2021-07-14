<template>
  <v-layout
    row 
    wrap
  >
    <v-card 
      color="blue-grey darken-4"
      class="mx-auto my-3"
      width="100%"
      max-width="344"
      v-for="v in vocabResults" :key="'vocab-result-' + v.id"
      >
      <v-card-text>
        <p class="text-h4"><ruby>{{v.term}}<rt>{{v.reading}}</rt></ruby></p>
        <p>{{v.partsOfSpeech}}</p>
        <v-divider></v-divider>
        <p>{{v.meanings}}</p>
      </v-card-text>
    </v-card>
  </v-layout>
</template>

<script lang="ts">
import { Vocab } from '../types/vocab'
import { PropType } from 'vue'

export default {
  props: {
    vocabResults: Array as PropType<Vocab[]>
  },
  computed: {
    vocabResults () {
      return this.$props.vocabResults?.map((v: Vocab) => {
        return {
          id: v.id,
          term: v.term,
          reading: v.reading,
          meanings: v.meanings.join(', '),
          partsOfSpeech: v.partsOfSpeech.join(', ')
        }
      }) || []
    }
  }
}
</script>

<style lang="scss">
.kanji-result {
  &__character {
    font-size: 4rem;
  }
}
</style>
