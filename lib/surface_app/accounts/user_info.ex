defmodule SurfaceApp.Accounts.UserInfo do
  use Ecto.Schema

  @type username :: String.t()
  @type email :: String.t()
  @type inserted_at :: %NaiveDateTime{}
  @type easy_games_played :: integer()
  @type easy_games_finished :: integer()
  @type easy_poss_pts :: integer()
  @type easy_earned_pts :: integer()

  schema "user_info" do
    field :username, :string
    field :email, :string
    field :inserted_at, :naive_datetime

    field :easy_games_played, :integer
    field :easy_games_finished, :integer
    field :easy_poss_pts, :integer
    field :easy_earned_pts, :integer

    # field :med_games_played, :integer
    # field :med_games_finished, :integer
    # field :med_poss_pts, :integer
    # field :med_earned_pts, :integer
    
    # field :hard_games_played, :integer
    # field :hard_games_finished, :integer
    # field :hard_poss_pts, :integer
    # field :hard_earned_pts, :integer
  end

  # def list_leaders(len) do
  #   query = UserStats 
  #   |> join: c in Comment, as: :comment, on: c.post_id == p.id
  #   |> where([m], m.category == ^cat)
  #   |> order_by(asc: :id)
  #   Repo.all(query)
  # end

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