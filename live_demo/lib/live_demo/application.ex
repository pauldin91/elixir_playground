defmodule LiveDemo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LiveDemoWeb.Telemetry,
      LiveDemo.Repo,
      {DNSCluster, query: Application.get_env(:live_demo, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: LiveDemo.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: LiveDemo.Finch},
      # Start a worker by calling: LiveDemo.Worker.start_link(arg)
      # {LiveDemo.Worker, arg},
      # Start to serve requests, typically the last entry
      LiveDemoWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LiveDemo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LiveDemoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
