import { createStore } from 'vuex'
import { Vocab } from '../../types/vocab'
import { DictionaryApi } from '../../api'

const vocabResults: Array<Vocab> = []

export const actions = {
  SEARCH: 'searching',
  PAGINATE: 'paginating results'
}

interface UpdateSearchResultsPayload {
  vocabResults: Array<Vocab>
  totalPages: number
  currentPage: number 
  resultsCount: number
}

interface PaginatePayload {
  currentPage: number
  vocabResults: Array<Vocab>
}
const api = new DictionaryApi()



export default createStore({
  state: {
    vocabResults: vocabResults,
    totalPages: 0,
    resultsCount: 0,
    currentPage: 0,
    isSearching: false
  },
  mutations: {
    updateSearchState (state, payload: any) {
      state = {
        ...state,
        ...payload
      }
    }
  },
  actions: {
    [actions.SEARCH] ({ commit }, payload: string) {
      commit('updateSearchState', { isSearching: true })
      api.search(payload)
        .then(results => {
        commit('updateSearchState', {
          isSearching: false,
          searchDone: true,
          vocabResults: results.vocabResults,
          currentPage: results.currentPage,
          totalPages: results.totalPages,
          })
        })
    },
    [actions.PAGINATE] ({ commit }, payload: PaginatePayload) {
      commit('updateSearchState', payload)
    }
  },
  getters: {
    vocabResults (state) {
      return state.vocabResults
    },
    totalPages (state) {
      return state.totalPages
    },
    resultsCount (state) {
      return state.resultsCount
    },
    currentPage (state) {
      return state.currentPage
    }
  },
  modules: {
  }
})
