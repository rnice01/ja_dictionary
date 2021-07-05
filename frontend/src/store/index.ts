import { Vocab } from '@/types/vocab'
import Vue from 'vue'
import Vuex from 'vuex'
import { ActionContext } from 'vuex'
import { DictionaryApi } from '../api'

Vue.use(Vuex)

const api = new DictionaryApi()

interface RootState {
  error: null
}

export interface SearchResults {
    currentPage: number,
    totalPages: number,
    vocabResults: Vocab[]
}

interface SearchState {
  searchResults: SearchResults
  isSearching: boolean,
  searchPerformed: boolean,
}

type SearchContext = ActionContext<SearchState, RootState>

const searchModule = {
  state: (): SearchState => ({
    searchResults: {
      currentPage: 0,
      totalPages: 0,
      vocabResults: []
    },
    isSearching: false,
    searchPerformed: false
  }),
  mutations: {
    isSearching: (state: SearchState, isSearching: boolean) => {
      state.isSearching = isSearching
    },
    updateSearchResults: (state: SearchState, payload: any) => {
      state.searchResults.vocabResults = payload.vocab
      state.searchResults.totalPages = payload.totalPages
      state.searchResults.currentPage = payload.currentPage
    },
    searchPerformed: (state: SearchState) => {
      state.searchPerformed = true
    }
  },
  actions: {
    search: (context: SearchContext, searchTerm: string) => {
      context.commit('isSearching', true)
      api.search(searchTerm)
        .then(results => {
          context.commit('isSearching', false)
          context.commit('updateSearchResults', {vocab: results.vocabResults, currentPage: results.currentPage, totalPages: results.totalPages})
        })
        .catch(res => {
          context.commit('setError', 'Unable to perform search')
        })
        .finally(() => {
          context.commit('searchPerformed')
        })
    }
  },
  getters: {
    searchResults: (state: SearchState): SearchResults  => {
      return state.searchResults
    },
    resultsCount: (state: SearchState): number => {
      return state.searchResults.vocabResults.length * state.searchResults.totalPages
    }
  }
}

export default new Vuex.Store({
  state: {
    error: null
  },
  mutations: {
    setError: (state: RootState, error) => {
      state.error = error
    }
  },
  actions: {
  },
  getters: {
    error: (state: RootState) => {
      return state.error
    }
  },
  modules: {
    search: searchModule
  }
})
