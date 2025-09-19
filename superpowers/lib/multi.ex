defmodule Multi do
  def pong_process(pid) do
    spawn(fn ->
      receive do
        {:ping, msg} -> send(pid, {:pong, "echo: " <> msg})
      end
    end)
  end
end
