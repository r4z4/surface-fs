defmodule SurfaceAppWeb.Components.Utils.ButtonCard do
  use Surface.Component

  prop label, :string
  prop click, :event, required: true
  prop kind, :string, default: "is-info"
  prop value, :string

  slot default

  def mount(socket) do
    IO.puts "Socker"
    IO.inspect socket
    {:noreply, socket}
  end

  # Another lit = https://upload.wikimedia.org/wikipedia/commons/0/08/Ink_and_Quill.png
  # Another movie = https://upload.wikimedia.org/wikipedia/commons/3/3f/Film_reel.svg
  # Science gif = https://upload.wikimedia.org/wikipedia/commons/1/17/A-DNA_orbit_animated_small.gif
  # geo = https://upload.wikimedia.org/wikipedia/commons/a/a0/Earth_gravity.png
  @spec img_src(String.t()) :: String.t()
  defp img_src(cat) do
    IO.inspect cat
    cond do
      cat == "Literature" -> "https://upload.wikimedia.org/wikipedia/commons/d/d2/P_writing_blue.png"
      cat == "Science" -> "https://upload.wikimedia.org/wikipedia/commons/3/37/Sciences_exactes.svg"
      cat == "Sports" -> "https://upload.wikimedia.org/wikipedia/commons/7/7f/Generic_football.png"
      cat == "World" -> "https://upload.wikimedia.org/wikipedia/commons/f/f9/Location-pin.png"
      cat == "Movies" -> "https://upload.wikimedia.org/wikipedia/commons/3/3f/Film_reel.svg"
      cat == "Random" -> "https://upload.wikimedia.org/wikipedia/commons/8/84/Question_Mark_Icon.png"
      cat == "Tech" -> "https://upload.wikimedia.org/wikipedia/commons/8/84/Question_Mark_Icon.png"
      cat == "Music" -> "https://upload.wikimedia.org/wikipedia/commons/8/84/Question_Mark_Icon.png"
      cat == "Animals" -> "https://upload.wikimedia.org/wikipedia/commons/8/84/Question_Mark_Icon.png"
      cat == "USA" -> "https://upload.wikimedia.org/wikipedia/commons/8/84/Question_Mark_Icon.png"
    end
  end

  def render(assigns) do
    ~F"""
    <button type="button" value={@value} class={"button", @kind} :on-click={@click}>
      <div class="flex justify-center">
        <div class="rounded-lg shadow-lg max-w-sm max-h-60">
          <a href="#!">
            <img class="max-w-full h-auto rounded-t-md {@label == 'Literature' ? mb-8 : ''}" src={img_src(@label)} alt=""/>
          </a>
          <div class="">
            <h5 class="text-gray-900 text-xl font-indie font-medium my-2">{@label}</h5>
            <!--<p class="text-gray-700 text-base mb-4">
              Some quick example text to build on the card title and make up the bulk of the card's
              content.
            </p>-->
          </div>
        </div>
      </div>
    </button>
    """
  end
end