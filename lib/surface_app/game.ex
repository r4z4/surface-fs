defmodule SurfaceApp.Game do

    alias __MODULE__
    alias SurfaceApp.Game.McCard
    alias SurfaceApp.Repo
    import Ecto.Query
    alias SurfaceApp.Game.GameCard

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

    defp cat_strs(cat) do
        IO.inspect(cat, label: "cat in Cat Strs")
        cond do
          cat == "Science" -> ["Science"]
          cat == "Movies" -> ["Movies"]
          cat == "Sports" -> ["Sports"]
          cat == "World" -> ["World"]
          cat == "Literature" -> ["Literature", "Literature-HP"]
          cat == "Random" -> ["Random"]
          cat == "USA" -> ["USA"]
          cat == "Tech" -> ["Tech"]
          cat == "Music" -> ["Music"]
          cat == "Animals" -> ["Animals"]
        end
      end

    def list_mc_cards(cat, len, diff) do
        IO.inspect(cat, label: "Cat")
        IO.inspect(len, label: "Length")
        query = McCard 
        |> where([m], m.points_worth in ^diff_ints(diff))
        # |> where([m], m.category in ^cat_strs(cat))
        # cat is already a list now
        |> where([m], m.category in ^cat)
        |> order_by(fragment("RANDOM()"))
        |> limit(^len)
        IO.inspect(query, label: "Query")
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