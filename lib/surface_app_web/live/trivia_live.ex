defmodule SurfaceAppWeb.TriviaLive do
  use Surface.LiveView

  alias SurfaceApp.Game
  alias SurfaceApp.Accounts.{User, UserStats, UserToken}
  alias SurfaceAppWeb.Components.{Dialog, Leaderboard, McCard, StatsDisplay}
  alias SurfaceAppWeb.Components.Utils.{Heading}
  import Ecto.Query, only: [from: 2]

  alias SurfaceApp.Accounts.UserStats
  alias SurfaceApp.Accounts

  data show_dialog, :boolean, default: false
  data seconds, :integer, default: 15

  data game_category, :string
  data game_diff, :string
  data game_length, :integer

  data user_info, :tuple

  data leader_names, :list
  data leader_scores, :list

  data question_set, :list

  def mount(%{"category" => cat, "length" => length, "diff" => diff}, session, socket) do
    {_email, id, _username, _user_follows, _user_post_likes} = Accounts.get_user_data_by_token(session["user_token"])
    id_string = "trivia_live_#{id}"
    atom = String.to_atom(id_string)
    Process.register(self(), atom)
    set = get_question_set(cat, length, diff)
    info = get_all_user_info(session["user_token"])
    :ets.new(:current_game, [:set, :protected, :named_table])
    :ets.insert(:current_game, {"question_set", set})
    :ets.insert(:current_game, {"game_category", cat})
    :ets.insert(:current_game, {"game_diff", diff})
    :ets.insert(:current_game, {"game_length", length})
    # Get leaders by category. If choose sports, show sports leaders etc.. 
    [leader_names, leader_scores] = get_leaders_list()
    {:ok, 
      socket 
      |> assign(user_info: info)
      |> assign(game_category: cat)
      |> assign(game_diff: diff)
      |> assign(game_length: length)
      |> assign(leader_names: leader_names)
      |> assign(leader_scores: leader_scores)}
  end

  def render(assigns) do
    ~F"""
    <Heading title="Surface Trivia" color="white" size="medium" />
    <div class="grid grid-cols-1 lg:grid-cols-5 gap-2">
      <div class="grid col-span-1">
        <StatsDisplay user_info={ @user_info } id="user_stats" />
      </div>
      <div class="grid col-span-1 lg:col-span-3">
        <McCard id="mc_card" user_id={ Kernel.elem(@user_info, 0) } game_category={ @game_category } game_length={ @game_length } game_diff={ @game_diff } seconds={ @seconds }/>
      </div>
      <div class="grid col-span-1">
        <Leaderboard leader_names={ @leader_names } leader_scores={ @leader_scores } id="leaderboard" />
      </div>
    </div>
    """
  end

  defp get_all_user_info(token) do
    IO.inspect(token, label: "Token")
    query = from u in User,
      join: us in UserStats,
      on: us.id == u.id,
      join: ut in UserToken,
      on: ut.user_id == u.id,
      where: ut.token == ^token,
      select: {u.id, u.username, u.email, u.confirmed_at, us.easy_games_played, us.easy_games_finished, us.med_games_played, us.med_games_finished, us.hard_games_played, us.hard_games_finished, 
                us.easy_poss_pts, us.easy_earned_pts, us.med_poss_pts, us.med_earned_pts, us.hard_poss_pts, us.hard_earned_pts}
      # distinct: p.id
      # where: u.age > type(^age, :integer)

    SurfaceApp.Repo.one(query)
  end

  # def handle_event("show_dialog", _, socket) do
  #   Dialog.show("dialog")
  #   {:noreply, socket}
  # end

  defp get_question_set(cat, length) do
    Game.list_mc_cards(cat, length)
  end

  defp get_question_set(cat, length, diff) do
    Game.list_mc_cards(cat, length, diff)
  end

  defp get_leaders_list() do
    leader_list = UserStats.list_leaders()
    leader_names = Enum.map(leader_list, fn item -> List.first(item) end)
    leader_scores = Enum.map(leader_list, fn item -> List.last(item) end)
    [leader_names, leader_scores]
  end

  # def handle_info({:game_category, cat}, socket) do
  #   {:noreply, socket |> assign(:game_category, cat)}
  # end
  def handle_info(:reset_seconds, socket) do
    {:noreply, socket |> assign(:seconds, 15)}
  end

  def handle_info(:tick, %{assigns: %{seconds: seconds}} = socket) do
    if seconds == 0 do
      send_update(McCard, id: "mc_card", timesup: true, seconds: 0)
      Dialog.show("dialog")
    end
    # if seconds == 0, do: push_event(socket, "timesup", %{timesup: true}), else: nil
    {:noreply, socket |> assign(:seconds, seconds - 1)}
  end

end