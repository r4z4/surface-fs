defmodule SurfaceAppWeb.SocialLive do
  use Surface.LiveView

  alias SurfaceAppWeb.Components.{SocialDisplayLive}
  alias SurfaceAppWeb.BeamClientLive
  alias SurfaceAppWeb.ChatLive

  @moduledoc """
    A small LiveView that shows the number of readers of a post using Phoenix Presence
  """

  def render(assigns) do
    ~F"""
    <SocialDisplayLive id="user_count" />
    <!--<ChatMessages id="messages" current_user={@current_user}  room_id={@current_room_id} />-->
      <div class='flex items-center justify-center'>
        <ul class="mx-auto grid max-w-full w-full grid-cols-2 gap-x-5 px-8">
          <li class="">
            <input class="peer sr-only" type="radio" value="yes" name="answer" id="yes" checked />
            <label class="flex justify-center cursor-pointer rounded-full border border-gray-300 bg-white py-2 px-4 hover:bg-gray-50 focus:outline-none peer-checked:border-transparent peer-checked:ring-2 peer-checked:ring-indigo-500 transition-all duration-500 ease-in-out" for="yes">Timeline</label>
              <div class="absolute bg-white shadow-lg left-0 p-6 border mt-2 border-indigo-300 rounded-lg w-[97vw] mx-auto transition-all duration-500 ease-in-out translate-x-40 opacity-0 invisible peer-checked:opacity-100 peer-checked:visible peer-checked:translate-x-1">
                <div class="px-6 py-4 flex-1 overflow-scroll-x">
                  <BeamClientLive id="beam_client" />
                </div>
            </div>
          </li>

          <li class="">
            <input class="peer sr-only" type="radio" value="no" name="answer" id="no" />
            <label class="flex justify-center cursor-pointer rounded-full border border-gray-300 bg-white py-2 px-4 hover:bg-gray-50 focus:outline-none peer-checked:border-transparent peer-checked:ring-2 peer-checked:ring-indigo-500 transition-all duration-500 ease-in-out" for="no">Chat</label>
              <div class="absolute bg-white shadow-lg left-0 p-6 border mt-2 border-indigo-300 rounded-lg w-[97vw] mx-auto transition-all duration-500 ease-in-out translate-x-40 opacity-0 invisible peer-checked:opacity-100 peer-checked:visible peer-checked:translate-x-1">
                <div class="px-6 py-4 flex-1 overflow-scroll-x">
                  <ChatLive id="chat_live" />
                </div>
            </div>
          </li>
         </ul>
      </div>
    """
  end
  
  @impl
  def mount(_params, session, socket) do
    {:ok,socket}
  end

end