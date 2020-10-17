import Kanji from './types/kanji'

interface DictionaryApiInterface {
  searchKanjiDictionary (searchTerm: string): Promise<Array<Kanji>>;
}

export class DictionaryApi implements DictionaryApiInterface {
  searchKanjiDictionary (searchTerm: string): Promise<Array<Kanji>> {
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
          const kanji = results.data.map((k: any) => {
            return new Kanji(
              k.character,
              k.grade,
              k.jlpt_level,
              k.kunyomi,
              k.onyomi,
              k.meanings,
              k.stroke_count
            )
          })
          resolve(kanji)
        })
        .catch(err => {
          reject(err)
        })
    })
  }
}
