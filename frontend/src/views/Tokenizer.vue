<template>
<div>
  <v-textarea 
    label="Enter Japanese text to parse"
    filled
    auto-grow
    clearable
    v-model="input"
    @change="tokenize"
    />
    <div>{{tokenized}}</div>
</div>
</template>

<script lang="ts">
import { Api } from '../api'
const api = new Api()
type TokenizerState = {
  input: string,
  tokenized: string
}

export default {
  name: 'Parser',
  data: (): TokenizerState => {
    return {
      input: '',
      tokenized: 'fkal;sfjlsdjfalsdajfl'
    }
  },
  methods: {
    tokenize (text) {
      api.tokenize(text).then(res => {
        this.tokenized = res.text
      })
    }
  },
  components: {
  }
}
</script>
