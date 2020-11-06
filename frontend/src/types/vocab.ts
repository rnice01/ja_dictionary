import Kanji from './kanji'

export class VocabAlternateReading {
  kanji = ''
  kana = ''
  constructor (kanji: string, kana: string) {
    this.kanji = kanji
    this.kana = kana
  }
}

export class Vocab {
  kanjiReading = ''
  kana = ''
  meanings: Array<string> = []
  partsOfSpeech: Array<string> = []
  alternateReadings: Array<VocabAlternateReading> = []
  kanji: Array<Kanji> = []

  constructor (kanjiReading: string, kana: string, meanings: Array<string>, partsOfSpeech: Array<string>, alternateReadings: Array<VocabAlternateReading> = [], kanji: Array<Kanji> = []) {
    this.kanjiReading = kanjiReading
    this.kana = kana
    this.meanings = meanings
    this.partsOfSpeech = partsOfSpeech
    this.alternateReadings = alternateReadings
    this.kanji = kanji
  }

  addAlternateReading (kanji: string, kana: string) {
    this.alternateReadings = [
      ...this.alternateReadings,
      new VocabAlternateReading(kanji, kana)
    ]
  }

  addKanji (kanji: Kanji) {
    this.kanji = [
      ...this.kanji,
      kanji
    ]
  }
}
