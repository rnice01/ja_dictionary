<template>
  <v-app>
    <v-card class="overflow-hidden">
      <v-app-bar
        color="primary"
        dark
        prominent
      >
        <v-app-bar-nav-icon></v-app-bar-nav-icon>
        <v-toolbar-title class="accent--text">JA Study Tools</v-toolbar-title>
        <v-spacer></v-spacer>
        <v-btn text class="mr-3"><router-link class="accent--text text-subtitle-1 font-weight-bold text-decoration-none" to="/">Home</router-link></v-btn>
        <v-btn text><router-link class="accent--text text-subtitle-1 font-weight-bold text-decoration-none" to="/about">About</router-link></v-btn>
        <v-btn text><router-link class="accent--text text-subtitle-1 font-weight-bold text-decoration-none" to="/tokenizer">Tokenizer</router-link></v-btn>
      </v-app-bar>
    </v-card>
    <v-main>
      <v-container>
        <router-view/>
      </v-container>
    </v-main>
  </v-app>
</template>

<script lang="ts">
import Vue from 'vue'

export default Vue.extend({
  name: 'App',

  data: () => ({
    //
  })
})
</script>
