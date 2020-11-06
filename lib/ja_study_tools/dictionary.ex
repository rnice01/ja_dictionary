defmodule JaStudyTools.Dictionary do
  @moduledoc """
  The Dictionary context.
  """

  import Ecto.Query, warn: false
  alias JaStudyTools.Repo

  alias JaStudyTools.Dictionary.Kanji

  @doc """
  Returns the list of kanjis.

  ## Examples

      iex> list_kanjis()
      [%Kanji{}, ...]

  """
  def list_kanjis(offset, limit) do
    query = from k in Kanji,
            select: k,
            limit: ^limit,
            offset: ^offset
    Repo.all(query)
  end

  @doc """
  Gets a single kanji.

  Raises `Ecto.NoResultsError` if the Kanji does not exist.

  ## Examples

      iex> get_kanji!(123)
      %Kanji{}

      iex> get_kanji!(456)
      ** (Ecto.NoResultsError)

  """
  def get_kanji!(id), do: Repo.get!(Kanji, id)

  @doc """
  Creates a kanji.

  ## Examples

      iex> create_kanji(%{field: value})
      {:ok, %Kanji{}}

      iex> create_kanji(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_kanji(attrs \\ %{}) do
    %Kanji{}
    |> Kanji.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a kanji.

  ## Examples

      iex> update_kanji(kanji, %{field: new_value})
      {:ok, %Kanji{}}

      iex> update_kanji(kanji, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_kanji(%Kanji{} = kanji, attrs) do
    kanji
    |> Kanji.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a kanji.

  ## Examples

      iex> delete_kanji(kanji)
      {:ok, %Kanji{}}

      iex> delete_kanji(kanji)
      {:error, %Ecto.Changeset{}}

  """
  def delete_kanji(%Kanji{} = kanji) do
    Repo.delete(kanji)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking kanji changes.

  ## Examples

      iex> change_kanji(kanji)
      %Ecto.Changeset{data: %Kanji{}}

  """
  def change_kanji(%Kanji{} = kanji, attrs \\ %{}) do
    Kanji.changeset(kanji, attrs)
  end

  def by_kanji!(kanji) do
    query = from k in Kanji,
            where: k.character == ^kanji
    Repo.all(query)
  end

  def search!(term) do
    query = from k in Kanji,
      where: k.character == ^term 
      or ^term in k.meanings
      or ^term in k.onyomi
      or ^term in k.kunyomi
    Repo.all(query)
  end

  alias JaStudyTools.Dictionary.Vocab

  @doc """
  Returns the list of vocab.

  ## Examples

      iex> list_vocab()
      [%Vocab{}, ...]

  """
  def list_vocab(offset, limit) do
    query = from v in Vocab,
            select: v,
            limit: ^limit,
            offset: ^offset,
            preload: [:kanji]
    Repo.all(query)
  end

  def search_vocab(term) do
    conditions = 
    case String.match?(term, ~r/[a-z]/i) do
      true -> search_by_meaning(term)
      false -> search_by_reading(term)
    end

    query = from v in Vocab,
            where: ^conditions,
            limit: 25

    Repo.all(query)
  end

  defp search_by_meaning(term) do
    dynamic([v], fragment("exists (select * from unnest(?) m WHERE m ilike ?)", v.meanings, ^"%#{term}%"))
  end

  defp search_by_reading(term) do
    like_term = "%#{term}%"
    dynamic([v], like(v.kanji_reading, ^like_term) or like(v.kana, ^like_term))
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
      %Ecto.Changeset{data: %Vocab{}}

  """
  def change_vocab(%Vocab{} = vocab, attrs \\ %{}) do
    Vocab.changeset(vocab, attrs)
  end

  def find_kanji_by_characters(characters) do
    char_list = String.split(characters, "")

    query = from k in Kanji,
      where: k.character in ^char_list

    Repo.all(query)
  end
end
