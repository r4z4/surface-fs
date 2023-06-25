defmodule SurfaceAppWeb.Components.Beam.LikesIcon do
  use Surface.LiveComponent
  alias SurfaceAppWeb.Components.Utils.{Heading, Button}
  alias SurfaceApp.Timeline
  alias SurfaceApp.Timeline.Post
  #{u.username, u.email, u.confirmed_at, us.easy_games_played, us.easy_games_finished, us.med_games_played, us.med_games_finished, us.hard_games_played, us.hard_games_finished, 
  # us.easy_poss_pts, us.easy_earned_pts, us.med_poss_pts, us.med_earned_pts, us.hard_poss_pts, us.hard_earned_pts}
  prop user_info, :tuple
  prop post, :struct

  def mount(socket) do
    # Timeline.get_likes_count_by_id(post_id)
    {:ok, 
      socket
      |> assign(post: :initial_post)}
  end

  def render(assigns) do
    ~F"""
      <!-- A post -->
        {#if @post.id in Kernel.elem(@user_info, 3)}
        <div class="flex items-center transition hover:text-slate-600">
          <svg xmlns="http://www.w3.org/2000/svg" class="mr-1.5 h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="green" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M14 10h4.764a2 2 0 011.789 2.894l-3.5 7A2 2 0 0115.263 21h-4.017c-.163 0-.326-.02-.485-.06L7 20m7-10V5a2 2 0 00-2-2h-.095c-.5 0-.905.405-.905.905 0 .714-.211 1.412-.608 2.006L7 11v9m7-10h-2M7 20H5a2 2 0 01-2-2v-6a2 2 0 012-2h2.5" />
          </svg>
        </div>
        {#else}
        <button :on-click="incr_likes" value={ @post.id } class="flex cursor-pointer items-center transition hover:text-slate-600">
          <svg xmlns="http://www.w3.org/2000/svg" class="mr-1.5 h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M14 10h4.764a2 2 0 011.789 2.894l-3.5 7A2 2 0 0115.263 21h-4.017c-.163 0-.326-.02-.485-.06L7 20m7-10V5a2 2 0 00-2-2h-.095c-.5 0-.905.405-.905.905 0 .714-.211 1.412-.608 2.006L7 11v9m7-10h-2M7 20H5a2 2 0 01-2-2v-6a2 2 0 012-2h2.5" />
          </svg>
        </button>
        {/if}
          <span>{ @post.likes_count }</span>
    """
  end

  def handle_event("incr_likes", %{"value" => id}, socket) do
    IO.inspect(id, label: "id")
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
end