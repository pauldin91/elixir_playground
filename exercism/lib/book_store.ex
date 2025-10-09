defmodule BookStore do
  @typedoc "A book is represented by its number in the 5-book series"
  @type book :: 1 | 2 | 3 | 4 | 5

  @doc """
  Calculate lowest price (in cents) for a shopping basket containing books.
  """
  @spec total(basket :: [book]) :: integer
  def total(basket) do
    f = split_sets(basket)
    reduce_freqs(f, 0)
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

  def possible_sets([], right, acc), do: [right | acc]

  def possible_sets([h | t], remaining, acc) do
    right = [h | remaining]

    l =
      possible_sets(
        t,
        right,
        [t, right | acc]
      )

    possible_sets(t, remaining |> Enum.reverse(), l)
    |> Enum.map(&Enum.sort(&1))
    |> Enum.uniq()
  end

  def split_sets(l) do
    freqs = Enum.frequencies(l)
    left = freqs |> Enum.filter(fn {_, f} -> f == 1 end)
    right = freqs |> Enum.filter(fn {_, f} -> f > 1 end)

    cond do
      Enum.count(left) == 1 -> [l]
      true -> do_split(left, right, []) |> Enum.filter(&(&1 != []))
    end
  end

  def do_split([], right, acc) do
    cond do
      Enum.all?(right, fn {_, o} -> o > 0 end) -> [right | acc]
      true -> acc
    end
  end

  def do_split([h | t], right, acc) do
    valid = Enum.filter(right, fn {_, f} -> f > 0 end)

    new_left = [h | Enum.map(valid, fn {k, _} -> {k, 1} end)]
    new_right = Enum.map(valid, fn {k, f} -> {k, f - 1} end)

    do_split(t, new_right, [new_left | acc])
  end
end
