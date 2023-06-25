defmodule SurfaceAppWeb.Components.PresenceDisplay do
  use Surface.LiveComponent
  alias SurfaceAppWeb.Components.Utils.{Heading}
  #{u.username, u.email, u.confirmed_at, us.easy_games_played, us.easy_games_finished, us.med_games_played, us.med_games_finished, us.hard_games_played, us.hard_games_finished, 
  # us.easy_poss_pts, us.easy_earned_pts, us.med_poss_pts, us.med_earned_pts, us.hard_poss_pts, us.hard_earned_pts}
  prop player_count, :integer

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~F"""
    <section class="absolute top-0 left-0">
      <div class="container px-5 mx-auto">
        <div class="grid grid-cols-1 items-center justify-center">
          <!-- Card -->
          <div class="flex p-4 w-full hover:scale-105 duration-500">
            <div class=" flex items-center justify-between p-4 rounded-lg bg-white shadow-indigo-50 shadow-md">
              <div>
                <h3 class="text-fuchsia-700 text-md">Players In Lobby: { @player_count }</h3>
              </div>
            </div>
          </div>
          <!-- End Card -->
        </div>
      </div>
    </section>
    """
  end
end