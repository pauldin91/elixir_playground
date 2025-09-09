defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    di = [1000, 500, 100, 50, 10, 5, 1]

    next("", "", di, number)
  end

  @spec next(binary(), any(), [integer()], integer()) :: binary()
  def next(l, _, [], number), do: l <> String.duplicate(mapping(number), number)

  def next(l, _, _, 0), do: l

  def next(l, prev, [h | t], number) do
    x = rem(number, h)
    y = div(number, h)

    res =
      small_mapping(String.duplicate(mapping(h), y))
      |> String.replace(String.duplicate(mapping(h), 4), mapping(h) <> mapping(prev))

    next(l <> res, h, t, x)
  end

  def small_mapping(c) do
    cond do
      c == 900 -> "CM"
      c == 400 -> "CD"
      c == 90 -> "XC"
      c == 40 -> "XL"
      c == 9 -> "IX"
      c == 4 -> "IV"
      true -> c
    end
  end

  def mapping(c) do
    cond do
      c == 1000 -> "M"
      c == 500 -> "D"
      c == 100 -> "C"
      c == 50 -> "L"
      c == 10 -> "X"
      c == 5 -> "V"
      c == 1 -> "I"
      true -> ""
    end
  end
end
