defmodule SurfaceAppWeb.Components.Chat.JoinRoomView do
  @moduledoc """
  Allows a user to join a room, using the room invite code
  """
  use Surface.LiveComponent

  alias SurfaceApp.Rooms
  alias SurfaceApp.Accounts

  @impl true
  def mount(%{"invite_code" => invite_code} = params, session, socket) do
    room = Rooms.get_room_by!(invite_code: invite_code)
    user = Accounts.get_user_by_token(session["user_token"])
    {:ok, _room} = Rooms.join(user, room)

    {:noreply,
     socket |> put_flash(:info, "Room #{room.name} successfully joined!") |> Phoenix.LiveView.redirect(to: "/")}
  end

  ### Only LiveViews implement handle_params -> Can change this to use Surface.LiveView above if want to

  # @impl true
  # def handle_params(%{"invite_code" => invite_code} = _params, _url, %{assigns: %{current_user: user}} = socket) do
  #   room = Rooms.get_room_by!(invite_code: invite_code)
  #   {:ok, _room} = Rooms.join(user, room)

  #   {:noreply,
  #    socket |> put_flash(:info, "Room #{room.name} successfully joined!") |> Phoenix.LiveView.redirect(to: "/")}
  # end

  @impl true
  def render(assigns) do
    ~F"""
    """
  end
end