defmodule Short.LinksTest do
  use Short.DataCase

  alias Short.Links

  describe "urls" do
    alias Short.Links.Url

    import Short.LinksFixtures

    @invalid_attrs %{short: nil, full: nil, expires_at: nil}

    test "list_urls/0 returns all urls" do
      url = url_fixture()
      assert Links.list_urls() == [url]
    end

    test "get_url!/1 returns the url with given id" do
      url = url_fixture()
      assert Links.get_url!(url.id) == url
    end

    test "create_url/1 with valid data creates a url" do
      valid_attrs = %{short: "some short", full: "some full", expires_at: ~U[2024-05-14 22:18:00Z]}

      assert {:ok, %Url{} = url} = Links.create_url(valid_attrs)
      assert url.short == "some short"
      assert url.full == "some full"
      assert url.expires_at == ~U[2024-05-14 22:18:00Z]
    end

    test "create_url/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Links.create_url(@invalid_attrs)
    end

    test "update_url/2 with valid data updates the url" do
      url = url_fixture()
      update_attrs = %{short: "some updated short", full: "some updated full", expires_at: ~U[2024-05-15 22:18:00Z]}

      assert {:ok, %Url{} = url} = Links.update_url(url, update_attrs)
      assert url.short == "some updated short"
      assert url.full == "some updated full"
      assert url.expires_at == ~U[2024-05-15 22:18:00Z]
    end

    test "update_url/2 with invalid data returns error changeset" do
      url = url_fixture()
      assert {:error, %Ecto.Changeset{}} = Links.update_url(url, @invalid_attrs)
      assert url == Links.get_url!(url.id)
    end

    test "delete_url/1 deletes the url" do
      url = url_fixture()
      assert {:ok, %Url{}} = Links.delete_url(url)
      assert_raise Ecto.NoResultsError, fn -> Links.get_url!(url.id) end
    end

    test "change_url/1 returns a url changeset" do
      url = url_fixture()
      assert %Ecto.Changeset{} = Links.change_url(url)
    end
  end
end
