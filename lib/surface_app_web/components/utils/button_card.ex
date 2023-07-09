defmodule SurfaceAppWeb.Components.Utils.ButtonCard do
  use Surface.Component

  prop label, :string
  prop click, :event, required: true
  prop kind, :string, default: "is-info"
  prop value, :string

  slot default

  def mount(socket) do
    IO.puts "Socket"
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
      cat == "Literature" -> "https://upload.wikimedia.org/wikipedia/commons/c/ca/Noun_Project_books_icon_1069598_cc.svg"
      cat == "Science" -> "https://upload.wikimedia.org/wikipedia/commons/a/a6/202002_Laboratory_instrument_microscope.svg"
      cat == "Sports" -> "https://upload.wikimedia.org/wikipedia/commons/1/12/Basketball_-_The_Noun_Project.svg"
      cat == "World" -> "https://upload.wikimedia.org/wikipedia/commons/a/ab/World_globe_vector_illustration.svg"
      cat == "Movies" -> "https://upload.wikimedia.org/wikipedia/commons/e/e7/Video-x-generic.svg"
      cat == "Random" -> "https://upload.wikimedia.org/wikipedia/commons/6/65/Noun_questions_1325510.svg"
      cat == "Tech" -> "https://upload.wikimedia.org/wikipedia/commons/3/39/Mac_-_The_Noun_Project.svg"
      cat == "Music" -> "https://upload.wikimedia.org/wikipedia/commons/9/97/Music_-_The_Noun_Project.svg"
      cat == "Animals" -> "https://upload.wikimedia.org/wikipedia/commons/6/6e/Barking_Dog_-_The_Noun_Project.svg"
      cat == "USA" -> "https://upload.wikimedia.org/wikipedia/commons/1/11/US_businessman.svg"
    end
  end

  def render(assigns) do
    ~F"""
    <button type="button" value={@value} class={"button", @kind} :on-click={@click}>
      <div class="flex justify-center">
        <div class="justify-center rounded-lg shadow-lg">
          <a href="#!">
            <img class="max-w-full h-auto rounded-t-md" src={img_src(@label)} alt=""/>
          </a>
          <div class="">
            <h5 class="text-gray-900 text-xl font-indie font-medium my-2">{@label}</h5>
          </div>
        </div>
      </div>
    </button>
    """
  end
end