defmodule TurboPhoenix.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      TurboPhoenix.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: TurboPhoenix.PubSub},
      # Start Telemetry
      TurboPhoenixWeb.Telemetry,
      # Start the endpoint when the application starts
      TurboPhoenixWeb.Endpoint
      # Starts a worker by calling: TurboPhoenix.Worker.start_link(arg)
      # {TurboPhoenix.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TurboPhoenix.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    TurboPhoenixWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
