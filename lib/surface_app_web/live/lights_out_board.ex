defmodule SurfaceAppWeb.LightOutBoardLive do
  use Surface.LiveView

    alias SurfaceAppWeb.Components.Utils.{Heading, Button}

  prop grid, :map

  def mount(_params, session, socket) do
    grid = for x <- 0..4, y <- 0..4, into: %{}, do: {{x, y}, false}
    # %{{0,0} => false, {0,1} -> false, ...}
    {:ok, 
      socket
      |> assign(grid: grid)}
  end

  def render(assigns) do
    ~F"""
        <h2>Lights Out</h2>
        <div class="flex flex-col max-w-lg mx-auto">
          <div class="grid grid-rows-5 grid-cols-5 gap-2 mb-4">
            {#for {{x, y}, value} <- assigns.grid }
              <Button click="toggle" value={{x, y}, value} class="block h-20 px-4 py-6 text-center border rounded bg-stone-200"></Button>
            {/for}
          </div>
        </div>
    """
  end

  def handle_event("toggle", %{"x" => x,"y" => y,"value" => value}, socket) do
    grid = socket.assigns.grid

    grid_x = String.to_integer(x)
    grid_y = String.to_integer(y)

    # Take curr value, based on X,Y & flips value in that position. To test it out.
    # updated_grid = Map.put(grid, {grid_x, grid_y}, !grid[{grid_x, grid_y}])

    updated_grid = 
      find_adjacent_tiles(x, y)
      |> Enum.reduce(%{}, fn point, acc ->
        Map.put(acc, point, !grid[point])
      end)
      |> then(fn toggle_grid -> Map.merge(grid, toggle_grid) end)

    {:noreply, 
      socket
      |> assign(grid: updated_grid)}
  end

  def find_adjacent_tiles(x, y) do
    # Boundaries
    prevX = Kernel.max(0, x - 1)
    nextX = Kernel.min(4, x + 1)
    prevY = Kernel.max(0, y - 1)
    nextY = Kernel.min(4, y + 1)
    # List of values that represent that changes that
    # need to be made to grid on button click
    [{x,y}, {prevX, y}, {nextX, y}, {x, prevY}, {x, nextY}]
  end
end