defmodule ShortWeb.URLLive.Show do
  use ShortWeb, :live_view

  alias Short.Links

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:url, Links.get_url!(id))}
  end

  defp page_title(:show), do: "Show URL"
  defp page_title(:edit), do: "Edit URL"
end
