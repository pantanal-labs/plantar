defmodule PlantarWeb.CropLive.FormComponent do
  use PlantarWeb, :live_component

  alias Plantar.Plant
  alias PlantarWeb.CropView

  @impl true
  def render(assigns) do
    Phoenix.View.render(CropView, "form_component.html", assigns)
  end

  @impl true
  def update(%{crop: crop} = assigns, socket) do
    changeset = Plant.change_crop(crop)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"crop" => crop_params}, socket) do
    changeset =
      socket.assigns.crop
      |> Plant.change_crop(crop_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"crop" => crop_params}, socket) do
    save_crop(socket, socket.assigns.action, crop_params)
  end

  defp save_crop(socket, :edit, crop_params) do
    case Plant.update_crop(socket.assigns.crop, crop_params) do
      {:ok, _crop} ->
        {:noreply,
         socket
         |> put_flash(:info, "Crop updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_crop(socket, :new, crop_params) do
    crop_params = crop_params
      |> Map.put("user_id", socket.assigns.user_id)
    case Plant.create_crop(crop_params) do
      {:ok, _crop} ->
        {:noreply,
         socket
         |> put_flash(:info, "Crop created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
