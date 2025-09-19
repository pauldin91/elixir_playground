defmodule Stack do
  use GenServer

  ## --- Client API ---

  def start_link(initial) do
    GenServer.start_link(__MODULE__, initial, name: __MODULE__)
  end

  def push(element), do: GenServer.cast(__MODULE__, {:push, element})
  def pop(), do: GenServer.call(__MODULE__, :pop)
  def peek(), do: GenServer.call(__MODULE__, :peek)

  ## --- Server Callbacks ---

  @impl true
  def init(_initial), do: {:ok, []}

  @impl true
  def handle_call(:pop, _from, [to_caller | new_state]) do
    {:reply, to_caller, new_state}
  end

  def handle_call(:pop, _from, []) do
    {:reply, :empty, []}
  end

  @impl true
  def handle_call(:peek, _from, [to_caller | _] = state) do
    {:reply, to_caller, state}
  end

  def handle_call(:peek, _from, []) do
    {:reply, :empty, []}
  end

  @impl true
  def handle_cast({:push, element}, state) do
    {:noreply, [element | state]}
  end
end
