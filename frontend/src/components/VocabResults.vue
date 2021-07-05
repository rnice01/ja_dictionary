<template>
  <v-layout
    row 
    wrap
  >
    <v-card 
      class="background mx-auto my-3"
      height="100%"
      width="100%"
      max-width="344"
      v-for="v in vocabResults" :key="'vocab-result-' + v.id"
      >
      <v-card-text>
        <p class="text-h6">{{v.reading}}</p>
        <p class="text-h4">{{v.term}}</p>
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
