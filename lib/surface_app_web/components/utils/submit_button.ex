defmodule SurfaceAppWeb.Components.Utils.SubmitButton do
  use Surface.Component

  prop label, :string
  prop click, :event, required: true
  prop kind, :string, default: "is-submit"
  prop value, :string

  slot default

  defp btn_style(kind) do
    IO.inspect kind
    cond do
      kind == "is-submit" -> "bg-blue-400 mt-5 hover:bg-blue-600 text-black font-bold py-2 px-8 rounded-full mr-8 float-right"
    end
  end

  def render(assigns) do
    ~F"""
    <button type="submit" value={@value} class={btn_style(@kind)} :on-click={@click}>
      <#slot>{@label}</#slot>
    </button>
    """
  end
end