defmodule WorkerSupervisor do
  use DynamicSupervisor

  def start_link(_), do: DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)

  def init(:ok), do: DynamicSupervisor.init(strategy: :one_for_one)

  def start_worker(fun) do
    spec = {MyOrchestrator.Worker, fun}
    DynamicSupervisor.start_child(__MODULE__, spec)
  end
end
