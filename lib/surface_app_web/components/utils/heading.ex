defmodule SurfaceAppWeb.Components.Utils.Heading do
    # Because the component does not need to handle its own state, use a stateless component
    use Surface.Component

    prop title, :string, required: true
    prop color, :string, default: "black"
    prop size, :string, default: "medium"

    def render(assigns) do
        ~F"""
          <h1 class={"grid items-center font-indie justify-center leading-tight text-3xl mt-0", get_color(@color), get_size(@size)}>{ @title }</h1>
        """
    end

    defp get_color(color) do
      "text-" <> color <> "-400"
    end

    defp get_size(size) do
      "font-" <> size
    end
end