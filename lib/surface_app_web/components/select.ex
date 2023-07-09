defmodule SurfaceAppWeb.Components.Select do
    use Surface.LiveComponent
    alias SurfaceApp.Accounts.UserStats
    alias SurfaceAppWeb.Components.Utils.{Button, ButtonCard}

    prop user_id, :integer

    data game_category, :list, default: []
    data game_diff, :string, default: nil
    data game_length, :integer, default: nil

    data diff_selected, :boolean, default: false

    data diff_easy, :string, default: nil
    data diff_med, :string, default: nil
    data diff_hard, :string, default: nil

    data length_selected, :boolean, default: false

    data length_5, :string, default: nil
    data length_10, :string, default: nil
    data length_15, :string, default: nil

    data cat_selected, :integer, default: 0

    data selected_cats, :list, default: []

    def render(assigns) do
        ~F"""
        <div id="select-container" class="grid items-center mt-8 border-solid border-2 border-white-500/5 justify-center px-5">
        <div class="grid grid-cols-2 grid-rows-1">
         <div class="col-span-1 pl-4"><h5 class="text-sky-600 font-medium mb-2 mt-2 text-left">Number of Questions</h5></div>
         <div class="col-span-1 pr-4"><h5 class="text-sky-600 font-medium mb-2 mt-2 text-right">Difficulty</h5></div>
        </div>
          <div class="grid sm:grid-cols-9 md:grid-cols-9 lg:grid-cols-9 gap-3">
                <div class={"p-4 col-span-1 bg-slate-200 rounded shadow-md", @length_5}>
                  <Button kind="is-select" label={ "5" } value={5} click={"length_select"} />
                </div>
                <div class={"p-4 col-span-1 bg-slate-200 rounded shadow-md", @length_10}>
                  <Button kind="is-select" label={ "10" } value={10} click={"length_select"} />
                </div>
                <div class={"p-4 col-span-1 bg-slate-200 rounded shadow-md", @length_15}>
                  <Button kind="is-select" label={ "15" } value={15} click={"length_select"} />
                </div>
                
                <div class={"col-span-1"}>
                </div>
                <div class={"col-span-1"}>
                </div>
                <div class={"col-span-1"}>
                </div>

                <div class={"py-4 col-span-1 bg-slate-200 rounded shadow-md", @diff_easy}>
                  <Button kind="is-select" label={ "Easy" } value={"easy"} click={"diff_select"} />
                </div>
                <div class={"py-4 col-span-1 bg-slate-200 rounded shadow-md", @diff_med}>
                  <Button kind="is-select" label={ "Med" } value={"med"} click={"diff_select"} />
                </div>
                <div class={"py-4 col-span-1 bg-slate-200 rounded shadow-md", @diff_hard}>
                  <Button kind="is-select" label={ "Hard" } value={"hard"} click={"diff_select"} />
                </div>
          </div>
          <div class="grid sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-5 gap-2 mt-8">
            <div class="w-1/1 p-4">
                <div class={"p-2 bg-slate-200 rounded shadow-md", is_selected(@game_category, "Science")}>
                  <ButtonCard kind="is-cat-select" label="Science" value="Science" click={"select"} />
                </div>
            </div>
            <div class="w-1/1 p-4">
                <div class={"p-2 bg-slate-200 rounded shadow-md", is_selected(@game_category, "Sports")}>
                  <ButtonCard kind="is-cat-select" label="Sports" value="Sports" click={"select"} />
                </div>
            </div>
            <div class="w-1/1 p-4">
                <div class={"p-2 bg-slate-200 rounded shadow-md", is_selected(@game_category, "World")}>
                  <ButtonCard kind="is-cat-select" label="World" value="World" click={"select"} />
                </div>
            </div>
            <div class="w-1/1 p-4">
                <div class={"p-2 bg-slate-200 rounded shadow-md", is_selected(@game_category, "Movies")}>
                  <ButtonCard kind="is-cat-select" label="Movies" value="Movies" click={"select"} />
                </div>
            </div>
            <div class="w-1/1 p-4">
                <div class={"p-2 bg-slate-200 rounded shadow-md", is_selected(@game_category, "Literature")}>
                  <ButtonCard kind="is-cat-select" label="Literature" value="Literature" click={"select"} />
                </div>
            </div>
            <div class="w-1/1 p-4">
                <div class={"p-2 bg-slate-200 rounded shadow-md", is_selected(@game_category, "Usa")}>
                  <ButtonCard label="USA" value="Usa" click={"select"} />
                </div>
            </div>
            <div class="w-1/1 p-4">
                <div class={"p-2 bg-slate-200 rounded shadow-md", is_selected(@game_category, "Random")}>
                  <ButtonCard label="Random" value="Random" click={"select"} />
                </div>
            </div>
            <div class="w-1/1 p-4">
                <div class={"p-2 bg-slate-200 rounded shadow-md", is_selected(@game_category, "Music")}>
                  <ButtonCard label="Music" value="Music" click={"select"} />
                </div>
            </div>
            <div class="w-1/1 p-4">
                <div class={"p-2 bg-slate-200 rounded shadow-md", is_selected(@game_category, "Animals")}>
                  <ButtonCard label="Animals" value="Animals" click={"select"} />
                </div>
            </div>
            <div class="w-1/1 p-4">
                <div class={"p-2 bg-slate-200 rounded shadow-md", is_selected(@game_category, "Tech")}>
                  <ButtonCard label="Tech" value="Tech" click={"select"} />
                </div>
            </div>
          </div>

          <!--<button :if={@cat_selected} :on-click="play_game">Play Game</button>-->
          <Button :if={@cat_selected > 0 && @diff_selected && @length_selected} click="play_game" kind="is-info">Play The Game</Button>

        </div>
        """
    end

    @spec cat_string(String.t()) :: String.t()
    defp cat_string(val) do
      cond do
        val == "1" -> "Science"
        val == "2" -> "Sports"
        val == "3" -> "World"
        val == "4" -> "Movies"
        val == "5" -> "Literature"
        val == "6" -> "USA"
        val == "7" -> "Random"
        val == "8" -> "Music"
        val == "9" -> "Animals"
        val == "10" -> "Tech"
      end
    end

    defp is_selected(list, str) do
      if Enum.member?(list, str) do
        "border-solid border-8 border-sky-500"
      end
    end

    @spec cat_list_string([String.t()]) :: String.t()
    defp cat_list_string(val) do
      Enum.join(val, "-")
    end

    defp clear_selected(socket) do
        IO.puts "Clear Selected"
        {:ok,
          socket
          |> assign(cat_selected: 0)
          |> assign(game_category: [])}
    end

    defp unselect_option(socket, choice) do
      IO.inspect(choice, label: "choice")
      {:ok,
        socket
        |> assign(cat_selected: socket.assigns.cat_selected - 1)
        |> assign(game_category: Enum.reject(socket.assigns.game_category, &String.starts_with?(&1, choice)))}
  end

    defp clear_length_selected(socket) do
        IO.puts "Clear Length Selected"
        {:ok,
          socket
          |> assign(length_selected: false)
          |> assign(game_length: nil)
          |> assign(length_5: nil)
          |> assign(length_10: nil)
          |> assign(length_15: nil)}
    end
    
    defp clear_diff_selected(socket) do
        IO.puts "Clear Diff Selected"
        {:ok,
          socket
          |> assign(diff_selected: false)
          |> assign(game_diff: nil)
          |> assign(diff_easy: nil)
          |> assign(diff_med: nil)
          |> assign(diff_hard: nil)}
    end

    # Selected will highlight. Answered if times up. Else, must actively submit.
    def handle_event("select", value, socket) do
      # value is %{"value" => "1"}
      IO.puts(socket.assigns.cat_selected)
      choice = value["value"]
      # If user clicks highlighted, we unhighlight
      if choice in socket.assigns.game_category do 
        # {:ok, socket} = clear_selected(socket)
        {:ok, socket} = unselect_option(socket, choice)
        {:noreply, socket}
      else
        # {:ok, socket} = clear_selected(socket)
        # Only allow a max of three categories
        if socket.assigns.cat_selected >= 3 do
          IO.puts "Ugh"
          {:noreply,
          socket |> put_flash(:warning, "Sorry, maximum of 3 categories.")}
        else
          to_update = "selected_#{choice}"
          # FIXME Atoms not garbage collected
          IO.inspect socket.assigns.game_category
          {:noreply,
            socket
            |> assign(cat_selected: socket.assigns.cat_selected + 1)
            |> assign(game_category: [choice | socket.assigns.game_category])}
        end
      end
    end
    #### Length Select

    def handle_event("length_select", value, socket) do
      choice = value["value"]
      # If user clicks highlighted, we unhighlight
      if choice == socket.assigns.game_length do 
        {:ok, socket} = clear_length_selected(socket)
        {:noreply, socket}
      else
        {:ok, socket} = clear_length_selected(socket)
        choice = value["value"]
        to_update = "length_#{choice}"
        # FIXME Atoms not garbage collected
        atom = String.to_existing_atom(to_update)
        IO.inspect atom
        {:noreply,
          socket
          |> assign(atom, "border-solid border-8 border-sky-500")
          |> assign(length_selected: true)
          |> assign(game_length: choice)}
      end
    end

    #### Difficulty Select

    def handle_event("diff_select", value, socket) do
      choice = value["value"]
      # If user clicks highlighted, we unhighlight
      if choice == socket.assigns.game_diff do 
        {:ok, socket} = clear_diff_selected(socket)
        {:noreply, socket}
      else
        {:ok, socket} = clear_diff_selected(socket)
        choice = value["value"]
        to_update = "diff_#{choice}"
        # FIXME Atoms not garbage collected
        atom = String.to_existing_atom(to_update)
        IO.inspect atom
        {:noreply,
          socket
          |> assign(atom, "border-solid border-8 border-sky-500")
          |> assign(diff_selected: true)
          |> assign(game_diff: choice)}
      end
    end

    def handle_event("play_game", value, socket) do
        category = socket.assigns.game_category
        length = socket.assigns.game_length
        diff = socket.assigns.game_diff
        UserStats.increment_games_played(socket.assigns.user_id, diff)
        cat_string = cat_list_string(category)
        # Process.send(:example_live, {:game_category, cat_string}, [:noconnect])
        {:noreply, push_redirect(socket, to: "/trivia/#{length}/#{diff}/#{cat_string}")}
    end
end