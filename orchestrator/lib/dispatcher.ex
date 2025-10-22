defmodule Orchestrator.Dispatcher do
  use GenServer
  alias Orchestrator.WorkerSupervisor

  ## --- Public API ---

  def start_link(opts) do
    name = Keyword.fetch!(opts, :name)
    GenServer.start_link(__MODULE__, [], name: name)
  end

  def enq(queue_name, fun, args) do
    GenServer.cast(via(queue_name), {:enq, {fun, args}})
  end

  ## --- GenServer callbacks ---

  @impl true
  def init(_), do: {:ok, []}

  @impl true
  def handle_cast({:enq, {fun, args}}, state) do
    WorkerSupervisor.start_worker(fun, args)
    {:noreply, state}
  end

  ## --- Helpers ---

  defp via(name), do: {:via, Registry, {Orchestrator.Registry, name}}
end
