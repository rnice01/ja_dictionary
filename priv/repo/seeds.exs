# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     JStudyBlog.Repo.insert!(%JStudyBlog.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


defmodule VocabCreator do
  alias Ecto.Multi
  def create_vocab(vocab) do
    Multi.new()
    |> Multi.insert(JStudyBlog.Dictionary.Vocab, vocab)
    |> Repo.transaction()
  end
end

#VocabCreator.create_vocab(Enum.at(vocabs, 0))
Enum.each(vocabs, fn v -> VocabCreator.print_it(v) end)