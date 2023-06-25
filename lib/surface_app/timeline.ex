defmodule SurfaceApp.Timeline do
  @moduledoc """
  The Timeline context.
  """

  import Ecto.Query, warn: false
  alias SurfaceApp.Repo
  alias SurfaceApp.Timeline.{Post}

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    Repo.all(from p in Post, order_by: [desc: p.updated_at])
  end

  def list_public_posts do
    Repo.all(from p in Post, where: p.private == false, order_by: [desc: p.updated_at])
  end

  def list_followed_posts(user_follows) do
    Repo.all(from p in Post, where: p.user_id in ^user_follows, order_by: [desc: p.updated_at])
  end

  @doc """
  Gets all posts for a single user.

  Raises `Ecto.NoResultsError` if there are no Posts.

  ## Examples

      iex> list_user_posts(22)
      %Post{}

      iex> list_user_posts(45)
      ** (Ecto.NoResultsError)

  """
  def list_user_posts(id) do
    Repo.all(from p in Post, where: p.user_id == ^id, order_by: [desc: p.updated_at])
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id), do: Repo.get!(Post, id)

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}) do
    IO.inspect(attrs, label: "Attrs")
    case %Post{} |> Post.changeset(attrs) |> Repo.insert() do
      {:ok, result} ->
        IO.inspect(result, label: "Result")
      {:error, _} ->
        :error
      _ ->
        raise "No Matching Clause for create_post"
    end
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
    |> broadcast(:post_updated)
  end

  @doc """
  Deletes a post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{data: %Post{}}

  """
  #############
  ### Likes ###
  #############
  def incr_likes(id) do
    IO.inspect(id, label: "id")
    case SurfaceApp.Repo.query('UPDATE posts SET likes_count = likes_count + 1 WHERE id = #{id} RETURNING likes_count AS new_post;') do
      {:ok, result} ->
        IO.inspect(result, label: "Result")
        List.flatten(result.rows)
      :error ->
        :error
    end
  end

  def add_post_to_likes(user_id, post_id) do
    {:ok, result} = SurfaceApp.Repo.query('UPDATE users SET user_post_likes = array_append(user_post_likes, #{post_id}) WHERE id = #{user_id};')
  end

  def add_post_to_and_get_likes(user_id, post_id) do
    IO.inspect(post_id, label: "post_id")
    case SurfaceApp.Repo.query('UPDATE users SET user_post_likes = array_append(user_post_likes, #{post_id}) WHERE id = #{user_id} RETURNING user_post_likes AS new_user_post_likes;') do
      {:ok, result} ->
        List.flatten(result.rows)
      :error ->
        :error
    end
    # {:ok, result} = SurfaceApp.Repo.query('UPDATE users SET user_post_likes = array_append(user_post_likes, #{post_id}) WHERE id = #{id} RETURNING user_post_likes AS new_user_post_likes;')
    # List.flatten(result.rows)
  end
  #############
  ## Reposts ##
  #############
  def inc_reposts(%Post{id: id}) do
    {1, [post]} =
      from(p in Post, where: p.id == ^id, select: p)
      |> Repo.update_all(inc: [reposts_count: 1])

    broadcast({:ok, post}, :post_updated)
  end
  #############
  ## Follows ##
  #############
  def add_user_to_follows(cur_user_id, user_id) do
    {:ok, result} = SurfaceApp.Repo.query('UPDATE users SET user_follows = array_append(user_follows, #{user_id}) WHERE id = #{cur_user_id};')
  end

  def add_user_to_and_get_follows(cur_user_id, user_id) do
    case SurfaceApp.Repo.query('UPDATE users SET user_follows = array_append(user_follows, #{user_id}) WHERE id = #{cur_user_id} RETURNING user_follows AS new_user_follows;') do
      {:ok, result} ->
        List.flatten(result.rows)
      :error ->
        :error
    end
  end

  def subscribe do
    Phoenix.PubSub.subscribe(SurfaceApp.PubSub, "posts")
  end

  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end

  defp broadcast({:error, _reason} = error, _event), do: error
  defp broadcast({:ok, post}, event) do
    Phoenix.PubSub.broadcast(SurfaceApp.PubSub, "posts", {event, post})
    {:ok, post}
  end
end