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
       |> String.split("\n")
       |> Enum.with_index()
       |> Enum.filter(fn {t, _} ->
         res =
           cond do
             Enum.member?(flags, "-x") && Enum.member?(flags, "-i") ->
               String.downcase(t) == String.downcase(pattern)

             Enum.member?(flags, "-x") ->
               t == pattern

             Enum.member?(flags, "-i") ->
               String.contains?(String.downcase(t), String.downcase(pattern))

             true ->
               String.contains?(t, pattern)
           end

         cond do
           Enum.member?(flags, "-v") -> !res
           true -> res
         end
       end)}
    end)
    |> Enum.reduce([], fn x, acc ->
      acc ++
        for(
          n <- elem(x, 1),
          do:
            cond do
              Enum.member?(flags, "-l") ->
                elem(x, 0) <> "\n"

              Enum.member?(flags, "-n") && Enum.member?(flags, "-l") ->
                elem(x, 0) <> ":" <> "#{elem(n, 1)}:" <> elem(n, 0) <> "\n"

              Enum.member?(flags, "-n") ->
                elem(n, 1) <> ":" <> elem(n, 0) <> "\n"

              true ->
                elem(n, 0) <> "\n"
            end
        )
    end)
    |> Enum.join()
  end
end
