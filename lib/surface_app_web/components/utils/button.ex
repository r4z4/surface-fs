defmodule SurfaceAppWeb.Components.Utils.Button do
  use Surface.Component

  prop label, :string
  prop click, :event, required: true
  prop kind, :string, default: "is-info"
  prop value, :string

  slot default

  defp btn_style(kind) do
    IO.inspect kind
    cond do
      kind == "is-info" -> "inline-block px-6 py-2.5 bg-blue-600 text-white font-medium text-xs leading-tight uppercase rounded shadow-md hover:bg-blue-700 hover:shadow-lg focus:bg-blue-700 focus:shadow-lg focus:outline-none focus:ring-0 active:bg-blue-800 active:shadow-lg transition duration-150 ease-in-out"
      kind == "is-answer" -> "inline-block px-7 py-3"
      kind == "is-select" -> "font-indie inline-block text-center py-3 font-bold text-xl tracking-wide w-full"
      kind == "is-submit" -> "bg-blue-400 mt-5 hover:bg-blue-600 text-black font-bold py-2 px-8 rounded-full mr-8 float-right"
    end
  end

  def render(assigns) do
    ~F"""
    <button type="button" value={@value} class={btn_style(@kind)} :on-click={@click}>
      <#slot>{@label}</#slot>
    </button>
    """
  end
end