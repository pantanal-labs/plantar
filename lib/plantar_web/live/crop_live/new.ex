defmodule PlantarWeb.CropLive.New do
  use PlantarWeb, :live_view
  alias PlantarWeb.CropView
  alias Plantar.Plant
  alias Plantar.Plant.Crop

  @impl true
  def render(assigns) do
    Phoenix.View.render(CropView, "new.html", assigns)
  end

  @impl true
  def mount(_from, session, socket) do
    {:ok,
     socket
     |> assign(changeset: Plant.change_crop(%Crop{}))
     |> assign_current_user(session)}
  end

  @impl true
  def handle_event("validate", %{"crop" => crop_params}, socket) do
    changeset =
      %Crop{}
      |> Plant.change_crop(crop_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"crop" => crop_params}, socket) do
    save_crop(socket, crop_params)
  end

  defp save_crop(socket, crop_params) do
    crop_params =
      crop_params
      |> Map.put("user_id", socket.assigns.current_user.id)

    case Plant.create_crop(crop_params) do
      {:ok, _crop} ->
        {:noreply,
         socket
         |> put_flash(:info, "Crop created successfully")
         |> push_redirect(to: Routes.home_path(socket, :index))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
