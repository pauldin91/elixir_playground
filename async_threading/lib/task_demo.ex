defmodule TaskDemo do
  def calculate() do
    Task.async(fn ->
      Process.sleep(1000)
      for n <- 0..10, do: n * n
    end)
  end
end
