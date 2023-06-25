defmodule SurfaceApp.Game.McCard do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key {:id, :binary_id, [autogenerate: true]}
  schema "mc_card" do
    field :category, :string
    field :points_worth, :integer
    field :question_text, :string
    field :answer, :string
    field :choice_one, :string
    field :choice_two, :string
    field :choice_three, :string
    field :choice_four, :string
  end

  @doc false
  def changeset(card, attrs) do
    card
    |> cast(attrs, [:id, :category, :points_worth, :question_text, :answer, :choice_one, :choice_two, :choice_three, :choice_four])
    |> validate_required([:id, :category, :points_worth, :question_text, :answer, :choice_one, :choice_two, :choice_three, :choice_four])
  end
end