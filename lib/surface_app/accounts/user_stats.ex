defmodule SurfaceApp.Accounts.UserStats do
  use Ecto.Schema
  import Ecto.Changeset
  alias SurfaceApp.Accounts.UserStats

  schema "user_stats" do

    field :easy_games_played, :integer
    field :med_games_played, :integer
    field :hard_games_played, :integer

    field :easy_games_finished, :integer
    field :med_games_finished, :integer
    field :hard_games_finished, :integer

    field :easy_poss_pts, :integer
    field :med_poss_pts, :integer
    field :hard_poss_pts, :integer

    field :easy_earned_pts, :integer
    field :med_earned_pts, :integer
    field :hard_earned_pts, :integer

    # belongs_to :user, SurfaceApp.Accounts.User
  end

  def __required_props_names__() do
    [:len]
  end

  # defp get_field(diff) do
  #   cond do
  #     diff == "easy" -> "easy_games_played"
  #     diff == "med" -> "med_games_played"
  #     diff == "hard" -> "hard_games_played"
  #   end
  # end

  def changeset(user_stats, params) do
    user_stats
    |> cast(params, [:id, :easy_games_played, :med_games_played, :hard_games_played, :easy_games_finished, :med_games_finished, :hard_games_finished, :easy_poss_pts, :med_poss_pts, :hard_poss_pts, :easy_earned_pts, :med_earned_pts, :hard_earned_pts])
    |> validate_required([:id])
    # |> unique_constraint(:user_id)
    # |> validate_field(:file_name)
    # |> validate_number(:easy_games_finished, less_than_or_equal_to: :easy_games_played)
    # |> validate_number(:easy_games_played, greater_than_or_equal_to: 20)
  end

  # def list_leaders(len) do
  #   query = UserStats 
  #   |> join: c in Comment, as: :comment, on: c.post_id == p.id
  #   |> where([m], m.category == ^cat)
  #   |> order_by(asc: :id)
  #   Repo.all(query)
  # end

  def list_leaders() do
    {:ok, result} = SurfaceApp.Repo.query("SELECT users.username, users.id, COALESCE(user_stats.easy_earned_pts,0) + COALESCE(user_stats.med_earned_pts,0) + COALESCE(user_stats.hard_earned_pts,0) AS total
                            FROM users INNER JOIN user_stats ON users.id = user_stats.id ORDER BY total DESC LIMIT 10;")
    final = Map.get(result, :rows)
    IO.inspect(final, label: "Final")
    final
  end

  # def update_games_played(diff, num) do
  #   field = get_field(diff)
  #   UserStats
  #   |> update([u], set: [name: "new name"])
  # end

  # def add_stats_record(user) do
  #   {:ok, id} = Map.fetch(user, :id)
  #   attrs = %UserStats{:id => id}
  #   UserStats.changeset(attrs)
  #   |> SurfaceApp.Repo.insert()
  # end

  def build_user_stats(user) do
    id = user.id
    {id, %UserStats{id: id, easy_games_played: 0, med_games_played: 0, hard_games_played: 0, easy_games_finished: 0, med_games_finished: 0, hard_games_finished: 0, easy_poss_pts: 0, med_poss_pts: 0, hard_poss_pts: 0, easy_earned_pts: 0, med_earned_pts: 0, hard_earned_pts: 0}}
  end

  def add_stats_record(user) do
    {id, user_stats} = build_user_stats(user)
    SurfaceApp.Repo.insert!(user_stats)
  end

  def increment_games_played(id, diff) do
    user_stats = SurfaceApp.Repo.get(UserStats, id)
    games_played = cond do
      diff == "easy" -> user_stats.easy_games_played
      diff == "med" -> user_stats.med_games_played
      diff == "hard" -> user_stats.hard_games_played
    end
    user_stats = Ecto.Changeset.change user_stats, '#{diff}_games_played': games_played + 1
    SurfaceApp.Repo.update(user_stats)
  end

  def increment_games_finished(id, diff) do
    user_stats = SurfaceApp.Repo.get(UserStats, id)
    games_finished = cond do
      diff == "easy" -> user_stats.easy_games_finished
      diff == "med" -> user_stats.med_games_finished
      diff == "hard" -> user_stats.hard_games_finished
    end
    user_stats = Ecto.Changeset.change user_stats, '#{diff}_games_finished': games_finished + 1
    SurfaceApp.Repo.update(user_stats)
  end

  def add_poss_pts(id, diff, num) do
    user_stats = SurfaceApp.Repo.get(UserStats, id)
    poss_pts = cond do
      diff == "easy" -> user_stats.easy_poss_pts
      diff == "med" -> user_stats.med_poss_pts
      diff == "hard" -> user_stats.hard_poss_pts
    end
    user_stats = Ecto.Changeset.change user_stats, '#{diff}_poss_pts': poss_pts + num
    SurfaceApp.Repo.update(user_stats)
  end

  def add_earned_pts(id, diff, num) do
    user_stats = SurfaceApp.Repo.get(UserStats, id)
    earned_pts = cond do
      diff == "easy" -> user_stats.easy_earned_pts
      diff == "med" -> user_stats.med_earned_pts
      diff == "hard" -> user_stats.hard_earned_pts
    end
    user_stats = Ecto.Changeset.change user_stats, '#{diff}_earned_pts': earned_pts + num
    SurfaceApp.Repo.update(user_stats)
  end


  # def list_leaders(len \\ 10) do
  #   query = from us in UserStats,
  #     join: u in User,
  #     on: us.user_id == u.id,
  #     # distinct: p.id
  #     # where: u.age > type(^age, :integer)
  #     select: {u.username, us.easy_earned_pts, us.med_earned_pts, us.hard_earned_pts},
  #     limit: ^len

  #   SurfaceApp.Repo.all(query)
  # end
end