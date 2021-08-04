defmodule Sandbox.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      SandboxWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Sandbox.PubSub},
      # Start the Endpoint (http/https)
      SandboxWeb.Endpoint
      # Start a worker by calling: Sandbox.Worker.start_link(arg)
      # {Sandbox.Worker, arg}
    ]
    Sandbox.Base.Cache.init()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Sandbox.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SandboxWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
