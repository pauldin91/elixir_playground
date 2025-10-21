defmodule Orchestrator.Dispatcher do
  use GenServer

  def start_link(opts) do
    name = Keyword.fetch!(opts, :name)
    GenServer.start_link(__MODULE__, [], name: name)
  end

  def init(_), do: {:ok, []}

  def handle_cast({:add_job, fun}, state) do
    IO.puts("Executing job in #{inspect(self())}")
    fun.()
    {:noreply, state}
  end

  def add_job(pid, fun), do: GenServer.cast(pid, {:add_job, fun})
end
