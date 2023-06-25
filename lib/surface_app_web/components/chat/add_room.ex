defmodule SurfaceAppWeb.Components.Chat.AddRoom do
  @moduledoc """
  Modal component
  """
  use Surface.LiveComponent

  alias SurfaceApp.Rooms
  alias Surface.Components.Form
  alias Surface.Components.Form.{TextInput, Label, Field, HiddenInput}
  alias SurfaceAppWeb.Components.Utils.{Heading, SubmitButton, Button}

  data modal_state, :any
  data current_user, :any
  data room_id, :any, default: "whatever"


  def mount(socket) do
    {:ok, socket}
  end

  @impl true
  def update(%{id: id, modal_state: modal_state, current_user: current_user} = _assigns, socket) do
    {:ok, assign(socket, room_id: id, modal_state: modal_state, current_user: current_user)}
  end

  @impl true
  def render(assigns) do
    ~F"""
    <div id={assigns.room_id}>
    {#if @modal_state == "OPEN"}
      <div class="min-w-screen h-screen animated fadeIn faster fixed left-0 top-0 flex justify-center items-center
                  inset-0 z-50 outline-none focus:outline-none bg-no-repeat bg-center bg-cover"
          style="backdrop-filter: blur(10px);">
        <div class="absolute bg-black opacity-80 inset-0 z-0"></div>
        <div class="w-full max-w-lg p-5 relative mx-auto my-auto rounded-xl shadow-lg bg-white ">
          <!--content-->
          <div class="">
            <!--body-->
            <div class="text-center p-5 flex-auto justify-center">
              <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4 -m-1 flex items-center text-red-500 mx-auto" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
              </svg>
              <svg xmlns="http://www.w3.org/2000/svg" class="w-16 h-16 flex items-center text-red-500 mx-auto" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z" clip-rule="evenodd" />
              </svg>
              <h2 class="text-xl font-bold text-black-500 py-4">Add a Room</h2>
              <p class="text-sm text-black-500 px-8">
              <Form for={:create_room} phx_submit="submit" phx-value-user_id={@current_user.id} phx-target={@myself}>
                Add a Room Name & Short Description
              <Field name="room_name">
                <div class="control">
                  <TextInput 
                    name="room_name" 
                    class="block p-2.5 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                    opts={placeholder: "Room Name ... "} 
                  />
                </div>
              </Field>
              <Field name="description">
                <div class="control">
                  <TextInput 
                    name="description" 
                    class="block mt-2 p-2.5 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                    opts={placeholder: "Description ... "} 
                  />
                </div>
              </Field>
                    <HiddenInput form={:create_room} name={"user_id"} value={assigns.current_user.id} />
              </Form>
              </p>
            </div>
      
            <!--footer-->
            <div class="p-3  mt-2 text-center space-x-4 md:block">
              <Button class="mb-2 md:mb-0 bg-white px-5 py-2 text-sm shadow-sm  font-medium tracking-wider border text-gray-600 rounded-full hover:shadow-lg hover:bg-gray-100"
                      click="close_add_room_modal">
                  Cancel
              </Button>
              <Button class="mb-2 md:mb-0 bg-red-500 border border-red-500 px-5 py-2 text-sm shadow-sm font-medium tracking-wider text-white rounded-full hover:shadow-lg hover:bg-red-600">
                Create
              </Button>
            </div>
          </div>
        </div>
      </div>
    {/if}
    </div>
    """
  end

  @impl true
  def handle_event("open", _, socket) do
    {:noreply, assign(socket, :modal_state, "OPEN")}
  end

  def handle_event("submit", attrs, socket) do
    SurfaceApp.Rooms.create_room(attrs)
    {:noreply, assign(socket, :modal_state, "CLOSED")}
  end

  def handle_event("close_add_room_modal", _, socket) do
    {:noreply, assign(socket, :modal_state, "CLOSED")}
  end
end