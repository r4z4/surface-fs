defmodule SurfaceAppWeb.GameOverLive do
  use Surface.LiveView
  alias SurfaceAppWeb.Components.Utils.{Button, Heading, Button}
  alias SurfaceApp.Accounts

  # data game_data, :struct
  data game_data, :map

  def mount(_params, session, socket) do
    {_email, id, _username, _user_follows, _user_post_likes} = Accounts.get_user_data_by_token(session["user_token"])
    id_string = "game_over_live_#{id}"
    atom = String.to_atom(id_string)
    Process.register(self(), atom)
    # ETS lookup for game stats
    game_data = %{}
    {:ok, socket |> assign(game_data: game_data)}
  end

  def render(assigns) do
    ~F"""
    <Heading color="white" title="Surface Trivia" />
    <div class="ml-4 justify-center w-auto">
      <Button click="to_home" kind="is-info">Take Me Home</Button>
    </div>
    <div class="justify-center w-3/5 border-2 border-sky-500 mt-2 mx-auto">
      <h5 class="text-center text-white">Game Stats</h5>
      <div class="justify-center w-3/5 border-2 border-white mt-2 mx-auto text-white">
        <h6>Get the game stats from socket assigns</h6>
        <p># Questions: </p>
        <p># Correct: </p>
        <p>Percentage: </p>
        <Button class="m-4" click="to_stats" kind="margined">View My Stats</Button>
      </div>
    </div>
    <!-- animation -->
      <section class="p-10 min-h-screen flex md:flex-row items-center justify-around bg-slate-800 flex-wrap sm:flex-col">

        <!-- scale -->
        <div class="h-32 w-32 relative cursor-pointer mb-5">
          <div class="absolute inset-0 bg-white opacity-25 rounded-lg shadow-2xl"></div>
          <div class="absolute inset-0 transform  hover:scale-75 transition duration-300">
            <div class="h-full w-full bg-white rounded-lg shadow-2xl"><img class="rounded-t-md" alt="" src="https://upload.wikimedia.org/wikipedia/commons/0/02/Animated_letter_G_upper_case.gif" /></div>
          </div>
        </div>

        <!-- roatate and scale -->
        <div class="h-32 w-32 relative cursor-pointer mb-5">
          <div class="absolute inset-0 bg-white opacity-25 rounded-lg shadow-2xl"></div>
          <div class="absolute inset-0 transform hover:rotate-90 hover:scale-75 transition duration-300">
            <div class="h-full w-full bg-white rounded-lg shadow-2xl"><img class="rounded-t-md" alt="" src="https://upload.wikimedia.org/wikipedia/commons/a/af/Animated_letter_A_upper_case.gif" /></div>
          </div>
        </div>

        <!-- rotate -->
        <div class="h-32 w-32 relative cursor-pointer mb-5">
          <div class="absolute inset-0 bg-white opacity-25 rounded-lg shadow-2xl"></div>
          <div class="absolute inset-0 transform  hover:rotate-45 transition duration-300">
            <div class="h-full w-full bg-white rounded-lg shadow-2xl"><img class="rounded-t-md" alt="" src="https://upload.wikimedia.org/wikipedia/commons/8/87/Animated_letter_M_upper_case.gif" /></div>
          </div>
        </div>

        <!-- rotate minus -->
        <div class="h-32 w-32 relative cursor-pointer mb-5">
          <div class="absolute inset-0 bg-white opacity-25 rounded-lg shadow-2xl"></div>
          <div class="absolute inset-0 transform  hover:-rotate-45 transition duration-300">
            <div class="h-full w-full bg-white rounded-lg shadow-2xl"><img class="rounded-t-md" alt="" src="https://upload.wikimedia.org/wikipedia/commons/3/34/Animated_letter_E_upper_case.gif" /></div>
          </div>
        </div>

        <!-- Origin -->
        <div class="h-32 w-32 relative cursor-pointer mb-5">
          <div class="absolute inset-0 bg-white opacity-25 rounded-lg shadow-2xl"></div>
          <div class="absolute inset-0 transform origin-left hover:-rotate-45 transition duration-300">
            <div class="h-full w-full bg-white rounded-lg shadow-2xl"><img class="rounded-t-md" alt="" src="https://upload.wikimedia.org/wikipedia/commons/b/bc/Animated_letter_O_upper_case.gif" /></div>
          </div>
        </div>

        <!-- translate -->
        <div class="h-32 w-32 relative cursor-pointer mb-5">
          <div class="absolute inset-0 bg-white opacity-25 rounded-lg shadow-2xl"></div>
          <div class="absolute inset-0 transform hover:-translate-x-10 transition duration-300">
            <div class="h-full w-full bg-white rounded-lg shadow-2xl"><img class="rounded-t-md" alt="" src="https://upload.wikimedia.org/wikipedia/commons/2/2f/Animated_letter_V_upper_case.gif" /></div>
          </div>
        </div>

        <div class="h-32 w-32 relative cursor-pointer mb-5">
          <div class="absolute inset-0 bg-white opacity-25 rounded-lg shadow-2xl"></div>

          <div class="absolute inset-0 transform hover:rotate-90 hover:translate-x-full hover:scale-150 transition duration-300">
            <div class="h-full w-full bg-white rounded-lg shadow-2xl"><img class="rounded-t-md" alt="" src="https://upload.wikimedia.org/wikipedia/commons/3/34/Animated_letter_E_upper_case.gif" /></div>
          </div>
        </div>

        <!-- skew -->
        <div class="h-32 w-32 relative cursor-pointer mb-5">
          <div class="absolute inset-0 bg-white opacity-25 rounded-lg shadow-2xl"></div>
          <div class="absolute inset-0 transform hover:skew-y-12 transition duration-300">
            <div class="h-full w-full bg-white rounded-lg shadow-2xl"><img class="rounded-t-md" alt="" src="https://upload.wikimedia.org/wikipedia/commons/4/4c/Animated_letter_R_upper_case.gif" /></div>
          </div>
        </div>

      </section>
    """
  end

  def handle_info(:reset_seconds, socket) do
    {:noreply, socket |> assign(:seconds, 7)}
  end


  def handle_info(:hello, socket) do
    IO.puts "Hello Received"
    {:noreply, socket}
  end

  def handle_event("update", %{"_target" => ["select", key]}, socket) do
    IO.inspect key
    {:noreply, socket |> assign(selection: key)}
    # Get back to using changesets
    # {:noreply, assign(socket |> assign(changeset: changeset))}
  end

    def handle_event("to_home", _value, socket) do
        {:noreply, push_redirect(socket, to: "/home")}
    end

    def handle_event("to_stats", _value, socket) do
        {:noreply, push_redirect(socket, to: "/home")}
    end

end