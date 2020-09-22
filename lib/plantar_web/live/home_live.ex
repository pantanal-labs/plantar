defmodule PlantarWeb.HomeLive do
  use PlantarWeb, :live_view

  alias Plantar.Plant
  alias PlantarWeb.HomeView

  @impl true
  def render(assigns) do
    Phoenix.View.render(HomeView, "index.html", assigns)
  end

  @impl true
  def mount(_params, session, socket) do
    {:ok,
     socket
     |> assign_current_user(session)
     |> assign(:crops, list_crops())}
  end

  defp list_crops do
    Plant.list_crops()
  end
end
