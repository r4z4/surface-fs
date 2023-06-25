defmodule SurfaceApp.Repo do
  use Ecto.Repo,
    otp_app: :surface_app,
    adapter: Ecto.Adapters.Postgres
end
