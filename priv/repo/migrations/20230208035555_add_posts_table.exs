defmodule SurfaceApp.Repo.Migrations.AddPostsTable do
  use Ecto.Migration

  def change do

    # create table(:posts, primary_key: false) do
    create table(:posts) do
      # add(:id, :binary_id, primary_key: true)
      add :title, :text
      add :body, :text
      add :likes_count, :integer
      add :reposts_count, :integer
      add :username, :text
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :private, :boolean

      timestamps()
    end
    create unique_index(:posts, [:id])
  end
end