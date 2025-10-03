defmodule Transpose do
  @doc """
  Given an input text, output it transposed.

  Rows become columns and columns become rows. See https://en.wikipedia.org/wiki/Transpose.

  If the input has rows of different lengths, this is to be solved as follows:
    * Pad to the left with spaces.
    * Don't pad to the right.

  ## Examples

    iex> Transpose.transpose("ABC\\nDE")
    "AD\\nBE\\nC"

    iex> Transpose.transpose("AB\\nDEF")
    "AD\\nBE\\n F"
  """

  @spec transpose(String.t()) :: String.t()
  def transpose(""), do: ""

  def transpose(input) do
    s = String.split(input, "\n")

    mx = Enum.max_by(s, &String.length(&1)) |> String.length()

    s
    |> Enum.flat_map(
      &(String.pad_trailing(&1, mx, " ")
        |> String.graphemes()
        |> Enum.with_index())
    )
    |> Enum.group_by(fn {_, i} -> i end, fn {v, _} -> v end)
    |> Enum.sort_by(fn {i, _v} -> i end)
    |> Enum.flat_map(fn {_, s} -> [s] end)

    #   1) test mixed line length (TransposeTest)
    #  test/transpose_test.exs:101
    #  Assertion with == failed
    #  code:  assert Transpose.transpose(input) == expected
    #  left:  "TAAA\nh   \nelll\n ooi\nlnnn\nogge\nn e.\nglr \nei  \nsnl \ntei \n .n \nl e \ni . \nn   \ne   \n."
    #  right: "TAAA\nh   \nelll\n ooi\nlnnn\nogge\nn e.\nglr\nei \nsnl\ntei\n .n\nl e\ni .\nn\ne\n."
    #  stacktrace:
    #    test/transpose_test.exs:127: (test)

    |> Enum.join("\n")
    |> String.trim()
  end
end
