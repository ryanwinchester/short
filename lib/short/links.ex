defmodule Short.Links do
  @moduledoc """
  The Links context.
  """

  import Ecto.Query, warn: false
  alias Short.Repo

  alias Short.Links.URL

  @doc """
  Returns the list of urls.

  ## Examples

      iex> list_urls()
      [%URL{}, ...]

  """
  def list_urls do
    Repo.all(URL)
  end

  @doc """
  Gets a single url.

  Raises `Ecto.NoResultsError` if the URL does not exist.

  ## Examples

      iex> get_url!(123)
      %URL{}

      iex> get_url!(456)
      ** (Ecto.NoResultsError)

  """
  def get_url!(id), do: Repo.get!(URL, id)

  @doc """
  Updates the counter and fetches a URL.
  """
  def fetch_and_increment_url_by_short(short) do
    query =
      from u in URL,
        where: u.short == ^short,
        update: [inc: [count: 1]],
        select: u

    case Repo.update_all(query, []) do
      {1, [url]} -> {:ok, url}
      _ -> :error
    end
  end

  @doc """
  Gets a URL by the short link.
  """
  def get_url_by_short(short) do
    Repo.get_by(URL, short: short)
  end

  @doc """
  Creates a url.

  ## Examples

      iex> create_url(%{field: value})
      {:ok, %URL{}}

      iex> create_url(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_url(attrs \\ %{}) do
    %URL{}
    |> URL.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a url.

  ## Examples

      iex> update_url(url, %{field: new_value})
      {:ok, %URL{}}

      iex> update_url(url, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_url(%URL{} = url, attrs) do
    url
    |> URL.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a url.

  ## Examples

      iex> delete_url(url)
      {:ok, %URL{}}

      iex> delete_url(url)
      {:error, %Ecto.Changeset{}}

  """
  def delete_url(%URL{} = url) do
    Repo.delete(url)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking url changes.

  ## Examples

      iex> change_url(url)
      %Ecto.Changeset{data: %URL{}}

  """
  def change_url(%URL{} = url, attrs \\ %{}) do
    URL.changeset(url, attrs)
  end
end
