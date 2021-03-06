defmodule PlantarWeb.LiveHelpers do
  import Phoenix.LiveView
  import Phoenix.LiveView.Helpers
  alias Plantar.Accounts

  def assign_current_user(socket, session) do
    fetch_current_user(socket, session)
  end

  # For liveviews, ensures current_user is in socket assigns.
  def fetch_current_user(socket, session) do
    user_token = Map.get(session, "user_token")
    user = user_token && Accounts.get_user_by_session_token(user_token)
    assign(socket, :current_user, user)
  end

  @doc """
  Renders a component inside the `PlantarWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal @socket, PlantarWeb.CropLive.FormComponent,
        id: @crop.id || :new,
        action: @live_action,
        crop: @crop,
        return_to: Routes.crop_index_path(@socket, :index) %>
  """
  def live_modal(socket, component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(socket, PlantarWeb.ModalComponent, modal_opts)
  end
end
