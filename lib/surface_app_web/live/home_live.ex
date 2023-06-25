defmodule SurfaceAppWeb.HomeLive do
  use Surface.LiveView

  alias SurfaceAppWeb.Components.{Dialog, McCard}
  alias SurfaceAppWeb.Components.Utils.{Heading, Select}
  alias SurfaceApp.Accounts
  alias SurfaceAppWeb.PlayerCountLive

  data show_dialog, :boolean, default: false
  data category, :string, default: "sports"

  data selection, :string, default: nil
  data user_id, :integer

  data random, :boolean, default: false
  data sports, :boolean, default: true

  data game_category, :string, default: "Hey"

  def mount(_params, session, socket) do
    {_email, id, _username, _user_follows, _user_post_likes} = Accounts.get_user_data_by_token(session["user_token"])
    id_string = "home_live_#{id}"
    atom = String.to_atom(id_string)
    IO.inspect(atom, label: "atom")
    Process.register(self(), atom)
    {:ok, 
      socket
      |> assign(user_id: id)}
  end

  def render(assigns) do
    ~F"""
    <div class="relative">
      <PlayerCountLive id="player_count_live" />
    </div>
    <Heading color="white" title="Surface Trivia Lobby" />
    <Heading color="white" title="Please Select Game Options" />
    <Select user_id={ @user_id } id="select" />
    """
  end

  # defp get_all_user_info(token) do
  #   IO.inspect(token, label: "Token")
  #   query = from u in User,
  #     join: us in UserStats,
  #     on: us.user_id == u.id,
  #     join: ut in UserToken,
  #     on: ut.user_id == u.id,
  #     where: ut.token == ^token,
  #     select: {u.username, u.email, u.confirmed_at, us.easy_poss_pts, us.easy_earned_pts, us.easy_games_played, us.easy_games_finished}
  #     # distinct: p.id
  #     # where: u.age > type(^age, :integer)

  #   SurfaceApp.Repo.one(query)
  # end

  # def handle_event("show_dialog", _, socket) do
  #   Dialog.show("dialog")
  #   {:noreply, socket}
  # end

  def handle_info(:reset_seconds, socket) do
    {:noreply, socket |> assign(:seconds, 15)}
  end

  def handle_info(:tick, %{assigns: %{seconds: seconds}} = socket) do
    IO.inspect seconds
    if seconds == 0 do
      send_update(McCard, id: "mc_card", timesup: true, seconds: 0)
      Dialog.show("dialog")
    end
    # if seconds == 0, do: push_event(socket, "timesup", %{timesup: true}), else: nil
    {:noreply, socket |> assign(:seconds, seconds - 1)}
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

end