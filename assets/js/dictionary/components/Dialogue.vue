<template>
  <div>
    <div>
      <div class="flex bg-white shadow-lg rounded-lg mx-2 md:mx-auto my-20 md:max-w-2xl" tabindex="0">
        <!--horizantil margin is just for display-->
        <div class="flex items-start px-4 py-6">
          <img
            class="w-12 h-12 rounded-full object-cover mr-4 shadow"
            src="https://animeanime.jp/imgs/zoom/280559.jpg"
            alt="avatar"
          >
          <div class>
            <div class="flex items-center justify-between">
              <h2 class="text-lg font-semibold text-gray-900 -mt-1">ホップ</h2>
            </div>
            <p class="mt-3 text-gray-700">
              {{japanese}}
            </p>
            <hr class="mt-3" />
            <transition name="slide">
              <p class="t-3 text-gray-700" v-if="showTranslation">
                {{english}}
              </p>
            </transition>
            <div class="mt-4 flex items-center">
              <div tabindex="0" role="button" :aria-pressed="showTranslation" class="flex mr-2 text-gray-700 text-sm mr-8 cursor-pointer" v-on:click="toggleShowTranslation">
                <svg
                  fill="currentColor"
                  viewBox="0 0 24 24"
                  class="w-4 h-4 mr-1"
                  stroke="currentColor"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="1"
                    d="M7.41421356,9 L8.29055233,8.12366123 C9.26057586,7.1536377 9.9996249,5.37060807 9.99999986,4 L12,4 L12,2 L7,2 L7,0 L5,0 L5,2 L0,2 L0,4 L7.99999973,4 C7.99956262,4.84020479 7.4713745,6.11441194 6.87633877,6.70944767 L6,7.58578644 L5.12366123,6.70944767 C4.94063656,6.526423 4.76393628,6.27914249 4.6069729,6 L2.40706289,6 L2.40706289,6 C2.71635745,6.81752931 3.17827325,7.59248681 3.70944767,8.12366123 L4.58578644,9 L1.29289322,12.2928932 L2.70710678,13.7071068 L6,10.4142136 L8.81934895,13.2335625 L9.65123928,11.2370257 L7.41421356,9 L7.41421356,9 Z M11.25,17 L10,20 L8,20 L13,8 L14,8 L15,8 L20,20 L18,20 L16.75,17 L11.25,17 L11.25,17 Z M12.0833333,15 L14,10.4 L15.9166667,15 L12.0833333,15 L12.0833333,15 Z"
                  ></path>
                </svg>
                <span>{{showTranslation ? 'Hide' : 'See'}} Translation</span>
              </div>
              <div tabindex="0" role="button" :aria-pressed="showGrammarNotes" class="flex mr-2 text-gray-700 text-sm mr-4 cursor-pointer">
                <svg
                  fill="currentColor"
                  viewBox="0 0 24 24"
                  class="w-4 h-4 mr-1"
                  stroke="currentColor"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="1"
                    d="M4,10 L12,10 L12,12 L4,12 L4,10 L4,10 Z M4,14 L12,14 L12,16 L4,16 L4,14 L4,14 Z M4,4 L12,4 L12,8 L4,8 L4,4 L4,4 Z M16,2 L16,1 L16,0 L0,0 L0,1 L0,1 L0,17.0057979 C0,18.656688 1.34320226,20 3.00012623,20 L17,20 C18.6534829,20 20,18.6601943 20,17.0074602 L20,3 L20,2 L16,2 L16,2 L16,2 Z M16,4 L16,17.0066023 C16,17.5552407 16.4438648,18 17,18 C17.5522847,18 18,17.5553691 18,16.9991283 L18,4 L16,4 L16,4 L16,4 Z M2,2 L14,2 L14,17.0057979 C14,17.3541355 14.0597981,17.6887794 14.1697239,18 L3.00748397,18 C2.44892021,18 2,17.5552407 2,17.0066023 L2,2 L2,2 L2,2 L2,2 Z"
                  ></path>
                </svg>
                <span>Grammar Notes</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import Vue from 'vue'

export default Vue.extend({
  name: 'Dialogue',
  props: {
    japanese: {
      type: String
    },
    english: {
      type: String
    }
  },
  data: function () {
    return {
      showTranslation: false,
      showGrammarNotes: false
    }
  },
  methods: {
    toggleShowTranslation: function () {
      this.showTranslation = !this.showTranslation
    }
  },
  components: {
  }
})
</script>

<style scoped>
  .slide-enter-active {
    -moz-transition-duration: 0.3s;
    -webkit-transition-duration: 0.3s;
    -o-transition-duration: 0.3s;
    transition-duration: 0.3s;
    -moz-transition-timing-function: ease-in;
    -webkit-transition-timing-function: ease-in;
    -o-transition-timing-function: ease-in;
    transition-timing-function: ease-in;
  }

  .slide-leave-active {
    -moz-transition-duration: 0.3s;
    -webkit-transition-duration: 0.3s;
    -o-transition-duration: 0.3s;
    transition-duration: 0.3s;
    -moz-transition-timing-function: cubic-bezier(0, 1, 0.5, 1);
    -webkit-transition-timing-function: cubic-bezier(0, 1, 0.5, 1);
    -o-transition-timing-function: cubic-bezier(0, 1, 0.5, 1);
    transition-timing-function: cubic-bezier(0, 1, 0.5, 1);
  }

  .slide-enter-to, .slide-leave {
    max-height: 200px;
    overflow: hidden;
  }

  .slide-enter, .slide-leave-to {
    overflow: hidden;
    max-height: 0;
  }
</style>
