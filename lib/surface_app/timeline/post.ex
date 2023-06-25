defmodule SurfaceApp.Timeline.Post do
  use Ecto.Schema
  import Ecto.Changeset

  # defstruct username: "Aaron", body: "Default Body", likes_count: 0, reposts_count: 0, inserted_at: ~N[2000-01-01 23:00:07], updated_at: ~N[2000-01-01 23:00:07]
  # @primary_key {:id, :binary_id, autogenerate: true}
  schema "posts" do
    field :title, :string
    field :body, :string
    field :likes_count, :integer
    field :reposts_count, :integer
    field :username, :string
    field :user_id, :integer
    field :private, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body, :private, :likes_count, :reposts_count, :username, :user_id])
    |> validate_required([:title, :body, :username, :user_id])
    |> validate_length(:body, min: 2, max: 250)
    |> validate_length(:title, min: 2, max: 50)
  end

  defp validate_body(changeset) do
    changeset
    |> validate_required([:body])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(:email, max: 160)
    |> unsafe_validate_unique(:email, SurfaceApp.Repo)
    |> unique_constraint(:email)
  end

  defp validate_username(changeset) do
    changeset
    |> validate_required([:username])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(:email, max: 25)
    |> unsafe_validate_unique(:username, SurfaceApp.Repo)
    |> unique_constraint(:username)
  end

  @doc """
  A user changeset for changing the email.

  It requires the email to change otherwise an error is added.
  """
  def email_changeset(user, attrs) do
    user
    |> cast(attrs, [:email])
    # |> validate_email()
    |> case do
      %{changes: %{email: _}} = changeset -> changeset
      %{} = changeset -> add_error(changeset, :email, "did not change")
    end
  end

end
