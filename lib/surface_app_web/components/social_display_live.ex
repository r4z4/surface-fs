defmodule SurfaceAppWeb.Components.SocialDisplayLive do
  use Surface.LiveView
  alias SurfaceAppWeb.Components.Utils.{Heading}
  alias SurfaceAppWeb.Components.{UserCard}
  alias SurfaceAppWeb.Components.Utils.{Heading}
  alias SurfaceAppWeb.Components.{SocialDisplay, ChatMessages}
  alias SurfaceAppWeb.BeamClientLive
  alias SurfaceAppWeb.ChatLive
  alias SurfaceApp.Presence
  alias SurfaceApp.Accounts
  alias SurfaceApp.Accounts.{User}

  alias SurfaceApp.Timeline
  #{u.username, u.email, u.confirmed_at, us.easy_games_played, us.easy_games_finished, us.med_games_played, us.med_games_finished, us.hard_games_played, us.hard_games_finished, 
  # us.easy_poss_pts, us.easy_earned_pts, us.med_poss_pts, us.med_earned_pts, us.hard_poss_pts, us.hard_earned_pts}

  @doc "The background color"
  data rounded, :boolean, default: false
  data max_width, :string, values: ["sm", "md", "lg"], default: "sm"

  data users, :list
  data user_id_list, :list

  data current_user_follows, :list
  data current_user_id, :integer

  data lobby_user_list, :list

  def mount(_params, session, socket) do
    topic = "social"
    initial_user_id_list = Presence.list(topic) |> Map.keys()
    initial_users = Presence.list(topic) |> get_users()
    {_email, id, username, user_follows, _user_post_likes} = Accounts.get_user_data_by_token(session["user_token"])
    # before subscribing, get current_player_count
    if connected?(socket) do
      # Subscribe to the topic
      SurfaceAppWeb.Endpoint.subscribe(topic)

      # Track changes to the topic
      {:ok, _} = Presence.track(self(), topic, id, %{
          # FIXME Get whole user eventually
          # username: user[:username]
          username: username,
          joined_at: :os.system_time(:seconds)
      })
    end

    Phoenix.PubSub.subscribe(SurfaceApp.PubSub, "chat")

    {:ok,
      socket
      |> assign(:user_id_list, initial_user_id_list)
      |> assign(users: initial_users)
      |> assign(current_user_follows: user_follows)
      |> assign(current_user_id: id)
      # |> assign(:users, %{})
      # |> handle_joins(Presence.list(@presence))
    }
  end

  def render(assigns) do
    ~F"""
    <style>
      .card {
        @apply overflow-hidden shadow-lg;
      }
      .content {
        @apply border-1 border-black-500 px-6 py-4 text-gray-700 text-base;
      }
      .header {
        @apply p-6 font-semibold text-2xl text-teal-600 w-full bg-gray-200;
      }
      .footer {
        @apply px-6 py-4;
      }
    </style>
    <section class="">
      <div class="container px-1 mx-auto">
      <Heading title="Surface Trivia Social" />
        <div class="flex items-center justify-center">
          <!-- Card -->
                {#for user <- assigns.users}
                  <div class="flex">
                    <div class=" flex items-center justify-between p-2 rounded-lg bg-white shadow-indigo-50 shadow-md">
                      <div>
                      <div class={"card", 'max-w-#{assigns.max_width}', "rounded-2xl": assigns.rounded}>
                        <div class="content">
                          <div class="flex items-center justify-center">
                              <!--{#if Enum.member?(@current_user_follows, user.id)}-->
                              {#if user.id == assigns.current_user_id}
                              ✴
                              {#elseif user.id in assigns.current_user_follows}
                                <button :on-click="toggle_follow" value={ user.id } id="follow_btn">✅</button>{" "}
                              {#else}
                                <button :on-click="toggle_follow" value={ user.id } id="follow_btn">⛶</button>{" "}
                              {/if}
                            {user.username}
                          </div>
                        </div>
                      </div>
                      </div>
                    </div>
                  </div>
                {/for}
          <!-- End Card -->
        </div>
      </div>
    </section>
    """
  end

  def handle_event("toggle_follow", %{"value" => id}, socket) do
    new_user_follows = Timeline.add_user_to_and_get_follows(socket.assigns.current_user_id, id)
    IO.inspect(new_user_follows, label: "New User Follows")
    {:noreply, 
      socket
      |> assign(current_user_follows: new_user_follows)}
  end

  def handle_info(
        %{event: "presence_diff", payload: %{joins: joins, leaves: leaves}},
        %{assigns: %{user_id_list: id_list, users: users}} = socket
      ) do
      IO.inspect(joins, label: "Joins")
    user_id_list = [Map.keys(joins) | id_list] |> List.delete(Map.keys(leaves))
    users = get_users(joins) ++ users |> List.delete(get_users(leaves))
    IO.inspect(users, label: "Users List")
    IO.inspect(Kernel.length(users), label: "Username List Length")

    {:noreply, socket 
      |> assign(user_id_list: user_id_list)
      |> assign(users: users)}
  end

  # def get_name_list(joins) do
  #   for x <- joins, do: Kernel.elem(x, 1) |> Map.get(:metas) |> List.first() |> Map.get(:username)
  # end
  @spec get_users(map()) :: list(%User{})
  def get_users(joins) do
    for x <- Map.keys(joins), do: Accounts.get_user!(x)
  end
end