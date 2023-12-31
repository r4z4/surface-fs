defmodule SurfaceApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      SurfaceApp.Repo,
      {Finch, name: SurfaceFinch},
      # Start the Telemetry supervisor
      SurfaceAppWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: SurfaceApp.PubSub},
      # Start the Endpoint (http/https)
      SurfaceAppWeb.Endpoint,
      SurfaceApp.Presence,
      SurfaceApp.ThinWrapper
      # Start a worker by calling: SurfaceApp.Worker.start_link(arg)
      # {SurfaceApp.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SurfaceApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SurfaceAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
