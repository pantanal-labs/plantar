defmodule PlantarWeb.CropLive.Show do
  use PlantarWeb, :live_view

  alias Plantar.Plant
  alias PlantarWeb.CropView

  @impl true
  def render(assigns) do
    Phoenix.View.render(CropView, "show.html", assigns)
  end

  @impl true
  def mount(_params, session, socket) do
    {:ok,
     socket
     |> assign_current_user(session)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    crop = Plant.get_crop!(id)
    {:noreply,
     socket
     |> assign(:page_title, crop.name)
     |> assign(:crop, crop)}
  end
end
