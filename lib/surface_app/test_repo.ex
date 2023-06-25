defmodule SurfaceApp.TestRepo do
  alias Ecto.Changeset
  alias SurfaceApp.Game.McCard

  def all(Item, _opts \\ []) do
    [
      %McCard{
        category: 'string'
        points_worth: 10
        question_text: 'string'
        answer: 'string'
        choice_one: 'string'
        choice_two: 'string'
        choice_three: 'string'
        choice_four: 'string'
      }
    ]
  end

  def insert(changeset, opts \\ [])

  def insert(%Changeset{errors: [], changes: values}, _opts) do
    {:ok, struct(McCard, values)}
  end

  def insert(changeset, _opts) do
    {:error, changeset}
  end
end