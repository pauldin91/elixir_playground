defmodule SaddlePoints do
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(""), do: []

  def rows(str) do
    String.split(str, "\n")
    |> Enum.map(fn s -> String.split(s) |> Enum.map(fn c -> String.to_integer(c) end) end)
  end

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(str) do
    String.split(str, "\n")
    |> Enum.flat_map(fn s ->
      String.split(s) |> Enum.map(fn c -> String.to_integer(c) end) |> Enum.with_index()
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
    row_max =
      rows(str)
      |> Enum.map(fn s -> s end)
      |> Enum.with_index()
      |> Enum.map(fn {v, x} -> {Enum.max(v), x + 1} end)

    col_max =
      columns(str)
      |> Enum.map(fn s -> s end)
      |> Enum.with_index()
      |> Enum.map(fn {v, x} -> {Enum.min(v), x + 1} end)

    Enum.flat_map(col_max, fn {val, index} ->
      Enum.filter(row_max, fn {v1, _i} -> val == v1 end)
      |> Enum.map(fn {_v, i} -> {i, index} end)
    end)
    |> Enum.sort_by(fn {f, s} -> {f, s} end)
  end
end
