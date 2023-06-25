defmodule SurfaceAppWeb.PlayerCountLive do
  use Surface.LiveView

  alias SurfaceAppWeb.Components.PresenceDisplay
  alias SurfaceApp.Presence

  @moduledoc """
    A small LiveView that shows the number of readers of a post using Phoenix Presence
  """
  data player_count, :integer

  def render(assigns) do
    ~F"""
    <button :on-click="social">
      <PresenceDisplay player_count={ @player_count } id="player_count" />
    </button>
    """
  end

  def mount(_params, _session, socket) do
    # before subscribing, get current_player_count
    topic = "home_page"
    initial_count = Presence.list(topic) |> map_size

    # Subscribe to the topic
    SurfaceAppWeb.Endpoint.subscribe(topic)

    # Track changes to the topic
    Presence.track(
      self(),
      topic,
      socket.id,
      %{}
    )

    {:ok, assign(socket, :player_count, initial_count)}
  end

  def handle_info(
        %{event: "presence_diff", payload: %{joins: joins, leaves: leaves}},
        %{assigns: %{player_count: count}} = socket
      ) do
    player_count = count + map_size(joins) - map_size(leaves)

    {:noreply, assign(socket, :player_count, player_count)}
  end

  def handle_event("social", _value, socket) do
    {:noreply, 
      socket 
      |> push_redirect(to: "/social")}
    # Get back to using changesets
    # {:noreply, assign(socket |> assign(changeset: changeset))}
  end
end