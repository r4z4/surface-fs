defmodule SurfaceAppWeb.Components.StatsDisplay do
  use Surface.LiveComponent
    alias SurfaceAppWeb.Components.Utils.{Heading}
  #{u.username, u.email, u.confirmed_at, us.easy_games_played, us.easy_games_finished, us.med_games_played, us.med_games_finished, us.hard_games_played, us.hard_games_finished, 
  # us.easy_poss_pts, us.easy_earned_pts, us.med_poss_pts, us.med_earned_pts, us.hard_poss_pts, us.hard_earned_pts}
  prop user_info, :tuple

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~F"""
    <section class="text-gray-600 body-font bg-gray-50 flex">
      <div class="container px-5 py-5 mx-auto">
        <div class="grid grid-cols-2 items-center justify-center">
        <div class="grid col-span-2">
          <Heading title="User Stats" />
          <h3 class="mt-2 text-xl font-bold text-center text-blue-500 text-left">{ Kernel.elem(@user_info, 1) }</h3>
        </div>
          <!-- Card -->
        <div class="grid col-span-1 md:col-span-2">
          <div class="flex p-4 w-full hover:scale-105 duration-500">
            <div class=" flex items-center justify-between p-4 rounded-lg bg-white shadow-indigo-50 shadow-md">
              <div>
                <h2 class="text-gray-900 text-lg font-bold">Point Totals</h2>
                <h3 class="text-gray-900 text-md">Earned / Possible</h3>
                <p class="text-sm font-semibold text-gray-400">Easy Game Points: { Kernel.elem(@user_info, 11) } / { Kernel.elem(@user_info, 10) }</p>
                <p class="text-sm font-semibold text-gray-400">Med Game Points: { Kernel.elem(@user_info, 13) } / { Kernel.elem(@user_info, 12) }</p>
                <p class="text-sm font-semibold text-gray-400">Hard Game Points: { Kernel.elem(@user_info, 15) } / { Kernel.elem(@user_info, 14) }</p>
              </div>
            </div>
          </div>
        </div>
          <!-- End Card -->

          <!-- Card -->
        <div class="grid col-span-1 md:col-span-2">
          <div class="flex p-4 w-full hover:scale-105 duration-500">
            <div class=" flex items-center justify-between p-4 rounded-lg bg-white shadow-indigo-50 shadow-md">
              <div>
                <h2 class="text-gray-900 text-lg font-bold">User Details</h2>
                <p class="text-sm font-semibold text-gray-400">Joined: { Kernel.elem(@user_info, 3) }</p>
                <h3 class="text-gray-900 text-md">Games Finished / Games Played</h3>
                <p class="text-sm font-semibold text-gray-400">Easy Games: { Kernel.elem(@user_info, 5) } / { Kernel.elem(@user_info, 4) }</p>
                <p class="text-sm font-semibold text-gray-400">Med Games: { Kernel.elem(@user_info, 7) } / { Kernel.elem(@user_info, 6) }</p>
                <p class="text-sm font-semibold text-gray-400">Hard Games: { Kernel.elem(@user_info, 9) } / { Kernel.elem(@user_info, 8) }</p>
                <button class="text-sm mt-6 px-4 py-2 bg-blue-400 text-white rounded-lg  tracking-wider hover:bg-blue-300 outline-none">User Profile</button>
              </div>
              <div
                class="hidden md:flex bg-gradient-to-tr from-blue-500 to-blue-400 w-20 lg:w-28 h-20 lg:h-28 rounded-full shadow-2xl shadow-blue-400 border-white border-dashed border-2 flex justify-center items-center ">
                <div>
                  <h1 class="text-white lg:text-2xl">Basic</h1>
                </div>
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