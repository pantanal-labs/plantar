defmodule PlantarWeb.ModalComponent do
  use PlantarWeb, :live_component

  @impl true
  def render(assigns) do
    ~L"""
    <div id="<%= @id %>" class="fixed overflow-y-scroll inset-0 flex items-center justify-center"
      style="background-color: rgba(0,0,0,0.3);"
      phx-capture-click="close"
      phx-window-keydown="close"
      phx-key="escape"
      phx-target="#<%= @id %>"
      phx-page-loading>

      <div class="max-w-lg p-8 sm:pb-4 bg-white rounded shadow-lg text-center sm:text-left">
        <%= live_patch raw("&times;"), to: @return_to, class: "phx-modal-close" %>

        <%= live_component @socket, @component, @opts %>
      </div>
    </div>
    """
  end

  @impl true
  def handle_event("close", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end
end
