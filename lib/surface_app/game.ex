defmodule SurfaceApp.Game do

    alias __MODULE__
    alias SurfaceApp.Game.McCard
    alias SurfaceApp.Repo
    import Ecto.Query
    alias SurfaceApp.Game.GameCard

    def list_cards do
        [
            %GameCard{question: "What is the capital of Nebraska?", answer: "Lincoln"},
            %GameCard{question: "What is the capital of Kansas?", answer: "Topeka"},
            %GameCard{question: "What is the capital of California?", answer: "Sacramento"},
            %GameCard{question: "What is the capital of Iowa?", answer: "Des Moines"},
        ]
    end

    def list_mc_cards(cat) do
        IO.inspect(cat, label: "Cat")
        query = McCard 
        |> where([m], m.category == ^cat)
        |> order_by(asc: :id)
        Repo.all(query)
    end

    def list_mc_cards(cat, len) do
        IO.inspect(cat, label: "Cat")
        IO.inspect(len, label: "Length")
        query = McCard 
        |> where([m], m.category == ^cat)
        |> order_by(fragment("RANDOM()"))
        |> limit(^len)
        Repo.all(query)
    end

    defp diff_ints(diff) do
      IO.inspect(diff, label: "diff in Diff Ints")
      cond do
        diff == "easy" -> [10,20]
        diff == "med" -> [30,40]
        diff == "hard" -> [50,60]
      end
    end

    def list_mc_cards(cat, len, diff) do
        IO.inspect(cat, label: "Cat")
        IO.inspect(len, label: "Length")
        query = McCard 
        |> where([m], m.category == ^cat)
        |> where([m], m.points_worth in ^diff_ints(diff))
        |> order_by(fragment("RANDOM()"))
        |> limit(^len)
        Repo.all(query)
    end

    def list_mc_cards do
        query = McCard |> order_by(asc: :id)
        Repo.all(query)
    end

    def get_question(id) do
        Repo.get(McCard, id)
    end
end