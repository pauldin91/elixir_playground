defmodule CircularBuffer do
  @moduledoc """
  An API to a stateful process that fills and empties a circular buffer
  """

  @doc """
  Create a new buffer of a given capacity
  """

  defstruct [:buffer, :capacity, elements: 0]
  @spec new(capacity :: integer) :: {:ok, pid}
  def new(capacity) do
    GenServer.start_link(__MODULE__, capacity)
  end

  @doc """
  Read the oldest entry in the buffer, fail if it is empty
  """
  @spec read(buffer :: pid) :: {:ok, any} | {:error, atom}
  def read(buffer) do
    GenServer.call(buffer, :read)
  end

  @doc """
  Write a new item in the buffer, fail if is full
  """
  @spec write(buffer :: pid, item :: any) :: :ok | {:error, atom}
  def write(buffer, item) do
    GenServer.cast(buffer, {:write, item})
  end

  @doc """
  Write an item in the buffer, overwrite the oldest entry if it is full
  """
  @spec overwrite(buffer :: pid, item :: any) :: :ok
  def overwrite(buffer, item) do
    GenServer.cast(buffer, {:overwrite, item})
  end

  @doc """
  Clear the buffer
  """
  @spec clear(buffer :: pid) :: :ok
  def clear(buffer) do
    GenServer.call(buffer, :clear)
  end

  @impl true
  def init(initial) do
    {:ok, %CircularBuffer{buffer: [], capacity: initial}}
  end

  @impl true
  def handle_call(:read, _from, buffer) do
    cond do
      buffer.elements == nil -> {:reply, {:error, :empty}, []}
      true -> {:reply, hd(buffer.buffer), buffer}
    end
  end

  @impl true
  def handle_cast({:write, item}, buffer) do
    cond do
      buffer.elements == 0 ->
        {:noreply, %CircularBuffer{buffer: [item], elements: 1, capacity: buffer.capacity}}

      true ->
        {:noreply,
         %CircularBuffer{buffer: [item | buffer.buffer], elements: 1, capacity: buffer.capacity}}
    end
  end
end
