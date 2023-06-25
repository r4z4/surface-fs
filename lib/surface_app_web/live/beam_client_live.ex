defmodule SurfaceAppWeb.BeamClientLive do
  use Surface.LiveView

  alias SurfaceAppWeb.Components.Utils.{Heading}
  alias SurfaceAppWeb.Components.Beam.{PostTabs, UserTimelineLive, UserFollowsLive}
  alias SurfaceApp.Timeline.Post
  alias SurfaceApp.Timeline
  alias SurfaceApp.Accounts
  alias SurfaceApp.Presence

  @moduledoc """
    A small LiveView that shows the number of readers of a post using Phoenix Presence
  """
  data user_info, :tuple
  data posts, :list
  data user_post_likes, :list
  data user_posts, :list

  def render(assigns) do
    ~F"""
    <div id={'beam_client_container_#{Kernel.elem(@user_info, 2)}'} class="grid sm:grid-cols-2 justify-center">
      <div class="grid col-span-1">
        <UserTimelineLive id={ 'user_timeline_live_#{Kernel.elem(@user_info, 2)}' } />
      </div>
      <div class="grid col-span-1">
        <UserFollowsLive id={ 'user_follows_live_#{Kernel.elem(@user_info, 2)}' } />
      </div>
    </div>
    <!-- <PostTabs id="post-tabs" posts={ @posts } public_posts={ @public_posts } user_info={ @user_info } /> -->
    """
  end

  def mount(_params, session, socket) do
    {email, id, username, user_follows, user_post_likes} = Accounts.get_user_data_by_token(session["user_token"])
    if connected?(socket), do:
      Phoenix.PubSub.subscribe(SurfaceApp.PubSub, "chirp")
      Phoenix.PubSub.subscribe(SurfaceApp.PubSub, "incr_likes")

    initial_posts = get_initial_posts(user_follows)

    {:ok, 
      socket
      |> assign(posts: initial_posts)
      |> assign(user_info: {email, id, username, user_follows, user_post_likes})}
  end

  def handle_info(
        %{event: "presence_diff", payload: %{joins: joins, leaves: leaves}},
        %{assigns: %{player_count: count}} = socket
      ) do
    player_count = count + map_size(joins) - map_size(leaves)

    {:noreply, assign(socket, :player_count, player_count)}
  end

  @impl true
  def handle_info(%{event: "incr_likes", payload: %{id: id}}, socket) do 
    IO.inspect(id, label: "ID")
    {email, user_id, username, user_follows, user_post_likes} = Accounts.get_user_data_by_id(Kernel.elem(socket.assigns.user_info, 1))
    posts = get_initial_posts(user_follows)
    new_user_post_likes = Timeline.add_post_to_and_get_likes(user_id, id)
    Timeline.incr_likes(id)
    {:noreply, 
      socket
      |> assign(posts: posts)
      |> assign(user_info: {email, user_id, username, user_follows, new_user_post_likes})}
  end

  def get_initial_posts(user_follows) do
    # %Post{} etc ...
    Timeline.list_followed_posts(user_follows)
  end
end

