defmodule Grep do
  @spec grep(String.t(), [String.t()], [String.t()]) :: String.t()
  def grep(pattern, flags, files) do
    Enum.map(files, fn f ->
      {:ok, content} = File.read(f)
      {f, content}
    end)
    |> Enum.map(fn {n, s} ->
      {n,
       s
       |> String.split("\n", trim: false)
       |> Enum.filter(fn t -> String.contains?(t, pattern) end)}
    end)
    |> Enum.reduce([], fn x, acc ->
      acc ++ for(n <- elem(x, 1), do: elem(x, 0) <> ":" <> n)
    end)
    |> Enum.join("\n")
  end
end
