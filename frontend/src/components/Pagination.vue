<template>
  <div class="text-center">
    <p>{{currentPage}} of {{totalPages}}</p>
    <div class="btn-group" role="group" aria-label="Basic outlined example">
      <v-btn
       :disabled=!showPrevious
        data-test-id="previous-page-btn"
        class="mr-2"
        @click="paginatePrevious"
      ><v-icon large color="secondary">mdi-chevron-left</v-icon></v-btn>
    <v-btn
     :disabled=!showNext
      data-test-id="next-page-btn"
      @click="paginateNext"
      ><v-icon large color="secondary">mdi-chevron-right</v-icon></v-btn>
    </div>
  </div>
</template>

<script lang="ts">
export default {
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
    paginateNext () {
      this.$emit('page-clicked', this.currentPage + 1)
    },
    paginatePrevious () {
      this.$emit('page-clicked', this.currentPage - 1)
    }
  }
}
</script>
