defmodule SurfaceAppWeb.Components.Beam.UserFollowsLive do
  use Surface.LiveView

  alias SurfaceApp.Timeline.Post
  alias SurfaceAppWeb.Components.Beam.PostCard
  alias SurfaceApp.Timeline
  alias SurfaceApp.Accounts
  alias SurfaceApp.Presence

  @moduledoc """
    A small LiveView that shows the number of readers of a post using Phoenix Presence
  """
  data user_info, :tuple
  data user_follows_posts, :list

  def mount(_params, session, socket) do
    {email, id, username, user_follows, user_post_likes} = Accounts.get_user_data_by_token(session["user_token"])
    user_follows_posts = Timeline.list_followed_posts(user_follows)
    IO.inspect(user_follows_posts, label: "User follows posts")

    {:ok, 
      socket
      |> assign(user_follows_posts: user_follows_posts)
      |> assign(user_info: {email, id, username, user_follows, user_post_likes})}
  end

  def render(assigns) do
    ~F"""
      <div class='flex basis-1/2 flex-col items-center justify-center'>
        <div class="mx-auto grid max-w-full w-full xl:grid-cols-3 gap-x-2 xl:gap-x-4 px-4 flex-1 overflow-scroll-x">
            {#for post <- assigns.user_follows_posts}
            <!-- A post -->
              <div class="flex w-full items-center justify-between border-b pb-3">
                <div class="flex items-center space-x-3">
                  <img src={gravatar_url(post.username)} class="h-8 w-8 rounded-full" />
                  <div class="text-lg font-bold text-slate-700">{ post.username }</div>
                </div>
                <div class="flex items-center space-x-8">
                  <button class="rounded-2xl border bg-neutral-100 px-3 py-1 text-xs font-semibold">Category</button>
                  <div class="text-xs text-neutral-500">2 hours ago</div>
                </div>
              </div>

              <div class="mt-4 mb-6">
                <div class="mb-3 text-xl font-bold">{ post.title }</div>
                <div class="text-sm text-neutral-600">{ post.body }</div>
              </div>

              <div>
                <div class="flex items-center justify-between text-slate-500">
                  <div class="flex space-x-4 md:space-x-8">
                    <div class="flex cursor-pointer items-center transition hover:text-slate-600">
                      <svg xmlns="http://www.w3.org/2000/svg" class="mr-1.5 h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M7 8h10M7 12h4m1 8l-4-4H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-3l-4 4z" />
                      </svg>
                      <span>{ post.reposts_count }</span>
                    </div>
                    {#if post.id in Kernel.elem(@user_info, 4)}
                    <div class="flex items-center transition hover:text-slate-600">
                      <svg xmlns="http://www.w3.org/2000/svg" class="mr-1.5 h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="green" stroke-width="2">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M14 10h4.764a2 2 0 011.789 2.894l-3.5 7A2 2 0 0115.263 21h-4.017c-.163 0-.326-.02-.485-.06L7 20m7-10V5a2 2 0 00-2-2h-.095c-.5 0-.905.405-.905.905 0 .714-.211 1.412-.608 2.006L7 11v9m7-10h-2M7 20H5a2 2 0 01-2-2v-6a2 2 0 012-2h2.5" />
                      </svg>
                    </div>
                    {#else}
                    <button :on-click="incr_likes" value={ post.id } class="flex cursor-pointer items-center transition hover:text-slate-600">
                      <svg xmlns="http://www.w3.org/2000/svg" class="mr-1.5 h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M14 10h4.764a2 2 0 011.789 2.894l-3.5 7A2 2 0 0115.263 21h-4.017c-.163 0-.326-.02-.485-.06L7 20m7-10V5a2 2 0 00-2-2h-.095c-.5 0-.905.405-.905.905 0 .714-.211 1.412-.608 2.006L7 11v9m7-10h-2M7 20H5a2 2 0 01-2-2v-6a2 2 0 012-2h2.5" />
                      </svg>
                    </button>
                    {/if}
                      <span>{ post.likes_count }</span>
                  </div>
                </div>
              </div>
            {/for}
        </div>
      </div>
    """
  end

  defp gravatar_url(email \\ "aaron@aaron.com") do
    hash = Base.encode16(:erlang.md5(email), case: :lower)
    "https://www.gravatar.com/avatar/#{hash}?s=200&d=robohash"
  end

  def handle_event("incr_likes", %{"value" => id}, socket) do
    new_user_post_likes = Timeline.add_post_to_and_get_likes(Kernel.elem(socket.assigns.user_info, 1), id)
    new_likes_count = Timeline.incr_likes(id)
    IO.inspect(new_likes_count, label: "New likes count")
    IO.inspect(socket.assigns.user_follows_posts, label: "Before")
    {int_id, _} = Integer.parse(id)
    new_user_follows_posts = replace_post(socket.assigns.user_follows_posts, int_id, List.first(new_likes_count))
    IO.inspect(new_user_follows_posts, label: "After")
    {:noreply, 
      socket
      |> assign(user_follows_posts: new_user_follows_posts)
      |> assign(user_info: Tuple.delete_at(socket.assigns.user_info, 4) |> Tuple.insert_at(4, new_user_post_likes))}
  end


  def replace_post(old, id, new) do
    Enum.map(old, fn x -> if x.id == id, do: Map.replace!(x, :likes_count, new), else: x end)
  end

  def handle_info(
        %{event: "presence_diff", payload: %{joins: joins, leaves: leaves}},
        %{assigns: %{player_count: count}} = socket
      ) do
    player_count = count + map_size(joins) - map_size(leaves)

    {:noreply, assign(socket, :player_count, player_count)}
  end
end