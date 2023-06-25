defmodule SurfaceAppWeb.Components.Utils.Checkbox do
  use Surface.Component

  prop label, :string
  prop kind, :string
  prop value, :string
  prop id, :string
  prop name, :string

  slot default

  def render(assigns) do
    ~F"""
    <input 
      type="checkbox" 
      value={@value} 
      id={@id}
      name={@name}
      class={"form-check-input appearance-none h-4 w-4 border border-gray-300 rounded-sm bg-white checked:bg-blue-600 checked:border-blue-600 focus:outline-none transition duration-200 mt-1 align-top bg-no-repeat bg-center bg-contain float-left mr-2 cursor-pointer", @kind}>
      <label for={@id}>{@label}</label><br>
    """
  end
end