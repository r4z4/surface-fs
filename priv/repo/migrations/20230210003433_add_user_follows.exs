defmodule SurfaceApp.Repo.Migrations.AddUserFollows do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :user_follows, {:array, :integer}, null: false, default: [1]
      add :user_post_likes, {:array, :integer}, null: false, default: []
      # # For when using binary_id for autogenerate purposes
      # add :user_post_likes, {:array, :binary_id}, null: false, default: []
    end
  end
end
