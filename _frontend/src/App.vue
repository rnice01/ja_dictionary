<template>
  <v-app>
      <v-app-bar density="compact">
      <v-app-bar-title>JA Study Tools</v-app-bar-title>
  
      <v-spacer></v-spacer>
  
      <v-btn text><router-link class="nav-link" to="/">Home</router-link></v-btn>
  
      <v-btn class="mr-3" text><router-link class="nav-link" to="/about">About</router-link></v-btn>
  
      <v-divider inset vertical></v-divider>
  
      <v-btn
        class="mr-4 ml-5"
        color="primary"
        plain
      >
        <v-icon left icon="mdi-handshake-outline"></v-icon>
        <span>JST</span>
      </v-btn>
    </v-app-bar>
    <v-main>
      <router-view/>
    </v-main>
  </v-app>
</template>

<script lang="ts">
import { defineComponent } from 'vue'

export default defineComponent({
  name: 'App',

  data () {
    return {
      //
    }
  }
})
</script>
