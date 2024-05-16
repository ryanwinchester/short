defmodule ShortWeb.UrlLiveTest do
  use ShortWeb.ConnCase

  import Phoenix.LiveViewTest
  import Short.LinksFixtures

  @create_attrs %{short: "some short", full: "some full", expires_at: "2024-05-14T22:18:00Z"}
  @update_attrs %{short: "some updated short", full: "some updated full", expires_at: "2024-05-15T22:18:00Z"}
  @invalid_attrs %{short: nil, full: nil, expires_at: nil}

  defp create_url(_) do
    url = url_fixture()
    %{url: url}
  end

  describe "Index" do
    setup [:create_url]

    test "lists all urls", %{conn: conn, url: url} do
      {:ok, _index_live, html} = live(conn, ~p"/urls")

      assert html =~ "Listing Urls"
      assert html =~ url.short
    end

    test "saves new url", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/urls")

      assert index_live |> element("a", "New Url") |> render_click() =~
               "New Url"

      assert_patch(index_live, ~p"/urls/new")

      assert index_live
             |> form("#url-form", url: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#url-form", url: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/urls")

      html = render(index_live)
      assert html =~ "Url created successfully"
      assert html =~ "some short"
    end

    test "updates url in listing", %{conn: conn, url: url} do
      {:ok, index_live, _html} = live(conn, ~p"/urls")

      assert index_live |> element("#urls-#{url.id} a", "Edit") |> render_click() =~
               "Edit Url"

      assert_patch(index_live, ~p"/urls/#{url}/edit")

      assert index_live
             |> form("#url-form", url: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#url-form", url: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/urls")

      html = render(index_live)
      assert html =~ "Url updated successfully"
      assert html =~ "some updated short"
    end

    test "deletes url in listing", %{conn: conn, url: url} do
      {:ok, index_live, _html} = live(conn, ~p"/urls")

      assert index_live |> element("#urls-#{url.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#urls-#{url.id}")
    end
  end

  describe "Show" do
    setup [:create_url]

    test "displays url", %{conn: conn, url: url} do
      {:ok, _show_live, html} = live(conn, ~p"/urls/#{url}")

      assert html =~ "Show Url"
      assert html =~ url.short
    end

    test "updates url within modal", %{conn: conn, url: url} do
      {:ok, show_live, _html} = live(conn, ~p"/urls/#{url}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Url"

      assert_patch(show_live, ~p"/urls/#{url}/show/edit")

      assert show_live
             |> form("#url-form", url: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#url-form", url: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/urls/#{url}")

      html = render(show_live)
      assert html =~ "Url updated successfully"
      assert html =~ "some updated short"
    end
  end
end
