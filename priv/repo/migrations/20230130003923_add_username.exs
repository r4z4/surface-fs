defmodule SurfaceApp.Repo.Migrations.AddUsername do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :username, :string, null: false, default: false
    end

    create unique_index(:users, [:username])
  end
end
