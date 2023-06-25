defmodule SurfaceAppWeb.Components.Beam.TestTabs do
  use Surface.LiveComponent
  alias SurfaceAppWeb.Components.Utils.{Heading, Button}
  alias SurfaceAppWeb.Components.Beam.PostForm
  #{u.username, u.email, u.confirmed_at, us.easy_games_played, us.easy_games_finished, us.med_games_played, us.med_games_finished, us.hard_games_played, us.hard_games_finished, 
  # us.easy_poss_pts, us.easy_earned_pts, us.med_poss_pts, us.med_earned_pts, us.hard_poss_pts, us.hard_earned_pts}
  prop user_info, :tuple
  prop username, :string
  prop posts, :list

  data composing, :boolean, default: false

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~F"""
<ul class="flex border-b border-gray-100">
  <li class="flex-1">
    <a class="relative block p-4" href="">
      <span
        class="absolute inset-x-0 -bottom-px h-px w-full bg-pink-600"
      ></span>

      <div class="flex items-center justify-center">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          class="h-5 w-5 flex-shrink-0 text-gray-500"
          fill="none"
          viewBox="0 0 24 24"
          stroke="currentColor"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            stroke-width="2"
            d="M12 6V4m0 2a2 2 0 100 4m0-4a2 2 0 110 4m-6 8a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4m6 6v10m6-2a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4"
          />
        </svg>

        <span class="ml-3 text-sm font-medium text-gray-900"> Settings </span>
      </div>
    </a>
  </li>

  <li class="flex-1">
    <a class="relative block p-4" href="">
      <div class="flex items-center justify-center">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          class="h-5 w-5 flex-shrink-0 text-gray-500"
          fill="none"
          viewBox="0 0 24 24"
          stroke="currentColor"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            stroke-width="2"
            d="M7 8h10M7 12h4m1 8l-4-4H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-3l-4 4z"
          />
        </svg>

        <span class="ml-3 text-sm font-medium text-gray-900"> Messages </span>
      </div>
    </a>
  </li>

  <li class="flex-1">
    <a class="relative block p-4" href="">
      <div class="flex items-center justify-center">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          class="h-5 w-5 flex-shrink-0 text-gray-500"
          fill="none"
          viewBox="0 0 24 24"
          stroke="currentColor"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            stroke-width="2"
            d="M5 8h14M5 8a2 2 0 110-4h14a2 2 0 110 4M5 8v10a2 2 0 002 2h10a2 2 0 002-2V8m-9 4h4"
          />
        </svg>

        <span class="ml-3 text-sm font-medium text-gray-900"> Archive </span>
      </div>
    </a>
  </li>

  <li class="flex-1">
    <a class="relative block p-4" href="">
      <div class="flex items-center justify-center">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          class="h-5 w-5 flex-shrink-0 text-gray-500"
          fill="none"
          viewBox="0 0 24 24"
          stroke="currentColor"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            stroke-width="2"
            d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"
          />
        </svg>

        <span class="ml-3 text-sm font-medium text-gray-900">
          Notifications
        </span>
      </div>
    </a>
  </li>
</ul>
    """
  end

  defp gravatar_url(email \\ "aaron@aaron.com") do
    hash = Base.encode16(:erlang.md5(email), case: :lower)
    "https://www.gravatar.com/avatar/#{hash}?s=200&d=robohash"
  end

  def handle_event("new_post", _value, socket) do
    current_state = socket.assigns.composing
    {:noreply,
      socket
      |> assign(composing: !current_state)}
  end
end