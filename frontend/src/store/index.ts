import { Vocab } from '@/types/vocab'
import Vue from 'vue'
import Vuex from 'vuex'
import { ActionContext } from 'vuex'
import { Api } from '../api'

Vue.use(Vuex)

const api = new Api()

interface RootState {
  error: null
}

export interface SearchResults {
    totalPages: number,
    vocabResults: Vocab[]
}

interface SearchState {
  searchResults: SearchResults
  currentPage: number,
  searchTerm: string
  isSearching: boolean,
  searchPerformed: boolean,
}

type SearchContext = ActionContext<SearchState, RootState>

const searchModule = {
  state: (): SearchState => ({
    searchResults: {
      totalPages: 0,
      vocabResults: []
    },
    currentPage: 1,
    searchTerm: '',
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
    },
    searchPerformed: (state: SearchState) => {
      state.searchPerformed = true
    },
    setSearchTerm: (state: SearchState, searchTerm: string) => {
      state.searchTerm = searchTerm
    },
    setCurrentPage: (state: SearchState, page: number) => {
      state.currentPage = page
    }
  },
  actions: {
    paginate: (context: SearchContext, page: number) => {
        context.commit('isSearching', true)
	context.commit('setCurrentPage', page)
	api.search(context.state.searchTerm, page)
	  .then(results => {
            context.commit('isSearching', false)
	    context.commit('updateSearchResults', {vocab: results.vocabResults, totalPages: results.totalPages})
	  })
	  .catch(res => {
            context.commit('setError', 'Uh oh, something bad happened. Please contact administrator is issue persists')
	  })
    },
    search: (context: SearchContext, searchTerm: string) => {
      context.commit('isSearching', true)
      context.commit('setSearchTerm', searchTerm)
      api.search(searchTerm)
        .then(results => {
          context.commit('isSearching', false)
          context.commit('updateSearchResults', {vocab: results.vocabResults, totalPages: results.totalPages})
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
