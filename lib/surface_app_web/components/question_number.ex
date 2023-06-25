defmodule SurfaceAppWeb.Components.QuestionNumber do
  use Surface.LiveComponent

  prop number, :integer
  prop length, :integer
  prop points_worth, :integer

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~F"""
    <div class="grid items-center justify-end">
      <h2 class="font-medium leading-tight text-1xl mt-0 md:mb-2 text-black-600">Question: <span class="text-2xl mt-0 md:mb-2 text-blue-600">{ @number }</span> / <span class="text-2xl mt-0 md:mb-2 text-black-600">{ @length }</span>  ||  Points: { @points_worth }</h2>
    </div>
    """
  end
end