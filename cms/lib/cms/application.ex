defmodule Cms.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Cms.Repo,
      # Start the Telemetry supervisor
      CmsWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Cms.PubSub},
      # Start the Endpoint (http/https)
      CmsWeb.Endpoint
      # Start a worker by calling: Cms.Worker.start_link(arg)
      # {Cms.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Cms.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    CmsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
