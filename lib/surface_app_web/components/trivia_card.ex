defmodule SurfaceAppWeb.Components.TriviaCard do
    # This component will have some state. So use the stateful component.
    use Surface.LiveComponent

    alias SurfaceApp.Game
    alias SurfaceApp.Game.McCard

    data trivia_value, :string
    data answered, :boolean, default: false
    # Use this to store our trivia card
    data trivia_card, :any

    # Can omit mount callback if using deault values in data assigns
    def mount(socket) do
    card = random_card()
        {:ok,
          socket
          |> assign(trivia_value: card.question)
          |> assign(trivia_card: card)}
    end

    @spec random_card :: %McCard{}
    defp random_card do
      Game.list_cards |> Enum.random()
    end

    def render(assigns) do
        ~F"""
        <div class="grid items-center justify-center">
          <div class="card">
            <h3>
            { @trivia_value }
            </h3>
          </div>
          <button :on-click="answer">Answer</button>
          <button :if={@answered} :on-click="new">New Question</button>
        </div>
        """
    end

    def handle_event("answer", _value, socket) do
        card = socket.assigns.trivia_card
        {:noreply,
          socket
          |> assign(trivia_value: card.answer)
          |> assign(answered: true)}
    end

    def handle_event("new", _value, socket) do
        card = random_card()
        {:noreply,
          socket
          |> assign(trivia_value: card.question)
          |> assign(trivia_card: card)
          |> assign(answered: false)}
    end
end