defmodule Subsets do
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
end
