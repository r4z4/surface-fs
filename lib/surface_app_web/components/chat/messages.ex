defmodule SurfaceAppWeb.Components.Chat.Messages do
  @moduledoc """
  Messages component
  """
  # use SurfaceAppWeb, :live_component
  use Surface.LiveComponent

  alias SurfaceApp.Rooms
  alias Surface.Components.Form
  alias Surface.Components.Form.{TextInput, Label, Field}
  alias SurfaceAppWeb.Components.Utils.{Heading, Button}

  data room, :any

  @impl true
  def update(%{room_id: nil} = _assigns, socket) do
    {:ok, assign(socket, room: nil)}
  end

  @impl true
  def update(%{id: id, current_user: current_user, room_id: room_id} = _assigns, socket) do
    # Push event asking to load messages from local storage
    {:ok, socket
    |> assign(
      id: id,
      room: Rooms.get_room!(room_id),
      invite_link_copied: false,
      messages: [],
      current_user: current_user)
    |> push_event("load_messages", %{room_id: room_id})}
  end

  # Called via send_update (based on pubsub)
  @impl true
  def update(%{new_message: message} = _assigns, socket) do
    {:ok, socket
      |> assign(messages: [message | socket.assigns.messages] 
      |> Enum.sort(fn lhs, rhs ->
                    case compare.(rhs[:timestamp], lhs[:timestamp]) do
                      :lt -> false
                      _ -> true
                    end
                  end))
      |> push_event(
        "new_message",
        %{
          room_id: socket.assigns.room.id,
          field_id: "message_body",
          message: message
        }
      )}
  end

  @impl true
  def render(%{room: nil} = assigns) do
    ~F"""
    <div class="w-full flex flex-col p-4">
      No room has been joined yet. To join a room click on its name on the sidebar to your left.
    </div>
    """
  end

  @impl true
  def render(assigns) do
    ~F"""
    <div id={@id} class="w-full flex flex-col" phx-hook="LoadMessagesFromLocalStorage">
      <!-- Top bar -->
      <div class="border-b flex px-6 py-2 items-center">
        <div class="flex flex-col">
          <h3 class="text-gray-800 text-md mb-1 font-extrabold">#{assigns.room.name}</h3>
          <div class="text-gray-600 text-sm">
            {assigns.room.description}
          </div>
          <div class="text-gray-400 text-sm link">
            Invite code: {assigns.room.invite_code}
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 inline" fill="none"
                 viewBox="0 0 24 24" stroke="currentColor"
                 phx-click="copy_invite_code_link"
                 phx-value-code={@room.invite_code}
                 phx-target={@myself}>
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
            </svg>
            {#if @invite_link_copied}
              <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 inline" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
              </svg>
            {/if}
          </div>
        </div>
      </div>
      <!-- Chat messages -->
      <div class="px-6 py-4 flex-1 overflow-scroll-x">
        {#for message <- @messages}
        <!-- A message -->
          {#if message["user_email"] == assigns.current_user.email}
            <div class="flex items-start mb-4 sender-match">
              <img src={gravatar_url(message["user_email"])} class="w-10 h-10 rounded mr-3" />
                <div class="flex flex-col">
                  <div class="flex items-end">
                    <span class="font-bold text-md mr-2 font-sans">{message["user_email"]}</span>
                    <span class="text-gray-500 text-xs font-400">{message["timestamp"]}</span>
                  </div>
                  <p class="font-400 text-md text-gray-800 pt-1">{message["body"]}</p>
                </div>
            </div>

          {#else}
            <div class="flex items-start mb-4 no-sender-match">
              <img src={gravatar_url(message["user_email"])} class="w-10 h-10 rounded mr-3" />
                <div class="flex flex-col">
                  <div class="flex items-end">
                    <span class="font-bold text-md mr-2 font-sans">{message["user_email"]}</span>
                    <span class="text-gray-500 text-xs font-400">{message["timestamp"]}</span>
                  </div>
                  <p class="font-400 text-md text-gray-800 pt-1">{message["body"]}</p>
                </div>
            </div>
          {/if}
        {/for}
      </div>
      <Form for={:message} change="change" submit="submit">
        <Field name="message_body">
          <Label>Message</Label>
          <div class="control">
            <TextInput value={@user["name"]}/>
          </div>
        </Field>
        <Button />
      </Form>
    </div>
    """
  end

  @impl true
  def handle_event("copy_invite_code_link", %{"code" => code}, socket) do
    base_url = SurfaceAppWeb.Endpoint.url()
    link = base_url <> Routes.live_path(socket, SurfaceAppWeb.Components.Chat.JoinRoomView, code)

    {:noreply,
     socket
     |> assign(invite_link_copied: true)
     |> push_event("copy_invite_code_link", %{link: link})}
  end

  @impl true
  def handle_event("submit", %{"message" => %{"body" => message_body}}, socket) do
    if String.trim(message_body) == "" do
      {:noreply, socket}
    else
      message = %{
        "user_email" => socket.assigns.current_user.email,
        "timestamp" => DateTime.now!("Etc/UTC"),
        "body" => message_body
      }
      Phoenix.PubSub.broadcast(
        SurfaceApp.PubSub,
        "rooms",
        {:message, socket.assigns.room.id, message}
      )
      {:noreply, socket |> push_event("clear_input", %{field_id: "message_body"})}
    end
  end

  def handle_event("load-messages", nil, socket) do
    {:noreply, socket |> assign(messages: [])}
  end

  def handle_event("load-messages", messages, socket) do
    {:noreply, socket |> assign(messages: messages)}
  end

  defp gravatar_url(email) do
    hash = Base.encode16(:erlang.md5(email), case: :lower)
    "https://www.gravatar.com/avatar/#{hash}?s=200&d=robohash"
  end

  defp compare do
    fn
      x, x -> :eq
      x, y when x > y -> :gt
      _, _ -> :lt
    end
  end
end