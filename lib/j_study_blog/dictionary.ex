defmodule JStudyBlog.Dictionary do
  @moduledoc """
  The Dictionary context.
  """

  import Ecto.Query, warn: false
  alias JStudyBlog.Repo

  alias JStudyBlog.Dictionary.Vocab

  @doc """
  Returns the list of vocabs.

  ## Examples

      iex> list_vocabs()
      [%Vocab{}, ...]

  """
  def list_vocabs do
    query = from(v in Vocab,
            where: is_nil(v.primary_kanji_id),
            limit: 25)
    Repo.all(query)
    |> Repo.preload([:alternate_readings, :meanings, :parts_of_speech])
  end

  @doc """
  Gets a single vocab.

  Raises `Ecto.NoResultsError` if the Vocab does not exist.

  ## Examples

      iex> get_vocab!(123)
      %Vocab{}

      iex> get_vocab!(456)
      ** (Ecto.NoResultsError)

  """
  def get_vocab!(id), do: Repo.get!(Vocab, id)

  @doc """
  Creates a vocab.

  ## Examples

      iex> create_vocab(%{field: value})
      {:ok, %Vocab{}}

      iex> create_vocab(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_vocab(attrs \\ %{}) do
    %Vocab{}
    |> Vocab.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a vocab.

  ## Examples

      iex> update_vocab(vocab, %{field: new_value})
      {:ok, %Vocab{}}

      iex> update_vocab(vocab, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_vocab(%Vocab{} = vocab, attrs) do
    vocab
    |> Vocab.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a vocab.

  ## Examples

      iex> delete_vocab(vocab)
      {:ok, %Vocab{}}

      iex> delete_vocab(vocab)
      {:error, %Ecto.Changeset{}}

  """
  def delete_vocab(%Vocab{} = vocab) do
    Repo.delete(vocab)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking vocab changes.

  ## Examples

      iex> change_vocab(vocab)
      %Ecto.Changeset{source: %Vocab{}}

  """
  def change_vocab(%Vocab{} = vocab) do
    Vocab.changeset(vocab, %{})
  end


  def search_by_kanji(kanji) do
    like = "%#{kanji}%"
    query = from(v in Vocab,
            where: is_nil(v.primary_kanji_id) and like(v.kanji, ^like),
            limit: 25)
    vocabs = Repo.all(query)
    |> Repo.preload([:alternate_readings, :meanings, :parts_of_speech])

    %{vocabs: vocabs}
  end
end
