defmodule BotiqueSuggestionsTest do
  use ExUnit.Case

  describe "putting all together" do
    top1 = %{item_name: "Long Sleeve T-shirt", price: 19.95, color: "Deep Red", base_color: "red"}

    top2 = %{
      item_name: "Brushwood Shirt",
      price: 19.1,
      color: "Camel-Sandstone Woodland Plaid",
      base_color: "brown"
    }

    top3 = %{
      item_name: "Sano Long Sleeve Shirt",
      price: 45.47,
      color: "Linen Chambray",
      base_color: "yellow"
    }

    bottom1 = %{
      item_name: "Wonderwall Pants",
      price: 48.97,
      color: "French Navy",
      base_color: "blue"
    }

    bottom2 = %{
      item_name: "Terrena Stretch Pants",
      price: 79.95,
      color: "Cast Iron",
      base_color: "grey"
    }

    bottom3 = %{
      item_name: "Happy Hike Studio Pants",
      price: 99.0,
      color: "Ochre Red",
      base_color: "red"
    }

    tops = [top1, top2, top3]
    bottoms = [bottom1, bottom2, bottom3]

    expected = [
      {top1, bottom1},
      {top1, bottom2},
      {top2, bottom1},
      {top2, bottom2},
      {top3, bottom1}
    ]

    actual = BoutiqueSuggestions.get_combinations(tops, bottoms)
    IO.puts(Enum.count(actual))
    assert actual == expected
  end
end
