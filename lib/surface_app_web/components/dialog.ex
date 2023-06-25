defmodule SurfaceAppWeb.Components.Dialog do
  use Surface.LiveComponent

  alias SurfaceAppWeb.Components.Utils.Button

  prop title, :string, required: true
  # prop ok_label, :string, default: "Ok"
  # prop close_label, :string, default: "Close"
  # prop ok_click, :event, default: "close"
  # prop close_click, :event, default: "close"

  data show, :string, default: "hidden"

  slot default

  # def mount(socket) do
  #   {:ok,
  #     socket
  #     |> assign(timesup: true)}
  # end

  def render(assigns) do
    ~F"""
    <div class={"modal fade fixed w-full pointer-events-none h-full top-0 left-0 flex items-center justify-center", @show} :on-window-keydown="hide" phx-key="Escape">
      <div class="modal-dialog relative w-auto pointer-events-none max-w-md">
      <div class="modal-content border-none shadow-lg relative flex flex-col w-full pointer-events-auto bg-white bg-clip-padding rounded-md outline outline-offset-2 outline-4 text-current">
      <div class="modal-header flex items-center justify-center p-4 border-b border-gray-200 rounded-t-md">
        <h5 class="text-xl font-medium leading-normal text-gray-800" id="exampleModalLabel">Time has Expired!</h5></div>
        <img class="justify-center" src="https://upload.wikimedia.org/wikipedia/commons/3/38/Oxygen480-emblems-emblem-locked.svg" />
        <header class="modal-card-head justify-center">
          <p class="modal-card-title justify-center text-center">{@title}</p>
        </header>
        <section class="modal-card-body justify-center text-center">
          <#slot />
        </section>
        <footer class="modal-card-foot justify-center grid">
          <Button click={"new", target: "#mc_card"} kind="is-info">Ok, Next Question</Button>
        </footer>
        </div>
      </div>
    </div>
    """
  end

  # Public API

  def show(dialog_id) do
    send_update(__MODULE__, id: dialog_id, show: "")
  end

  def hide(dialog_id) do
    send_update(__MODULE__, id: dialog_id, show: "hidden")
  end

  # Event handlers

  def handle_event("show", _, socket) do
    {:noreply, assign(socket, show: "")}
  end

  def handle_event("hide", _, socket) do
    {:noreply, assign(socket, show: "hidden")}
  end
end