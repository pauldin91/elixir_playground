defmodule Worker do
  use GenServer

  def start_link(fun), do: GenServer.start_link(__MODULE__, fun)

  def init(fun) do
    Task.start(fn -> fun.() end)
    # stop after starting the task
    {:stop, :normal, nil}
  end
end
