defmodule PlantarWeb.CropLive.Show do
  use PlantarWeb, :live_view

  alias Plantar.Plant

  @impl true
  def mount(_params, session, socket) do
    {:ok,
     socket
     |> assign_current_user(session)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:crop, Plant.get_crop!(id))}
  end

  defp page_title(:show), do: "Show Crop"
  defp page_title(:edit), do: "Edit Crop"
end
