defmodule SurfaceApp.Repo.Migrations.CreateMcCardTable do
  use Ecto.Migration

  def change do
    create table(:mc_card, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:category, :string)
      # add :id, :binary_id, primary_key: true, default: fragment("uuid_generate_v4()")
      add(:points_worth, :integer)
      add(:question_text, :text)
      add(:answer, :string)
      add(:choice_one, :string)
      add(:choice_two, :string)
      add(:choice_three, :string)
      add(:choice_four, :string)

    end

    create(unique_index(:mc_card, [:id]))
  end
end