import { createStore } from 'vuex'
import { Vocab } from '../../types/vocab'

const vocabResults: Array<Vocab> = []

export const actions = {
  UPDATE_SEARCH_RESULTS: 'updating search results'
}

export default createStore({
  state: {
    vocabResults: vocabResults
  },
  mutations: {
    setSearchResults(state, payload: Array<Vocab>) {
      state.vocabResults = payload
    }
  },
  actions: {
    [actions.UPDATE_SEARCH_RESULTS] ({commit}, payload: Array<Vocab>) {
      commit('setSearchResults', payload)
    }
  },
  getters: {

  },
  modules: {
  }
})
