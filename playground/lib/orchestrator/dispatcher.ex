defmodule Dispatcher do
  use GenServer

  def start_link(_args), do: GenServer.start_link(__MODULE__, [], name: __MODULE__)

  def init(_), do: {:ok, []}

  def handle_cast({:add_job, fun}, state) do
    IO.puts("Received new job: #{inspect(fun)}")
    {:noreply, [fun | state]}
  end

  def add_job(fun), do: GenServer.cast(__MODULE__, {:add_job, fun})
end
