import Kanji from './types/kanji'

interface DictionaryApiInterface {
  findKanjiByCharacter(character: string): Promise<Kanji>;
}

export class DictionaryApi implements DictionaryApiInterface {
  findKanjiByCharacter (character: string): Promise<Kanji> {
    return new Promise((resolve, reject) => {
      fetch('/api/v1/dictionary/search', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ kanji: character })
      })
        .then(res => res.json())
        .then(k => {
          const kanji = new Kanji()
          kanji.character = k.character
          kanji.grade = k.grade
          kanji.jlptLevel = k.jlpt_level
          kanji.kunyomi = k.kunyomi
          kanji.onyomi = k.onyomi
          kanji.meanings = k.meanings
          kanji.strokeCount = k.stroke_count
          resolve(kanji)
        })
        .catch(err => {
          reject(err)
        })
    })
  }
}
