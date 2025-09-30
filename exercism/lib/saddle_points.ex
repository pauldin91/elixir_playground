defmodule SaddlePoints do
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(""), do: []

  def rows(str) do
    String.split(str, "\n")
    |> Enum.map(fn s -> String.split(s) end)
    |> Enum.map(fn s -> Enum.map(s, fn c -> String.to_integer(c) end) end)
  end

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(str) do
    String.split(str, "\n")
    |> Enum.map(fn s -> String.split(s) end)
    |> Enum.flat_map(fn s ->
      Enum.map(s, fn c -> String.to_integer(c) end) |> Enum.with_index()
    end)
    |> Enum.group_by(fn {_, i} -> i end, fn {i, _} -> i end)
    |> Enum.reduce([], fn el, acc -> acc ++ [elem(el, 1)] end)
  end

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(""), do: []

  def saddle_points(str) do
    row_max = rows(str) |> Enum.map(fn s -> Enum.with_index(s) |> Enum.max() end) |> MapSet.new()

    col_max =
      columns(str)
      |> Enum.map(fn s -> Enum.with_index(s) |> Enum.min() end)
      |> MapSet.new()

    MapSet.union(row_max, col_max)
    |> Enum.group_by(fn {s, _i} -> s end, fn {_r, i} -> i end)
    |> Enum.filter(fn {_s, v} -> Enum.count(v) > 1 end)
    |> Enum.map(fn s -> elem(s, 1) end)
  end
end
