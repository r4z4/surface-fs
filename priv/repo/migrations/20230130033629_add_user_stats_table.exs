defmodule SurfaceApp.Repo.Migrations.AddUserStatsTable do
  use Ecto.Migration

  def change do

    create table(:user_stats, primary_key: false) do
      add :id, references(:users, on_delete: :delete_all), null: false, primary_key: true

      add :easy_games_played, :integer
      add :med_games_played, :integer
      add :hard_games_played, :integer

      add :easy_games_finished, :integer
      add :med_games_finished, :integer
      add :hard_games_finished, :integer

      add :easy_poss_pts, :integer
      add :med_poss_pts, :integer
      add :hard_poss_pts, :integer

      add :easy_earned_pts, :integer
      add :med_earned_pts, :integer
      add :hard_earned_pts, :integer

    end

    create unique_index(:user_stats, [:id])
  end
end
