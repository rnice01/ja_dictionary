<template>
  <div class="text-center">
    <p>{{currentPage}} of {{totalPages}}</p>
    <div class="btn-group" role="group" aria-label="Basic outlined example">
      <button
       :disabled=!showPrevious
        type="button"
        class="btn btn-outline-primary"
        data-test-id="previous-page-btn"
        @click="() => { pageClicked(previousPage) }"
      ><i class="gg-chevron-left"></i></button>
    <button
     :disabled=!showNext
      type="button"
      class="btn btn-outline-primary"
      data-test-id="next-page-btn"
      @click="() => { pageClicked(nextPage) }"
      ><i class="gg-chevron-right"></i></button>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'

export default defineComponent({
  props: {
    currentPage: {
      type: Number,
      default: 1
    },
    totalPages: {
      type: Number,
      default: 1
    }
  },
  data () {
    return {
      currentPage: this.currentPage,
      totalPages: this.totalPages
    }
  },
  computed: {
    previousPage (): number {
      return this.currentPage - 1
    },
    nextPage (): number {
      return this.currentPage + 1
    },
    showPrevious (): boolean {
      return this.currentPage > 1
    },
    showNext (): boolean {
      return this.currentPage < this.totalPages
    }
  },
  methods: {
    pageClicked (page: number) {
      this.$emit('page-clicked', page)
    }
  }
})
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss">
</style>
