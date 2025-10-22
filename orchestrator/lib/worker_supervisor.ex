defmodule Orchestrator.WorkerSupervisor do
  use DynamicSupervisor

  def start_link(_), do: DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)

  @impl true
  def init(:ok), do: DynamicSupervisor.init(strategy: :one_for_one)

  def start_worker(fun, args) do
    spec = {Orchestrator.Worker, {fun, args}}
    DynamicSupervisor.start_child(__MODULE__, spec)
  end

  def stop_worker(pid),
    do: DynamicSupervisor.terminate_child(__MODULE__, pid)
end
