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
      kind == "is-choice" -> "flex w-full justify-center p-8 m-8"
      kind == "is-select" -> "font-indie inline-block text-center py-3 font-bold text-xl tracking-wide w-full"
      kind == "is-cat-select" -> "font-indie flex mx-auto text-center justify-center font-bold bg-blue-600"
      kind == "is-submit" -> "bg-blue-400 mt-5 hover:bg-blue-600 text-black font-bold py-2 px-8 rounded-full mr-8 float-right"
      kind == "is-answer" -> "bg-gradient-to-r from-blue-300 via-green-200 to-yellow-300 mt-5 text-black font-bold py-2 px-8 rounded-md mb-4"
      kind == "is-new" -> "bg-gradient-to-r from-cyan-200 to-cyan-400 text-black font-bold py-2 px-8 rounded-md mb-4"
      kind == "margined" -> "bg-fuchsia-400 hover:bg-fuchsia-600 py-2 px-8 rounded-full mx-auto my-4"
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