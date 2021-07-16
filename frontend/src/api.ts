import Kanji from './types/kanji'
import { Vocab } from './types/vocab'

export type SearchResult = {
  searchTerm: string
  resultsCount: number 
  currentPage: number 
  totalPages: number
  vocabResults: Array<Vocab>
  kanjiResults: Array<Kanji>
}

export type TokenizationResult = {
  text: string
}

export interface ApiInterface {
  search (searchTerm: string, page?: number): Promise<SearchResult>;
  tokenize (unparsed: string): Promise<TokenizationResult>;
}

/**
 * Builds the SearchResult from the HTTP Response.
 *
 * @param res HTTP Response
 *
 * @return SearchResult
 */
function buildSearchResult (res: any): SearchResult {
  return {
    searchTerm: '',
    resultsCount: Number(res.data.resultsCount),
    totalPages: res.data.totalPages,
    currentPage: res.data.currentPage,
    vocabResults: res.data.vocabResults.map((v: any) => {
    return new Vocab(
      v.id,
      v.term,
      v.reading,
      v.meanings,
      v.parts_of_speech
    )
  }),
  kanjiResults: [] as Kanji[]
  }
}

export class Api implements ApiInterface {
  search (searchTerm: string, page = 1): Promise<SearchResult> {
    return new Promise((resolve, reject) => {
      fetch(`/api/v1/dictionary/search?term=${searchTerm}&page=${page}`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        }
      })
        .then(res => res.json())
        .then(res => {
          resolve(buildSearchResult(res))
        })
        .catch(err => {
          reject(err)
        })
    })
  }

  tokenize(unparsed: string): Promise<TokenizationResult> {
    return new Promise((resolve, reject) => {
      fetch(`/api/v1/tokenize`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ text: unparsed })
      })
      .then(res => res.json())
      .then(res => {
        resolve(res.data)
      })
      .catch(err => {
        reject(err)
      })
    })
  }
}
