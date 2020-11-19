defmodule JaStudyToolsWeb.API.SearchView do
  use JaStudyToolsWeb, :view
  alias JaStudyToolsWeb.SearchView

  def render("results_paginated.json", %{vocab: vocab, current_page: cp, total_pages: tp}) do
    %{
      data: %{
        currentPage: cp,
        totalPages: tp,
        resultsCount: length(vocab),
        vocabResults: Enum.map(vocab, fn v -> 
          %{id: v.id,
            kanji_reading: v.kanji_reading,
            kana: v.kana,
            meanings: v.meanings,
            parts_of_speech: v.parts_of_speech,
            alternate_readings: Enum.map(v.alternate_readings, fn ar -> %{kanji: ar.kanji, kana: ar.kana} end)
          }
        end)
      }
    }
  end

  def render("results.json", %{vocab: vocab}) do
    %{
      data: %{
        resultsCount: length(vocab),
        vocabResults: Enum.map(vocab, fn v -> 
          %{id: v.id,
            kanji_reading: v.kanji_reading,
            kana: v.kana,
            meanings: v.meanings,
            parts_of_speech: v.parts_of_speech,
            alternate_readings: Enum.map(v.alternate_readings, fn ar -> %{kanji: ar.kanji, kana: ar.kana} end)
          }
        end)
      }
    }
  end

  def render("results.json", %{kanji: kanji}) do
    %{data: Enum.map(kanji, fn k -> 
      %{
        id: k.id,
        character: k.character,
        kunyomi: k.kunyomi,
        onyomi: k.onyomi,
        meanings: k.meanings,
        stroke_count: k.stroke_count,
        jlpt_level: k.jlpt_level,
        grade: k.grade
      }
    end)
    }
  end
end
