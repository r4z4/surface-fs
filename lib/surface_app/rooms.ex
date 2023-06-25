defmodule SurfaceApp.Rooms do
  @moduledoc """
  The Rooms context.
  """
  import Ecto.Query, warn: false
  import Ecto.Changeset

  alias SurfaceApp.Accounts
  alias SurfaceApp.Accounts.User
  alias SurfaceApp.Repo
  alias SurfaceApp.Rooms.Room

  @spec get_user_rooms(%User{}) :: list(%Room{})
  def get_user_rooms(%User{} = user) do
    user
    |> Repo.preload(:rooms)
    |> Map.get(:rooms)
  end

  @spec get_room!(integer) :: %Room{}
  def get_room!(id) do
    Repo.get!(Room, id)
  end

  def get_room_by!(opts) do
    Repo.get_by!(Room, opts)
  end

  def join(user, room) do
    room = Repo.preload(room, :members)

    room
    |> Room.changeset(%{})
    |> put_assoc(:members, [user | room.members])
    |> Repo.update()
  end

  def create_room(attrs) when is_map(attrs) do
    IO.inspect(attrs)
    user = Accounts.get_user!(attrs["create_room"]["user_id"])
    # attrs.nama
    # attrs.description
    # attrs.invite_token

    %Room{}
    |> Room.changeset(attrs["create_room"])
    |> put_assoc(:members, [user])
    |> Repo.insert()
    # Will they join their own room right after? They should
    # need a create_and_join function? Can I get a return from Repo.insert()
  end
end