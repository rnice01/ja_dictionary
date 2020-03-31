defmodule JStudyBlog.Factory do
  use ExMachina.Ecto, repo: JStudyBlog.Repo
  alias JStudyBlog.Dictionary.Vocab
  alias JStudyBlog.Dictionary.VocabMeaning
  alias JStudyBlog.Dictionary.PartOfSpeech
  alias JStudyBlog.Dictionary.VocabPartsOfSpeech

  def vocab_factory(attrs) do
    %Vocab{
      kanji: Map.get(attrs, :kanji, "some kanji"),
      kana: Map.get(attrs, :kana, "some kana"),
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

  def vocab_parts_of_speech_factory(attrs) do
    %VocabPartsOfSpeech{
      vocab_id: Map.get(attrs, :vocab_id),
      parts_of_speech_id: Map.get(attrs, :pos_id)
    }
  end

  def vocab_with_parts_of_speech_factory(attrs) do
    vocab = insert(:vocab, attrs)
    pos = insert(:part_of_speech)
    insert(:vocab_parts_of_speech, %{vocab_id: vocab.id, pos_id: pos.id})
    %VocabPartsOfSpeech{
      vocab_id: vocab.id,
      parts_of_speech_id: pos.id
    }
    %{
      id: vocab.id,
      kanji: vocab.kanji,
      kana: vocab.kana,
      meanings: vocab.meanings,
      alternate_readings: vocab.alternate_readings,
      parts_of_speech: [
        pos
      ]
    }
  end
end
