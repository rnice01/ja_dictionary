import Kanji from './types/kanji'
import { Vocab } from './types/vocab'

export interface DictionaryApiInterface {
  search (searchTerm: string, page?: number): Promise<SearchResult>;
}

export class SearchResult {
  searchTerm = ''
  resultsCount = 0
  currentPage = 1
  totalPages = 1
  vocabResults: Array<Vocab> = []
  kanjiResults: Array<Kanji> = []
}

/**
 * Builds the SearchResult from the HTTP Response.
 *
 * @param res HTTP Response
 *
 * @return SearchResult
 */
function buildSearchResult (res: any): SearchResult {
  const searchResult = new SearchResult()
  searchResult.resultsCount = Number(res.data.resultsCount)
  searchResult.totalPages = res.data.totalPages
  searchResult.currentPage = res.data.currentPage
  searchResult.vocabResults = res.data.vocabResults.map((v: any) => {
    return new Vocab(
      v.id,
      v.term,
      v.reading,
      v.meanings,
      v.parts_of_speech
    )
  })
  return searchResult
}

export class DictionaryApi implements DictionaryApiInterface {
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
}
