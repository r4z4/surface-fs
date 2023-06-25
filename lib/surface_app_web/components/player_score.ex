defmodule SurfaceAppWeb.Components.PlayerScore do
  use Surface.LiveComponent

  prop score, :integer
  prop poss_pts, :integer

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~F"""
    <div class="grid items-center justify-end">
      <h2 class="font-medium leading-tight text-1xl mt-0 md:mb-2 text-white">Player Score: <span class="text-2xl mt-0 md:mb-2 text-lime-600">{ @score }</span> / <span class="text-2xl mt-0 md:mb-2 text-white">{ @poss_pts }</span></h2>
    </div>
    """
  end
end