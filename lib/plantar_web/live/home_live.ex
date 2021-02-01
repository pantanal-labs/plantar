defmodule PlantarWeb.HomeLive do
  use PlantarWeb, :live_view

  alias Plantar.Search
  alias PlantarWeb.HomeView

  @crops_per_page 9

  @impl true
  def render(assigns) do
    Phoenix.View.render(HomeView, "index.html", assigns)
  end

  @impl true
  def mount(_params, session, socket) do
    {:ok,
     socket
     |> assign_defaults(session), temporary_assigns: [crops: []]}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    query = String.trim(params["q"] || "")

    {:noreply,
     socket
     |> assign(current_page: 1)
     |> update_with_replace()
     |> search(query)}
  end

  @impl true
  def handle_event("search", %{"q" => search_query}, %{assigns: assigns} = socket) do
    query = String.trim(search_query)
    previous_query = assigns.search_query

    if query == previous_query do
      {:noreply, assign(socket, search_query: query)}
    else
      {:noreply, set_params(socket, q: query)}
    end

    socket = search(socket, search_query)

    {:noreply, socket}
  end

  def handle_event("load-more", _params, %{assigns: assigns} = socket) do
    %{search_query: search_query} = assigns

    {:noreply,
     socket
     |> update(:current_page, &(&1 + 1))
     |> update_with_append()
     |> search(search_query)}
  end

  defp search(socket, search_query) do
    offset = (socket.assigns.current_page - 1) * @crops_per_page

    %{results: results, total_count: total_count} =
      Search.find_crops(search_query, offset: offset, limit: @crops_per_page)

    assign(socket,
      crops: results,
      search_query: search_query,
      total_count: total_count
    )
  end

  defp set_params(socket, opts) do
    push_patch(socket, to: "/")
  end

  defp assign_defaults(socket, session) do
    socket
    |> assign_current_user(session)
    |> assign(current_page: 1)
    |> assign(search_query: "")
    |> search(nil)
    |> update_with_append()
  end

  defp update_with_append(socket) do
    assign(socket, update: "append")
  end

  defp update_with_replace(socket) do
    assign(socket, update: "replace")
  end
end
