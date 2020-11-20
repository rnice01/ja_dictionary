<template>
  <div>
    <button v-if="showPrevious" class="btn btn-primary" id="previous-page-btn" @click="() => { pageClicked(previousPage) }">Previous</button>
    <button v-if="showNext" class="btn btn-primary" id="next-page-btn" @click="() => { pageClicked(nextPage) }">Next</button>
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
