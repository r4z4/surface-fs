defmodule SurfaceApp.Game.GameCard do
  use Ecto.Schema
  import Ecto.Changeset

  schema "game_cards" do
    field :answer, :string
    field :question, :string

    timestamps()
  end

  @doc false
  def changeset(card, attrs) do
    card
    |> cast(attrs, [:question, :answer])
    |> validate_required([:question, :answer])
  end
end