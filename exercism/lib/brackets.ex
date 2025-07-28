defmodule MatchingBrackets do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(string) do
    is_balanced?(to_charlist(string), [])
  end

  defp is_balanced?([], list), do: length(list) == 0

  defp is_balanced?([h_src | t_src], list) do
    cond do
      h_src == ?{ or h_src == ?[ or h_src == ?( ->
        is_balanced?(t_src, [h_src | list])

      (h_src == ?) and hd(list) == ?() or
        (h_src == ?] and hd(list) == ?[) or
          (h_src == ?} and hd(list) == ?{) ->
        is_balanced?(t_src, tl(list))

      t_src != [] && list != [] ->
        is_balanced?(t_src, list)

      true ->
        length(list) == 0
    end
  end
end
