defmodule PlantarWeb.CropLive.Index do
  use PlantarWeb, :live_view

  alias Plantar.Plant
  alias Plantar.Plant.Crop
  alias PlantarWeb.CropView

  @impl true
  def render(assigns) do
    Phoenix.View.render(CropView, "index.html", assigns)
  end

  @impl true
  def mount(_params, session, socket) do
    {:ok,
     socket
     |> assign_current_user(session)
     |> assign(:crops, list_crops())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Crop")
    |> assign(:crop, Plant.get_crop!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Crop")
    |> assign(:crop, %Crop{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Crops")
    |> assign(:crop, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    crop = Plant.get_crop!(id)
    {:ok, _} = Plant.delete_crop(crop)

    {:noreply, assign(socket, :crops, list_crops())}
  end

  defp list_crops do
    Plant.list_crops()
  end
end
