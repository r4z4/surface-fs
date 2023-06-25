defmodule SurfaceAppWeb.Components.Beam.PostTabs do
  use Surface.LiveComponent
  alias SurfaceApp.Timeline
  alias SurfaceApp.Timeline.Post
  alias SurfaceAppWeb.Components.Beam.PostCard
  #{u.username, u.email, u.confirmed_at, us.easy_games_played, us.easy_games_finished, us.med_games_played, us.med_games_finished, us.hard_games_played, us.hard_games_finished, 
  # us.easy_poss_pts, us.easy_earned_pts, us.med_poss_pts, us.med_earned_pts, us.hard_poss_pts, us.hard_earned_pts}
  prop user_info, :tuple
  prop username, :string
  prop posts, :list
  prop list_public_posts, :list

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~F"""
      <div class='flex items-center justify-center'>
        <ul class="mx-auto grid max-w-full w-full grid-cols-3 gap-x-5 px-8">
          <li class="">
            <input class="peer sr-only" type="radio" value="yes" name="answer" id="yes" checked />
            <label class="flex justify-center cursor-pointer rounded-full border border-gray-300 bg-white py-2 px-4 hover:bg-gray-50 focus:outline-none peer-checked:border-transparent peer-checked:ring-2 peer-checked:ring-indigo-500 transition-all duration-500 ease-in-out" for="yes">Home Feed</label>

                <div class="absolute bg-white shadow-lg left-0 p-6 border mt-2 border-indigo-300 rounded-lg w-[97vw] mx-auto transition-all duration-500 ease-in-out translate-x-40 opacity-0 invisible peer-checked:opacity-100 peer-checked:visible peer-checked:translate-x-1">
                  <div class="px-6 py-4 flex-1 overflow-scroll-x">
                      {#for post <- @public_posts}
                      <!-- A post -->
                      {#if post.username == "admin"}
                          <div class="flex items-start mb-4 sender-match">
                          <img src={gravatar_url(post.username)} class="w-10 h-10 rounded mr-3" />
                              <div class="flex flex-col">
                              <div class="flex items-end">
                                  <span class="font-bold text-md mr-2 font-sans">{ post.username }</span>
                                  <span class="text-gray-500 text-xs font-400">{ post.inserted_at }</span>
                              </div>
                              <p class="font-400 text-md text-gray-800 pt-1">{ post.body }</p>
                              </div>
                          </div>
                      {#else}
                          <div class="flex items-start mb-4 no-sender-match">
                          <img src={gravatar_url(post.username)} class="w-10 h-10 rounded mr-3" />
                              <div class="flex flex-col">
                              <div class="flex items-end">
                                  <span class="font-bold text-md mr-2 font-sans">{ post.username }</span>
                                  <span class="text-gray-500 text-xs font-400">{ post.inserted_at }</span>
                              </div>
                              <p class="font-400 text-md text-gray-800 pt-1">{ post.body }</p>
                              </div>
                          </div>
                      {/if}
                      {/for}
                  </div>
            </div>
          </li>

          <li class="">
            <input class="peer sr-only" type="radio" value="no" name="answer" id="no" />
            <label class="flex justify-center cursor-pointer rounded-full border border-gray-300 bg-white py-2 px-4 hover:bg-gray-50 focus:outline-none peer-checked:border-transparent peer-checked:ring-2 peer-checked:ring-indigo-500 transition-all duration-500 ease-in-out" for="no">My Feed</label>

            <div class="absolute bg-white shadow-lg left-0 p-6 border mt-2 border-indigo-300 rounded-lg w-[97vw] mx-auto transition-all duration-500 ease-in-out translate-x-40 opacity-0 invisible peer-checked:opacity-100 peer-checked:visible peer-checked:translate-x-1">
              <div class="px-6 py-4 flex-1 overflow-scroll-x">
                {#for post <- @posts}
                <!-- A post -->
                <PostCard id={post.id} user_info={ @user_info } />
                {/for}
              </div>
            </div>
          </li>

          <li class="">
            <input class="peer sr-only" type="radio" value="yesno" name="answer" id="yesno" />
            <label class="flex justify-center cursor-pointer rounded-full border border-gray-300 bg-white py-2 px-4 hover:bg-gray-50 focus:outline-none peer-checked:border-transparent peer-checked:ring-2 peer-checked:ring-indigo-500 transition-all duration-500 ease-in-out " for="yesno">Direct Messages</label>

            <div class="absolute bg-white shadow-lg left-0 p-6 border mt-2 border-indigo-300 rounded-lg w-[97vw] mx-auto transition-all duration-500 ease-in-out translate-x-40 opacity-0 invisible peer-checked:opacity-100 peer-checked:visible peer-checked:translate-x-1">
              <div class="px-6 py-4 flex-1 overflow-scroll-x">
                Placeholder
              </div>
            </div>
          </li>
        </ul>
      </div>
    """
  end

  defp gravatar_url(email \\ "aaron@aaron.com") do
    hash = Base.encode16(:erlang.md5(email), case: :lower)
    "https://www.gravatar.com/avatar/#{hash}?s=200&d=robohash"
  end

  def handle_event("incr_likes", %{"value" => id}, socket) do
    IO.inspect(id, label: "id_test_test_test")
    uname = Kernel.elem(socket.assigns.user_info, 1) 
    u_id = Kernel.elem(socket.assigns.user_info, 0) 
    user_likes = Kernel.elem(socket.assigns.user_info, 3)
    attrs = %{id: u_id, post_id: id}
    Timeline.add_post_to_likes(u_id, id)
    Timeline.incr_likes(id)
    # Process.send(self(), :incr_likes, [:noconnect])
    # Run through changeset and save
    new_user_info = socket.assigns.user_info |> Tuple.delete_at(3) |> Tuple.insert_at(3, List.insert_at(user_likes, 0, id))
    {:noreply, assign(socket, :user_info, new_user_info)}
  end

  def handle_event("new_post", _value, socket) do
    current_state = socket.assigns.composing
    {:noreply,
      socket
      |> assign(composing: !current_state)}
  end
end