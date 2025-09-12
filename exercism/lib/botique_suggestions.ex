defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, maximum_price \\ []) do
    # Please implement the get_combinations/3 function
    max_price = Keyword.get(maximum_price, :maximum_price, 100.0)

    for t <- tops, b <- bottoms, t.base_color != b.base_color, t.price + b.price <= max_price do
      {t, b}
    end
  end
end
