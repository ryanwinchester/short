defmodule ShortWeb.PageController do
  use ShortWeb, :controller

  def index(conn, _params) do
    redirect(conn, to: ~p"/urls")
  end

  def show(conn, %{"short" => short}) do
    case Short.Links.fetch_and_increment_url_by_short(short) do
      {:ok, url} -> redirect(conn, external: url.full)
      :error -> send_resp(conn, 404, "Not Found")
    end
  end
end
