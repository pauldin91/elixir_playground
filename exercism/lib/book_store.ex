defmodule BookStore do
  @typedoc "A book is represented by its number in the 5-book series"
  @type book :: 1 | 2 | 3 | 4 | 5

  @doc """
  Calculate lowest price (in cents) for a shopping basket containing books.
  """
  @spec total(basket :: [book]) :: integer
  def total(basket) do
    f = split_sets(basket |> Enum.frequencies() |> Map.to_list(), [])
    Enum.map(f, &reduce_freqs(&1, 0)) |> Enum.sum()
  end

  def reduce_freqs(prev, acc) do
    cond do
      Enum.count(prev) == 0 ->
        acc

      Enum.count(prev) == 1 ->
        acc +
          800 * Enum.sum_by(prev, fn {_, v} -> v end)

      true ->
        count = Enum.count(prev)

        new_values =
          Map.new(prev, fn {s, i} -> {s, i - 1} end) |> Map.filter(fn {_, i} -> i > 0 end)

        reduce_freqs(
          new_values,
          acc +
            count * (800 - calculate_disount(count))
        )
    end
  end

  def calculate_disount(books) do
    cond do
      books == 2 ->
        div(800, 20)

      books == 3 ->
        div(800, 10)

      books == 4 ->
        div(800, 5)

      true ->
        div(800, 4)
    end
  end

  def split_sets([], acc), do: acc |> Enum.filter(&(&1 != []))

  def split_sets(input, acc) do
    valid = Enum.filter(input, fn {_, f} -> f > 0 end)
    left = Enum.map(valid, fn {k, _} -> {k, 1} end)
    right = Enum.map(valid, fn {k, f} -> {k, f - 1} end) |> Enum.filter(fn {_, f} -> f > 0 end)

    split_sets(right, [left | acc])
  end

  def do_split(left, right) do
    s1 = left |> MapSet.new()
    s2 = right |> MapSet.new()
    diff = MapSet.symmetric_difference(s1, s2) |> MapSet.to_list()
    intersection = MapSet.intersection(s1, s2)

    {left, right}
  end
end
