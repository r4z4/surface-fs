defmodule SurfaceAppWeb.Components.Leaderboard do
  use Surface.LiveComponent
  alias SurfaceAppWeb.Components.Utils.{Heading}

  prop leader_names, :list
  prop leader_scores, :list
  prop leader_ids, :list

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~F"""
    <section class="text-gray-600 body-font rounded-sm bg-gray-200 flex">
      <div class="container px-5 py-5 mx-auto">
        <div class="grid grid-cols-1 items-center justify-center">
          <Heading title="Leaderboard" color="red" />
          <!-- Card -->
          <div class="flex flex-col">
            <div class="overflow-x-auto sm:-mx-6 lg:-mx-8">
              <div class="py-2 inline-block min-w-full sm:px-6 lg:px-8">
                <div class="overflow-hidden">
                  <table class="min-w-full text-center rounded-md">
                    <thead class="border-b bg-black">
                      <tr>
                        <th scope="col" class="text-sm font-medium text-white px-2 py-4">
                          Ranking
                        </th>
                        <th scope="col" class="text-sm font-medium text-white px-2 py-4">
                          User
                        </th>
                        <th scope="col" class="text-sm font-medium text-white px-2 py-4">
                          Total Score
                        </th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr class="border-b bg-gradient-to-r from-indigo-200 via-red-200 to-yellow-100 border-emerald-200">
                        <td class="text-sm text-gray-900 font-small px-2 py-4 whitespace-nowrap">
                          #1
                        </td>
                        <td class="text-sm text-gray-900 font-light px-2 py-4 whitespace-nowrap">
                          <span :if={@user_id == Enum.at(@leader_ids, 0)}>🔥</span>
                          { Enum.at(@leader_names, 0) }
                        </td>
                        <td class="text-sm text-gray-900 font-light px-2 py-4 whitespace-nowrap">
                          <span class="font-bold">{ Enum.at(@leader_scores, 0) }</span>
                        </td>
                      </tr>
                      <tr class="border-b bg-blue-100 border-blue-200">
                        <td class="text-sm text-gray-900 font-small px-2 py-4 whitespace-nowrap">
                          #2
                        </td>
                        <td class="text-sm text-gray-900 font-light px-2 py-4 whitespace-nowrap">
                          <span :if={@user_id == Enum.at(@leader_ids, 1)}>🔥</span>
                          { Enum.at(@leader_names, 1) }
                        </td>
                        <td class="text-sm text-gray-900 font-light px-2 py-4 whitespace-nowrap">
                          <span class="font-bold">{ Enum.at(@leader_scores, 1) }</span>
                        </td>
                      </tr>
                      <tr class="border-b bg-purple-100 border-purple-200">
                        <td class="text-sm text-gray-900 font-small px-2 py-4 whitespace-nowrap">
                          #3
                        </td>
                        <td class="text-sm text-gray-900 font-light px-2 py-4 whitespace-nowrap">
                          <span :if={@user_id == Enum.at(@leader_ids, 2)}>🔥</span>
                          { Enum.at(@leader_names, 2) }
                        </td>
                        <td class="text-sm text-gray-900 font-light px-2 py-4 whitespace-nowrap">
                          <span class="font-bold">{ Enum.at(@leader_scores, 2) }</span>
                        </td>
                      </tr>
                      <tr class="border-b bg-orange-100 border-orange-200">
                        <td class="text-sm text-gray-900 font-small px-2 py-4 whitespace-nowrap">
                          #4
                        </td>
                        <td class="text-sm text-gray-900 font-light px-2 py-4 whitespace-nowrap">
                          <span :if={@user_id == Enum.at(@leader_ids, 3)}>🔥</span>
                          { Enum.at(@leader_names, 3) }
                        </td>
                        <td class="text-sm text-gray-900 font-light px-2 py-4 whitespace-nowrap">
                          <span class="font-bold">{ Enum.at(@leader_scores, 3) }</span>
                        </td>
                      </tr>
                      <tr class="border-b bg-red-100 border-red-200">
                        <td class="text-sm text-gray-900 font-small px-2 py-4 whitespace-nowrap">
                          #5
                        </td>
                        <td class="text-sm text-gray-900 font-light px-2 py-4 whitespace-nowrap">
                          <span :if={@user_id == Enum.at(@leader_ids, 4)}>🔥</span>
                          { Enum.at(@leader_names, 4) }
                        </td>
                        <td class="text-sm text-gray-900 font-light px-2 py-4 whitespace-nowrap">
                          <span class="font-bold">{ Enum.at(@leader_scores, 4) }</span>
                        </td>
                      </tr>
                      <tr class="border-b bg-yellow-100 border-yellow-200">
                        <td class="text-sm text-gray-900 font-small px-2 py-4 whitespace-nowrap">
                          #6
                        </td>
                        <td class="text-sm text-gray-900 font-light px-2 py-4 whitespace-nowrap">
                          <span :if={@user_id == Enum.at(@leader_ids, 5)}>🔥</span>
                          { Enum.at(@leader_names, 5) }
                        </td>
                        <td class="text-sm text-gray-900 font-light px-2 py-4 whitespace-nowrap">
                          <span class="font-bold">{ Enum.at(@leader_scores, 5) }</span>
                        </td>
                      </tr>
                      <tr class="border-b bg-indigo-100 border-indigo-200">
                        <td class="text-sm text-gray-900 font-small px-2 py-4 whitespace-nowrap">
                          #7
                        </td>
                        <td class="text-sm text-gray-900 font-light px-2 py-4 whitespace-nowrap">
                          <span :if={@user_id == Enum.at(@leader_ids, 6)}>🔥</span>
                          { Enum.at(@leader_names, 6) }
                        </td>
                        <td class="text-sm text-gray-900 font-light px-2 py-4 whitespace-nowrap">
                          <span class="font-bold">{ Enum.at(@leader_scores, 6) }</span>
                        </td>
                      </tr>
                      <tr class="border-b bg-gray-50 border-gray-200">
                        <td class="text-sm text-gray-900 font-small px-2 py-4 whitespace-nowrap">
                          #8
                        </td>
                        <td class="text-sm text-gray-900 font-light px-2 py-4 whitespace-nowrap">
                          <span :if={@user_id == Enum.at(@leader_ids, 7)}>🔥</span>
                          { Enum.at(@leader_names, 7) }
                        </td>
                        <td class="text-sm text-gray-900 font-light px-2 py-4 whitespace-nowrap">
                          <span class="font-bold">{ Enum.at(@leader_scores, 7) }</span>
                        </td>
                      </tr>
                      <tr class="border-b bg-gray-800 boder-gray-900">
                        <td class="text-sm text-white font-medium px-2 py-4 whitespace-nowrap">
                          #9
                        </td>
                        <td class="text-sm text-white font-light px-2 py-4 whitespace-nowrap">
                          <span :if={@user_id == Enum.at(@leader_ids, 8)}>🔥</span>
                          { Enum.at(@leader_names, 8) }
                        </td>
                        <td class="text-sm text-white font-light px-2 py-4 whitespace-nowrap">
                          <span class="font-bold">{ Enum.at(@leader_scores, 8) }</span>
                        </td>
                      </tr>
                      <tr class="border-b bg-sky-100 border-sky-200">
                        <td class="text-sm text-gray-900 font-small px-2 py-4 whitespace-nowrap">
                          #10
                        </td>
                        <td class="text-sm text-gray-900 font-light px-2 py-4 whitespace-nowrap">
                          <span :if={@user_id == Enum.at(@leader_ids, 9)}>🔥</span>
                          { Enum.at(@leader_names, 9) }
                        </td>
                        <td class="text-sm text-gray-900 font-light px-2 py-4 whitespace-nowrap">
                          <span class="font-bold">{ Enum.at(@leader_scores, 9) }</span>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          </div>
          <!-- End Card -->

        </div>
      </div>
    </section>
    """
  end
end