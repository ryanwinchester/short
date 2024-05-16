defmodule ShortWeb.URLLive.Index do
  use ShortWeb, :live_view

  alias Short.Links
  alias Short.Links.URL

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :urls, Links.list_urls())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit URL")
    |> assign(:url, Links.get_url!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New URL")
    |> assign(:url, %URL{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing URLs")
    |> assign(:url, nil)
  end

  @impl true
  def handle_info({ShortWeb.URLLive.FormComponent, {:saved, url}}, socket) do
    {:noreply, stream_insert(socket, :urls, url)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    url = Links.get_url!(id)
    {:ok, _} = Links.delete_url(url)

    {:noreply, stream_delete(socket, :urls, url)}
  end
end
