# Can run this with mix run benchmark.exs

list = Enum.to_list(1..10_000)
tuple = List.to_tuple(list)
map_fun = fn i -> [i, i * i] end

{list_time, _func_result} = :timer.tc(&Enum.at/2, [list, 2222])
IO.inspect(list_time, label: "List Time")
{tup_time, _func_result} = :timer.tc(&Kernel.elem/2, [tuple, 2222])
IO.inspect(tup_time, label: "Tup Time")

Benchee.run(
  %{
    "flat_map" => fn -> Enum.flat_map(list, map_fun) end,
    "map.flatten" => fn -> list |> Enum.map(map_fun) |> List.flatten() end
  },
  time: 10,
  memory_time: 2
)

Benchee.run(
  %{
    "EnumAt" => fn -> Enum.at(list, 2222) end,
    "KernelElem" => fn -> Kernel.elem(tuple, 2222) end
  },
  time: 10,
  memory_time: 2
)