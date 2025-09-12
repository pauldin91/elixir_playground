defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, maximum_price \\ []) do
    # Please implement the get_combinations/3 function
    res =
      for t <- 0..Enum.count(tops), b <- t..Enum.count(bottoms) do
        {Enum.at(tops, t), Enum.at(bottoms, b)}
      end

    res = res |> Enum.filter(fn {t, b} -> t != nil && b != nil end)

    cond do
      maximum_price == [] ->
        Enum.filter(res, fn {t, b} -> t.base_color != b.base_color end)

      Keyword.has_key?(maximum_price, :maximum_price) ->
        Enum.filter(res, fn {t, b} ->
          t.base_color != b.base_color &&
            t.price + b.price <= Keyword.get(maximum_price, :maximum_price, 0)
        end)

      true ->
        []
    end
  end
end
