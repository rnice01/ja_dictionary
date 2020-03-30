defmodule JStudyBlog.Factory do
  use ExMachina.Ecto, repo: JStudyBlog.Repo
  alias JStudyBlog.Dictionary.Vocab
  alias JStudyBlog.Dictionary.VocabMeaning
  alias JStudyBlog.Dictionary.PartOfSpeech
  alias JStudyBlog.Dictionary.VocabPartsOfSpeech

  def vocab_factory do
    %Vocab{
      kanji: "some kanji",
      kana: "some kana",
      meanings: [
        %VocabMeaning{
          definition: "the definition",
          language: "language"
        }
      ],
      alternate_readings: [
        %Vocab{
          kanji: "alternate kanji 1",
          kana: "alternate kana 1"
        }
      ]
    }
  end

  def part_of_speech_factory do
    %PartOfSpeech{
      code: "n",
      description: "noun"
    }
  end

  def vocab_parts_of_speech_factory do
    vocab = insert(:vocab)
    pos = insert(:part_of_speech)
    %VocabPartsOfSpeech{
      vocab_id: vocab.id,
      parts_of_speech_id: pos.id
    }
    %{
      kanji: vocab.kanji,
      kana: vocab.kana,
      parts_of_speech: [
        pos
      ]
    }
  end

  def vocab_with_parts_of_speech_factory do
  end
end
