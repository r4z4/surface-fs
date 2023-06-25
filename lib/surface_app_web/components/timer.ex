defmodule SurfaceAppWeb.Components.Timer do
  use Surface.LiveComponent

  prop seconds, :integer

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~F"""
    <div class="grid items-center justify-center">
      <h2 class="font-medium leading-tight md:text-2xl lg:text-4xl mt-0 md:mb-2 text-orange-600">{ if @seconds > -1, do: @seconds, else: 0 }</h2>
    </div>
    """
  end
end