defmodule Search do
  def search([head | tail], item) do
    cond do
      head == item -> true
      head == nil -> false
      true -> search(tail, item)
    end
  end

  def search([], _item) do
    nil
  end

  def binsearch(numbers, key) do
    li = numbers |> Tuple.to_list()
    binsearch(li, 0, Enum.count(li), key)
  end

  defp binsearch(_numbers, left, right, _key) when left > right, do: {:not_found}

  defp binsearch(numbers, left, right, key) do
    middle = div(left + right, 2)

    pivot = Enum.at(numbers, middle)

    cond do
      pivot == key -> {:ok, middle}
      pivot > key -> binsearch(numbers, left, middle - 1, key)
      pivot < key -> binsearch(numbers, middle + 1, right, key)
    end
  end
end
