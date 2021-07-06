<template>
  <div class="d-flex flex-wrap justify-content-center col-12">
    <div v-for="k in kanjiResults" :key="'kanji-result-' + k.id" class="card mb-3 col-md-3 col-6 mx-1 my-1 bg-dark">
      <div class="row g-0 card-body">
        <div class="col-md-4 d-flex flex-wrap">
          <strong class="display-2">{{k.character}}</strong>
          <strong>{{k.strokeCount}} strokes</strong>
        </div>
        <div class="col-md-8">
          <div class="card-body">
            <div class="card-text mb-1"><strong>Onyomi: </strong>{{k.onyomi}}</div>
            <div class="card-text"><strong>Kunyomi: </strong>{{k.kunyomi}}</div>
          </div>
        </div>
      </div>
      <div class="row g-0 card-body">
        <div class="card-text"><strong>Grade: </strong>{{k.grade}}</div>
        <div class="card-text"><strong>JLPT Level: </strong>{{k.jlptLevel}}</div>
      </div>
      <div class="card-footer p-2">
        <p>{{k.meanings}}</p>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import Kanji from '../types/kanji'
import { defineComponent, computed, PropType } from 'vue'

export default defineComponent({
  props: {
    kanjiResults: Array as PropType<Kanji[]>
  },
  setup (props) {
    const kanjiResults = computed(() => {
      return props.kanjiResults?.map((k: Kanji) => {
        return {
          character: k.character,
          strokeCount: k.strokeCount,
          grade: k.grade,
          jlptLevel: k.jlptLevel,
          onyomi: k.onyomi.join(',  '),
          kunyomi: k.kunyomi.join(', '),
          meanings: k.meanings.join(', ')
        }
      }) || []
    })
    return {
      kanjiResults
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
