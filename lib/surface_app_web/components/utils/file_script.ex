defmodule SurfaceApp.Repo.Static.FileScript do
    def get_json do
        json =
            File.read("../static/historyData.json")
            |> Jason.decode!()

        IO.puts(json)
    end
end
