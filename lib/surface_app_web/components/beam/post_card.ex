defmodule SurfaceAppWeb.Components.Beam.PostCard do
  use Surface.LiveComponent
  alias SurfaceAppWeb.Components.Utils.{Heading, Button}
  alias SurfaceApp.Accounts
  alias SurfaceApp.Timeline
  alias SurfaceApp.Timeline.Post
  #{u.username, u.email, u.confirmed_at, us.easy_games_played, us.easy_games_finished, us.med_games_played, us.med_games_finished, us.hard_games_played, us.hard_games_finished, 
  # us.easy_poss_pts, us.easy_earned_pts, us.med_poss_pts, us.med_earned_pts, us.hard_poss_pts, us.hard_earned_pts}
  
  prop user_info, :tuple

  data post, :struct
  data likes_count, :integer

  def mount(socket) do
    # Need to add two to account for 2 parent components as CIDs - This is not ideal
    post_id = socket.assigns.myself.cid - 2
    # IO.inspect(socket.assigns.myself.cid, label: "The Socket")
    post = Timeline.get_post!(post_id)
    {:ok, 
      socket
      |> assign(post: post)
      |> assign(likes_count: post.likes_count)}
  end

  def render(assigns) do
    ~F"""
      <!-- A post -->
        <div class="flex w-full items-center justify-between border-b pb-3">
          <div class="flex items-center space-x-3">
            <img src={gravatar_url(assigns.post.username)} class="h-8 w-8 rounded-full" />
            <div class="text-lg font-bold text-slate-700">{ assigns.post.username }</div>
          </div>
          <div class="flex items-center space-x-8">
            <button class="rounded-2xl border bg-neutral-100 px-3 py-1 text-xs font-semibold">Category</button>
            <div class="text-xs text-neutral-500">2 hours ago</div>
          </div>
        </div>

        <div class="mt-4 mb-6">
          <div class="mb-3 text-xl font-bold">{ assigns.post.title }</div>
          <div class="text-sm text-neutral-600">{ assigns.post.body }</div>
        </div>

        <div>
          <div class="flex items-center justify-between text-slate-500">
            <div class="flex space-x-4 md:space-x-8">
              <div class="flex cursor-pointer items-center transition hover:text-slate-600">
                <svg xmlns="http://www.w3.org/2000/svg" class="mr-1.5 h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M7 8h10M7 12h4m1 8l-4-4H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-3l-4 4z" />
                </svg>
                <span>{ assigns.post.reposts_count }</span>
              </div>
              {#if assigns.post.id in Kernel.elem(@user_info, 4)}
              <div class="flex items-center transition hover:text-slate-600">
                <svg xmlns="http://www.w3.org/2000/svg" class="mr-1.5 h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="green" stroke-width="2">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M14 10h4.764a2 2 0 011.789 2.894l-3.5 7A2 2 0 0115.263 21h-4.017c-.163 0-.326-.02-.485-.06L7 20m7-10V5a2 2 0 00-2-2h-.095c-.5 0-.905.405-.905.905 0 .714-.211 1.412-.608 2.006L7 11v9m7-10h-2M7 20H5a2 2 0 01-2-2v-6a2 2 0 012-2h2.5" />
                </svg>
              </div>
              {#else}
              <button :on-click="incr_likes" value={ assigns.post.id } class="flex cursor-pointer items-center transition hover:text-slate-600">
                <svg xmlns="http://www.w3.org/2000/svg" class="mr-1.5 h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M14 10h4.764a2 2 0 011.789 2.894l-3.5 7A2 2 0 0115.263 21h-4.017c-.163 0-.326-.02-.485-.06L7 20m7-10V5a2 2 0 00-2-2h-.095c-.5 0-.905.405-.905.905 0 .714-.211 1.412-.608 2.006L7 11v9m7-10h-2M7 20H5a2 2 0 01-2-2v-6a2 2 0 012-2h2.5" />
                </svg>
              </button>
              {/if}
                <span>{ assigns.likes_count }</span>
            </div>
          </div>
        </div>
    """
  end

  defp gravatar_url(email \\ "aaron@aaron.com") do
    hash = Base.encode16(:erlang.md5(email), case: :lower)
    "https://www.gravatar.com/avatar/#{hash}?s=200&d=robohash"
  end

  # def handle_info(
  #       %{event: "presence_diff", payload: %{joins: joins, leaves: leaves}},
  #       %{assigns: %{user_id_list: id_list, users: users}} = socket
  #     ) do
  #     IO.inspect(joins, label: "Joins")
  #   user_id = Map.keys(joins)
  #   user_id_list = [Map.keys(joins) | id_list] |> List.delete(Map.keys(leaves))
  #   users = get_users(joins) ++ users |> List.delete(get_users(leaves))
  #   IO.inspect(users, label: "Users List")
  #   IO.inspect(Kernel.length(users), label: "Username List Length")

  #   {:noreply, socket 
  #     |> assign(user_id: user_id)}
  # end

  def handle_event("incr_likes", %{"value" => id}, socket) do
    Process.send(self(), %{event: "incr_likes", payload: %{id: id}}, [:noconnect])
    {:noreply, socket}
    # IO.inspect(id, label: "id")
    # uname = Kernel.elem(socket.assigns.user_info, 2) 
    # u_id = Kernel.elem(socket.assigns.user_info, 1) 
    # user_likes = Kernel.elem(socket.assigns.user_info, 4)
    # attrs = %{id: u_id, post_id: id}
    # new_user_post_likes = Timeline.add_post_to_and_get_likes(u_id, id)
    # Timeline.incr_likes(id)
    # # Process.send(self(), :incr_likes, [:noconnect])
    # # Run through changeset and save
    # # new_user_info = socket.assigns.user_info |> Tuple.delete_at(3) |> Tuple.insert_at(3, List.insert_at(user_likes, 0, id))
    # # {:noreply, assign(socket, :user_info, new_user_info)}
    # {:noreply, 
    #   socket
    #   |> assign(likes_count: socket.assigns.likes_count + 1)
    #   |> assign(user_post_likes: new_user_post_likes)}
  end
end