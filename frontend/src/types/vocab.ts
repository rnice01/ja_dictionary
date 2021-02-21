import Kanji from './kanji'

export class Vocab {
  term = ''
  reading = ''
  meanings: Array<string> = []
  partsOfSpeech: Array<string> = []
  kanji: Array<Kanji> = []

  constructor (term: string, reading: string, meanings: Array<string>, partsOfSpeech: Array<string>, kanji: Array<Kanji> = []) {
    this.term = term
    this.reading = reading
    this.meanings = meanings
    this.partsOfSpeech = partsOfSpeech
    this.kanji = kanji
  }

  addKanji (kanji: Kanji) {
    this.kanji = [
      ...this.kanji,
      kanji
    ]
  }
}
