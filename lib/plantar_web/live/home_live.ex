defmodule PlantarWeb.HomeLive do
  use PlantarWeb, :live_view

  alias Plantar.{Plant, Search}
  alias PlantarWeb.HomeView

  @crops_per_page 16

  @impl true
  def render(assigns) do
    Phoenix.View.render(HomeView, "index.html", assigns)
  end

  @impl true

  def mount(_params, %{"user_token" => _user_token} = session, socket) do
    {:ok,
     socket
     |> assign_defaults(session)}
  end

  @impl true
  def mount(_params, session, socket) do
    {:ok,
     socket
     |> assign_defaults(session)}
  end

  defp list_crops do
    Plant.list_crops()
  end

  @impl true
  def handle_params(params, _uri, socket) do
    query = String.trim(params["q"] || "")
    search(socket, query)

    {:noreply,
     socket
     |> assign(page: 1)}
  end

  @impl true
  def handle_event("search", %{"search_query" => search_query}, socket) do
    socket =
      socket
      |> search(search_query)

    {:noreply, socket}
  end

  defp search(socket, search_query) do
    offset = (socket.assigns.page - 1) * @crops_per_page

    %{results: results, total_count: total_count} =
      Search.find_crops(search_query, offset: offset, limit: @crops_per_page)

    assign(socket, crops: results, search_query: search_query)
  end

  defp assign_defaults(socket, session) do
    socket
    |> assign_current_user(session)
    |> assign(crops: list_crops(), page: 1, search_query: "")
  end
end
