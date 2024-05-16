defmodule Short.LinksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Short.Links` context.
  """

  @doc """
  Generate a url.
  """
  def url_fixture(attrs \\ %{}) do
    {:ok, url} =
      attrs
      |> Enum.into(%{
        expires_at: ~U[2024-05-14 22:18:00Z],
        full: "some full",
        short: "some short"
      })
      |> Short.Links.create_url()

    url
  end
end
