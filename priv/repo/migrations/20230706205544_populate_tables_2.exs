defmodule SurfaceApp.Repo.Migrations.PopulateTables2 do
  use Ecto.Migration
  alias SurfaceApp.Game.McCard
  alias SurfaceApp.Repo

  def change do
    Repo.insert_all(McCard, [
      %{category: "History", points_worth: 30, question_text: "In the year 1900, what were the most popular first names given to boy and girl babies born in the United States?", answer: "John and Mary", choice_one: "William and Elizabeth", choice_two: "John and Mary", choice_three: "Joseph and Catherine", choice_four: "George and Anne"}
    ])
  end
end
