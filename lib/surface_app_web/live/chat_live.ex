defmodule SurfaceAppWeb.ChatLive do
  @moduledoc """
  Chat app index live view
  """
  use Surface.LiveView

  alias SurfaceAppWeb.Components.Chat.{Sidebar, Messages}
  alias SurfaceApp.Accounts

  data current_room_id, :integer
  data modal_state, :string
  data current_user, :any

  @impl true
  def mount(_params, session, socket) do
    if connected?(socket), do:
      Phoenix.PubSub.subscribe(SurfaceApp.PubSub, "rooms")
    {u} = Accounts.get_user_by_token(session["user_token"])
    {:ok, assign(socket, current_room_id: nil, modal_state: CLOSED, current_user: u)}
  end

  # @impl true
  # def handle_params(_params, _url, socket) do
  #   {:noreply, socket}
  # end

  @impl true
  def render(assigns) do
    ~F"""
    <div class="w-full border shadow bg-white">
      <div class="flex">
        <Sidebar id="sidebar" current_user={assigns.current_user} current_room_id={assigns.current_room_id} modal_state={assigns.modal_state} />
        <Messages id="messages" current_user={assigns.current_user}  room_id={assigns.current_room_id} />
      </div>
    </div>
    """
  end

  # <.live_component module={Components.Modal} id="add-room" />

  @impl true
  def handle_event("enter-room", %{"id" => room_id} = _event, socket) do
    {:noreply, assign(socket, current_room_id: room_id)}
  end

  @impl true
  def handle_info({:message, room_id, message}, socket) do
    current_room = socket.assigns.current_room_id
    if current_room && room_id == String.to_integer(current_room) do
      send_update(Messages, id: "messages", new_message: message)
    end
    {:noreply, socket}
  end
end