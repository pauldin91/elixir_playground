defmodule Orchestrator.Worker do
  use GenServer

  def start_link({fun, args}),
    do: GenServer.start_link(__MODULE__, {fun, args})

  @impl true
  def init({fun, args}) do
    Task.start(fn ->
      apply(fun, args)
      GenServer.cast(self(), :done)
    end)

    {:ok, %{fun: fun, args: args}}
  end

  @impl true
  def handle_cast(:done, state) do
    {:stop, :normal, state}
  end
end
