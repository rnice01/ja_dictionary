<template>
  <div>
    <button class="btn btn-primary" id="next-page-btn" @click="() => { pageClicked(nextPage) }">Next</button>
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
      currentPage: this.currentPage
    }
  },
  computed: {
    nextPage (): number {
      return this.currentPage + 1
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
