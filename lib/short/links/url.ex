defmodule Short.Links.URL do
  use Ecto.Schema
  import Ecto.Changeset

  alias Short.Links

  schema "urls" do
    field :short, :string
    field :full, :string
    field :count, :integer, default: 0
    timestamps(type: :utc_datetime, updated_at: false)
  end

  @doc false
  def changeset(url, attrs) do
    url
    |> cast(attrs, [:full])
    |> put_short_url()
    |> validate_required([:full])
    |> unique_constraint(:short)
  end

  def put_short_url(changeset) do
    short = Short.ShortURL.generate()

    # Avoid collisions by just checking the DB ¯\_(ツ)_/¯.
    case Links.get_url_by_short(short) do
      nil -> put_change(changeset, :short, short)
      _ -> put_short_url(changeset)
    end
  end
end
