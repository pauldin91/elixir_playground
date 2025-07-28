defmodule MatchingBrackets do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(string) do
    is_balanced?([h | t], 0)
  end

  defp is_balanced?([], count), do: count == 0

  defp is_balanced?([h | t], count) do
    cond do
      h == "{" or h == "[" or h == "(" -> is_balanced?(t, count + 1)
      h == "}" or h == "]" or h == ")" -> is_balanced?(t, count - 1)
      true -> count == 0
    end
  end
end
