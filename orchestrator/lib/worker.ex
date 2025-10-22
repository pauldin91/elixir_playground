defmodule Orchestrator.Worker do
  use GenServer

  def start_link({fun, args}),
    do: GenServer.start_link(__MODULE__, {fun, args})

  @impl true
  def init({fun, args}) do
    spawn(fn ->
      apply(fun, args)
      GenServer.stop(self(), :normal)
    end)

    {:ok, %{fun: fun, args: args}}
  end
end
