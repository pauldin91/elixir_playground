defmodule PalindromeProducts do
  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1) do
    pals =
      Enum.to_list(max_factor..min_factor//-1)

    for n <- pals, k <- pals do
      n * k
    end
  end

  def palindrome?(s) do
    rev = String.graphemes(s) |> Enum.reverse()

    String.graphemes(s)
    |> Enum.zip(rev)
    |> Enum.with_index()
    |> Enum.take_while(fn {{_k1, _k2}, idx} ->
      idx <= Integer.floor_div(String.length(s), 2)
    end)
    |> Enum.all?(fn {{k1, k2}, _idx} -> k1 == k2 end)
  end
end
