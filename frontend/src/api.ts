import Kanji from './types/kanji'
import { Vocab, VocabAlternateReading } from './types/vocab'

interface DictionaryApiInterface {
  search (searchTerm: string): Promise<SearchResult>;
}

class SearchResult {
  searchTerm = ''
  resultsCount = 0
  vocabResults: Array<Vocab> = []
  kanjiResults: Array<Kanji> = []
}

export class DictionaryApi implements DictionaryApiInterface {
  search (searchTerm: string): Promise<SearchResult> {
    return new Promise((resolve, reject) => {
      fetch('/api/v1/dictionary/search', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ term: searchTerm })
      })
        .then(res => res.json())
        .then(res => {
          let searchResult = new SearchResult()
          searchResult.resultsCount = Number(res.data.resultsCount)
          searchResult.vocabResults = res.data.vocabResults.map((v: any) => {
            return new Vocab(
              v.kanji_reading,
              v.kana,
              v.meanings,
              v.parts_of_speech,
              v.alternate_readings.map((ar: any) => {
                return new VocabAlternateReading(ar.kanji, ar.kana)
              }) || []
            )
          })
          resolve(searchResult)
        })
        .catch(err => {
          reject(err)
        })
    })
  }
}
