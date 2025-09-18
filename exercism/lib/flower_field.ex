defmodule FlowerField do
  @doc """
  Annotate empty spots next to flowers with the number of flowers next to them.
  """
  @spec annotate([String.t()]) :: [String.t()]
  def annotate(board) do
    String.graphemes(board)
    |> Enum.with_index()
  end
end
