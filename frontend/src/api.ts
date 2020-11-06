import Kanji from './types/kanji'
import { Vocab, VocabAlternateReading } from './types/vocab'

interface DictionaryApiInterface {
  search (searchTerm: string): Promise<Array<Vocab>>;
}

export class DictionaryApi implements DictionaryApiInterface {
  search (searchTerm: string): Promise<Array<Vocab>> {
    return new Promise((resolve, reject) => {
      fetch('/api/v1/dictionary/search', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ term: searchTerm })
      })
        .then(res => res.json())
        .then(results => {
          const vocab = results.data.map((v: any) => {
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
          resolve(vocab)
        })
        .catch(err => {
          reject(err)
        })
    })
  }
}
