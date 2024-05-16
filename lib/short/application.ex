defmodule Short.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ShortWeb.Telemetry,
      Short.Repo,
      {DNSCluster, query: Application.get_env(:short, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Short.PubSub},
      # Start a worker by calling: Short.Worker.start_link(arg)
      # {Short.Worker, arg},
      # Start to serve requests, typically the last entry
      ShortWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Short.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ShortWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
