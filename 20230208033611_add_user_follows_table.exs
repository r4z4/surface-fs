defmodule SurfaceApp.Repo.Migrations.AddUserFollowsTable do
  use Ecto.Migration

  def change do

    create table(:user_follows, primary_key: false) do
      add :id, :integer, null: false, primary_key: true
      add :follower_id, references(:users, on_delete: :delete_all), null: false
      add :following_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end
    create unique_index(:user_follows, [:id])
  end
end