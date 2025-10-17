defmodule React do
  @opaque cells :: pid

  @type cell :: {:input, String.t(), any} | {:output, String.t(), [String.t()], fun()}

  @doc """
  Start a reactive system
  """
  @spec new(cells :: [cell]) :: {:ok, pid}
  def new(cells) do
    GenServer.start_link(__MODULE__, cells)
  end

  @doc """
  Return the value of an input or output cell
  """
  @spec get_value(cells :: pid, cell_name :: String.t()) :: any()
  def get_value(cells, cell_name) do
    GenServer.call(cells, {:get, cell_name})
  end

  @doc """
  Set the value of an input cell
  """
  @spec set_value(cells :: pid, cell_name :: String.t(), value :: any) :: :ok
  def set_value(cells, cell_name, value) do
    GenServer.cast(cells, {:set, cell_name, value})
  end

  @doc """
  Add a callback to an output cell
  """
  @spec add_callback(
          cells :: pid,
          cell_name :: String.t(),
          callback_name :: String.t(),
          callback :: fun()
        ) :: :ok
  def add_callback(cells, cell_name, callback_name, callback) do
  end

  @doc """
  Remove a callback from an output cell
  """
  @spec remove_callback(cells :: pid, cell_name :: String.t(), callback_name :: String.t()) :: :ok
  def remove_callback(cells, cell_name, callback_name) do
  end

  @impl true
  def init(initial) do
    {:ok, initial}
  end

  @impl true
  def handle_call({:get, value}, _from, buffer) do
    {_, _, v} =
      Enum.find(buffer, nil, fn {:input, s, _v} ->
        s == value
      end)

    {:reply, v, buffer}
  end

  @impl true
  def handle_cast({:set, cell_name, value}, buffer) do
    map =
      buffer
      |> Enum.map(fn el ->
        cond do
          elem(el, 0) == :input and elem(el, 1) == cell_name -> {:input, cell_name, value}
          true -> el
        end
      end)

    IO.puts(inspect(map))
    {:noreply, map}
  end
end
