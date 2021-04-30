defmodule Anais.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Anais.Repo,
      # Start the Telemetry supervisor
      AnaisWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Anais.PubSub},
      # Start the Endpoint (http/https)
      AnaisWeb.Endpoint
      # Start a worker by calling: Anais.Worker.start_link(arg)
      # {Anais.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Anais.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    AnaisWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
