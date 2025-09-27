defmodule Tournament do
  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  @points %{"W" => 3, "L" => 0, "D" => 1}
  def tally(input) do
    headers =
      """
      Team                           | MP |  W |  D |  L |  P
      """

    result = do_tally(input, %{}) |> Map.to_list()
    do_format(result, headers) |> String.trim("\n")
  end

  def do_format([], headers), do: headers

  def do_format([{name, score} | t], headers) do
    do_format(
      t,
      headers <>
        name <>
        String.duplicate(" ", 31 - String.length(name)) <>
        "|  #{Map.get(score, "MP", 0)} |  #{Map.get(score, "W", 0)} |  #{Map.get(score, "D", 0)} |  #{Map.get(score, "L", 0)} |  #{Map.get(score, "P", 0)}\n"
    )
  end

  def do_tally([], result), do: result

  def do_tally([h | t], result) do
    outcome = String.split(h, ";")

    cond do
      Enum.at(outcome, 2) == "win" ->
        result = update_values(outcome, 0, result)
        do_tally(t, result)

      Enum.at(outcome, 2) == "draw" ->
        result = update_values(outcome, -1, result)
        do_tally(t, result)

      true ->
        result = update_values(outcome, 1, result)
        do_tally(t, result)
    end
  end

  def update_values(outcome, win_team, result) do
    cond do
      win_team == -1 ->
        {_, result} =
          Map.get_and_update(result, Enum.at(outcome, 0), fn score ->
            update_score(score, "D")
          end)

        {_, result} =
          Map.get_and_update(result, Enum.at(outcome, 1), fn score ->
            update_score(score, "D")
          end)

        result

      true ->
        {_, result} =
          Map.get_and_update(result, Enum.at(outcome, win_team), fn score ->
            update_score(score, "W")
          end)

        {_, result} =
          Map.get_and_update(result, Enum.at(outcome, rem(win_team + 1, 2)), fn score ->
            update_score(score, "L")
          end)

        result
    end
  end

  defp update_score(score, key) do
    scr =
      cond do
        score == nil ->
          %{key => 1}

        true ->
          {_, s} =
            Map.get_and_update(score, key, fn _ ->
              update_outcome(score, key)
            end)

          s
      end

    {_, scr} =
      Map.get_and_update(scr, "MP", fn _ ->
        update_outcome(scr, "MP")
      end)

    {_, scr} =
      Map.get_and_update(scr, "P", fn _ ->
        update_points(scr, key)
      end)

    {:score, scr}
  end

  defp update_outcome(score, key) do
    outcome = Map.get(score, key, nil)

    cond do
      outcome == nil -> {key, 1}
      true -> {key, outcome + 1}
    end
  end

  defp update_points(score, outcome) do
    points = Map.get(score, "P", nil)

    cond do
      points == nil -> {"P", 1}
      true -> {"P", points + Map.get(@points, outcome) + 1}
    end
  end
end
