defmodule SurfaceAppWeb.Components.McCard do
    # This component will have some state. So use the stateful component.
    use Surface.LiveComponent
    alias SurfaceApp.Game
    alias SurfaceAppWeb.Components.{Timer, McCardQuestion, Dialog, PlayerScore, QuestionNumber}
    alias SurfaceAppWeb.Components.Utils.{Button}
    alias SurfaceApp.Accounts.UserStats

    prop seconds, :integer
    prop game_category, :string
    prop game_length, :integer
    prop game_diff, :string

    prop user_id, :integer

    data question_id, :string
    data submission_result, :string, default: ""
    data correct_answer, :string
    data category, :string
    data points_worth, :integer
    data question_text, :string
    data answer, :string
    data choice_one, :string
    data choice_two, :string
    data choice_three, :string
    data choice_four, :string
    data answered, :boolean, default: false
    data timesup, :boolean, default: false
    # There is a :reference type available if want to extract TRef out from {:interval, TRef} tuple
    data timer, :any

    data selected, :string, default: nil

    data selected_1, :string, default: nil
    data selected_2, :string, default: nil
    data selected_3, :string, default: nil
    data selected_4, :string, default: nil

    data player_score, :integer
    data poss_pts, :integer
    data question_number, :integer

    # Use this to store our trivia card
    data trivia_card, :any

    def preload(assigns) do
      IO.inspect(assigns, label: "Preload Assigns")
      # cat = :ets.lookup(:category, "game_category")
      # IO.inspect(cat, label: "The Cat")
    end

    # Can omit mount callback if using deault values in data assigns
    def mount(socket) do
      [{_c_key, c_val}] = :ets.lookup(:current_game, "game_category")
      [{l_key, l_val}] = :ets.lookup(:current_game, "game_length")
      [{_s_key, s_val}] = :ets.lookup(:current_game, "question_set")
      questions_left = length(s_val)
      {set_card, new_set} = List.pop_at(s_val, questions_left - 1)
      card = random_card(c_val)
      correct_answer = correct_answer(card)
      # IO.inspect(s_val, label: "Question Set")
      # IO.inspect(questions_left, label: "Questions Left")
      # IO.inspect(set_card, label: "set_card")
      # IO.inspect(new_set, label: "new_set")
      # IO.inspect socket
      :ets.insert(:current_game, {"question_set", new_set})
      # TimerServer.start_link()
      # receiver_pid = spawn(Receiver, :awaiting_for_receive_messages, [])
      timer = :timer.send_interval(1000, self(), :tick)
        {:ok,
          socket
          |> assign(timer: timer)
          |> assign(correct_answer: correct_answer)
          |> assign(question_id: card.id)
          |> assign(category: card.category)
          |> assign(points_worth: card.points_worth)
          |> assign(question_text: card.question_text)
          |> assign(answer: card.answer)
          |> assign(choice_one: card.choice_one)
          |> assign(choice_two: card.choice_two)
          |> assign(choice_three: card.choice_three)
          |> assign(choice_four: card.choice_four)
          |> assign(trivia_card: card)
          |> assign(player_score: 0)
          |> assign(poss_pts: 0)
          |> assign(question_number: 1)}
    end

    defp correct_answer(card) do
        cond do
          card.answer == card.choice_one -> "1"
          card.answer == card.choice_two -> "2"
          card.answer == card.choice_three -> "3"
          card.answer == card.choice_four -> "4"
        end
    end

    def update(assigns, socket) do
      IO.puts "The Update"
      IO.inspect(self(), label: "UPDATE")
      IO.inspect(assigns, label: "ASSIGNS")
      if assigns == %{id: "mc_card", seconds: 0, timesup: true} do 
        IO.puts "Times Up!"
        {_resp, timer} = socket.assigns.timer
        # IO.inspect timer
        :timer.cancel(timer)
        assign(socket, timesup: true)
        Dialog.show("dialog")
      end
      socket = assign(socket, assigns)
      {:ok, socket}
    end

    # def handle_event("start_clock", _params, socket) do
    #   :timer.send_interval(1000, self(), :hi_from_timer)
    #   {:noreply, socket |> assign(:seconds, 15)}
    # end

    # def handle_event("timesup", _, socket) do
    #   IO.puts "Times up"
    #   {:noreply, assign(socket, timesup: true)}
    # end

    defp random_card do
        Game.list_mc_cards |> Enum.random()
    end

    defp random_card(cat) do
        Game.list_mc_cards(cat) |> Enum.random()
    end

    defp clear_selected(socket) do
        IO.puts "Clear Selected"
        {:ok,
          socket
          |> assign(selected_1: nil)
          |> assign(selected_2: nil)
          |> assign(selected_3: nil)
          |> assign(selected_4: nil)
          |> assign(selected: nil)}
    end

    def render(assigns) do
        ~F"""
        <div id="mc_card" class="grid border-solid border-2 border-black-500/50">
          <Dialog class="px-4 border-2 border-fucshia-500" title="Question:" id="dialog">
            {@question_text} <br />
            Correct Answer: <span class="text-orange-600">{ @answer }</span>
          </Dialog>
        <div class="grid items-center justify-center">
          <McCardQuestion question_text={ @question_text } />
          <Timer id="timer" seconds={ @seconds } />
          <PlayerScore id="player_score" score={ @player_score } poss_pts={ @poss_pts } />
          <QuestionNumber id="question_number" points_worth={@points_worth} number={ @question_number } length={ @game_length  } />
          <div class="grid grid-cols-2 sm:gap-1 md:gap-3 lg:gap-4">
            <div class="w-full p-2 lg:w-80">
                <div class={"p-8 bg-white rounded shadow-md", @selected_1}>
                  <Button kind="is-answer" label={ @choice_one } value="1" click={"select"} />
                </div>
            </div>
            <div class="w-full p-2 lg:w-80">
                <div class={"p-8 bg-white rounded shadow-md", @selected_2}>
                  <Button kind="is-answer" label={ @choice_two } value="2" click={"select"} />
                </div>
            </div>
            <div class="w-full p-2 lg:w-80">
                <div class={"p-8 bg-white rounded shadow-md", @selected_3}>
                  <Button kind="is-answer" label={ @choice_three } value="3" click={"select"} />
                </div>
            </div>
            <div class="w-full p-2 lg:w-80">
                <div class={"p-8 bg-white rounded shadow-md", @selected_4}>
                  <Button kind="is-answer" label={ @choice_four } value="4" click={"select"} />
                </div>
            </div>
          </div>
          <div :if={@answered} class={"submiss-result", @submission_result}>{ @submission_result }</div>
          <div :if={@answered} class="text-white font-indie">Correct Answer: { @answer }</div>
          <Button :if={@selected} label={"Submit"} click={"answer"} />
          <br />
          <Button :if={@answered} label={"New Question"}  click={"new"} />
          <!--<button :if={@answered} :on-click="new">New Question</button>-->
        </div>
        </div>
        """
    end

    # Selected will highlight. Answered if times up. Else, must actively submit.
    def handle_event("select", value, socket) do
      if socket.assigns.answered or socket.assigns.timesup do 
        {:noreply, socket}
      else
        {:ok, socket} = clear_selected(socket)
        choice = value["value"]
        to_update = "selected_#{choice}"
        # FIXME Atoms not garbage collected
        atom = String.to_existing_atom(to_update)
        {:noreply,
          socket
          |> assign(atom, "border-solid border-8 border-sky-500")
          |> assign(selected: choice)}
      end
    end

    def handle_event("answer", _value, socket) do
        # Stop timer
        {_resp, timer} = socket.assigns.timer
        :timer.cancel(timer)
        choice = socket.assigns.selected
        IO.inspect choice
        # Process.send(socket.assigns.receiver_pid, "Hi", [])
        card = socket.assigns.trivia_card
        correct_answer = socket.assigns.correct_answer
        # Always add the poss_pts, but only add earned_pts if correct
        earned_pts = if choice == correct_answer do socket.assigns.player_score + socket.assigns.points_worth else socket.assigns.player_score end
        poss_pts = socket.assigns.poss_pts + socket.assigns.points_worth 
        result = if choice == correct_answer do "Correct" else "Incorrect" end
        {:noreply,
          socket
          |> assign(answer: card.answer)
          |> assign(submission_result: result)
          |> assign(player_score: earned_pts)
          |> assign(poss_pts: poss_pts)
          |> assign(answered: true)
          |> assign(selected: false)}
    end

    def handle_event("new", _value, socket) do
        Dialog.hide("dialog")
        {:ok, socket} = clear_selected(socket)
        # I still think I should be able to use @game_category (req a restart?)
        [{_key, val}] = :ets.lookup(:current_game, "game_category")
        [{s_key, s_val}] = :ets.lookup(:current_game, "question_set")
        questions_left = length(s_val)
        IO.inspect(questions_left, label: "Questions Left")
        if questions_left == 0 do
          game_data = %{score: socket.assigns.player_score, poss_pts: socket.assigns.poss_pts, category: socket.assigns.game_category}
          :ets.insert(:current_game, {"game_data", game_data})
          persist_game_data(socket.assigns.user_id, socket.assigns.game_diff, socket.assigns.player_score, socket.assigns.poss_pts)
          # Persist User Game Data in DB
          {:noreply, push_redirect(socket, to: "/trivia/end")}
        else
          {_set_card, new_set} = List.pop_at(s_val, questions_left - 1)
          IO.inspect(new_set, label: "New Set")
          :ets.insert(:current_game, {"question_set", new_set})
          card = random_card(val)
          correct_answer = correct_answer(card)
          Process.send(self(), :reset_seconds, [:noconnect])
          timer = :timer.send_interval(1000, self(), :tick)
          {:noreply,
            socket
            |> assign(timer: timer)
            |> assign(correct_answer: correct_answer)
            |> assign(category: card.category)
            |> assign(points_worth: card.points_worth)
            |> assign(question_text: card.question_text)
            |> assign(answer: card.answer)
            |> assign(choice_one: card.choice_one)
            |> assign(choice_two: card.choice_two)
            |> assign(choice_three: card.choice_three)
            |> assign(choice_four: card.choice_four)
            |> assign(trivia_card: card)
            |> assign(answered: false)
            |> assign(timesup: false)
            |> assign(question_number: socket.assigns.question_number + 1)}
        end
    end

    defp persist_game_data(id, diff, earned, poss) do
      UserStats.increment_games_finished(id, diff)
      UserStats.add_earned_pts(id, diff, earned)
      UserStats.add_poss_pts(id, diff, poss)
    end
end