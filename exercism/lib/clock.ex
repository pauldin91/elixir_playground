defmodule Clock do
  defstruct hour: 0, minute: 0

  @doc """
  Returns a clock that can be represented as a string:

      iex> Clock.new(8, 9) |> to_string
      "08:09"
  """
  @spec new(integer, integer) :: Clock
  def new(hour, minute) do
    do_minutes(hour, minute)
  end

  @doc """
  Adds two clock times:

      iex> Clock.new(10, 0) |> Clock.add(3) |> to_string
      "10:03"
  """
  @spec add(Clock, integer) :: Clock
  def add(%Clock{hour: hour, minute: minute}, add_minute) do
    do_minutes(hour, minute + add_minute)
  end

  defp do_minutes(hour, minute) do
    minutes = hour * 60 + minute
    %Clock{hour: Integer.mod(floor(minutes / 60), 24), minute: Integer.mod(minutes, 60)}
  end
end

defimpl String.Chars, for: Clock do
  @spec to_string(Clock) :: String.t()
  def to_string(clock) do
    m =
      cond do
        clock.minute < 10 -> "0#{clock.minute}"
        true -> "#{clock.minute}"
      end

    h =
      cond do
        clock.hour < 10 -> "0#{clock.hour}"
        true -> "#{clock.hour}"
      end

    "#{h}:#{m}"
  end
end
