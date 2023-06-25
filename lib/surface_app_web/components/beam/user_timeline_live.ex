defmodule SurfaceAppWeb.Components.Beam.UserTimelineLive do
  use Surface.LiveView

  alias SurfaceApp.Timeline.Post
  alias SurfaceApp.Timeline
  alias SurfaceApp.Accounts
  alias SurfaceApp.Presence
  alias SurfaceAppWeb.Components.Beam.{BeamUI}

  @moduledoc """
    A small LiveView that shows the number of readers of a post using Phoenix Presence
  """
  data user_info, :tuple
  data user_posts, :list

  def mount(_params, session, socket) do
    {email, id, username, user_follows, user_post_likes} = Accounts.get_user_data_by_token(session["user_token"])
    IO.puts id
    # if connected?(socket), do:
    #   Phoenix.PubSub.subscribe(SurfaceApp.PubSub, "chirp")
    #   Phoenix.PubSub.subscribe(SurfaceApp.PubSub, "incr_likes")
    # topic = "home_page"
    # initial_count = Presence.list(topic) |> map_size
    # Go and get wherever going to store last message. Use timestamp to see when last accessed?
    user_posts = Timeline.list_user_posts(id)
    IO.inspect(user_posts, label: "User posts")

    # # Subscribe to the topic
    # SurfaceAppWeb.Endpoint.subscribe(topic)

    # # Track changes to the topic
    # Presence.track(
    #   self(),
    #   topic,
    #   socket.id,
    #   %{}
    # )

    {:ok, 
      socket
      |> assign(user_posts: user_posts)
      |> assign(user_info: {email, id, username, user_follows, user_post_likes})}
  end

  def render(assigns) do
    ~F"""
      <div class='flex basis-1/2 flex-col justify-center'>
        <BeamUI user_info={ @user_info } posts={ @user_posts } id="beam_ui" />
        <div class="mx-auto grid max-w-full w-full grid-cols-3 gap-x-5 px-8 flex-1 overflow-scroll-x">
            {#for post <- assigns.user_posts}
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
    """
  end

  @impl true
  def handle_info(%{event: "refetch_posts", payload: payload}, socket) do 
    user_posts = Timeline.list_user_posts(Kernel.elem(socket.assigns.user_info, 1))
    {:noreply, 
      socket
      |> assign(user_posts: user_posts)}
  end

  defp gravatar_url(email \\ "aaron@aaron.com") do
    hash = Base.encode16(:erlang.md5(email), case: :lower)
    "https://www.gravatar.com/avatar/#{hash}?s=200&d=robohash"
  end

  def handle_info(
        %{event: "presence_diff", payload: %{joins: joins, leaves: leaves}},
        %{assigns: %{player_count: count}} = socket
      ) do
    player_count = count + map_size(joins) - map_size(leaves)

    {:noreply, assign(socket, :player_count, player_count)}
  end
end