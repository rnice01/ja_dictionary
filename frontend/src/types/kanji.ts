class Kanji {
  character = ''
  grade = ''
  jlptLevel = 0
  kunyomi: Array<string> = []
  onyomi: Array<string> = []
  meanings: Array<string> = []
  strokeCount = 0

  constructor (char: string, grade: string, jlptLevel: number, kunyomi: Array<string>, onyomi: Array<string>, meanings: Array<string>, strokes: number) {
    this.character = char
    this.grade = grade
    this.jlptLevel = jlptLevel
    this.kunyomi = kunyomi
    this.onyomi = onyomi
    this.meanings = meanings
    this.strokeCount = strokes
  }
}

export default Kanji
