defmodule Spiral do
  @doc """
  Given the dimension, return a square matrix of numbers in clockwise spiral order.
  """
  @spec matrix(dimension :: integer) :: list(list(integer))
  def matrix(0), do: []
  def matrix(1), do: [[1]]

  def matrix(dimension) do
    for i <- 0..(dimension - 1), j <- 0..(dimension - 1) do
      cond do
        i < j ->
          dimension * i + j + 1

        j == dimension - 1 ->
          i + j * dimension + 1

        i == dimension - 1 ->
          i * dimension - j - 1

        true ->
          dimension - i + j * dimension + 1
      end
    end
    |> Enum.chunk_every(dimension)
  end
end
