defmodule SurfaceApp.Repo.Static.TestScript do

    json =
        File.read("../static/historyData.json")
        |> Jason.decode!()


    IO.puts(json)
end
