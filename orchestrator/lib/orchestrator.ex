defmodule Orchestrator do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Registry, keys: :unique, name: Orchestrator.Registry},
      {DynamicSupervisor, strategy: :one_for_one, name: Orchestrator.WorkerSupervisor},
      {DynamicSupervisor, strategy: :one_for_one, name: Orchestrator.DispatcherSupervisor}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Orchestrator.Supervisor)
  end

  def create_queue(name) do
    DynamicSupervisor.start_child(
      Orchestrator.DispatcherSupervisor,
      {Orchestrator.Dispatcher, name: via(name)}
    )
  end

  def lookup_queue(name) do
    case Registry.lookup(Orchestrator.Registry, name) do
      [{pid, _}] -> pid
      [] -> nil
    end
  end

  defp via(name), do: {:via, Registry, {Orchestrator.Registry, name}}
end
