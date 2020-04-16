defmodule JStudyBlog.JDict.XMLParser do
  @behaviour JStudyBlog.JDict.DictionaryParser
  import SweetXml

  @impl JStudyBlog.JDict.DictionaryParser
  def parse_kanji(kanji_stream) do
    kanji = kanji_stream
    |> stream_tags([:character], discard: [:character])
    |> Stream.map(fn
     {_, entry} ->
        %{
        }
    end)
    |> Stream.chunk_every(25)
    |> Enum.to_list()

    {:ok, kanji}
  end

  @impl JStudyBlog.JDict.DictionaryParser
  def parse_vocab(vocab_stream) do
    {:ok, []}
  end
end