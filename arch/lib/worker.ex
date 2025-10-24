defmodule Worker do
  def start_link do
    pid = spawn_link(fn -> loop() end)
    Process.register(pid, :worker)
  end

  defp loop do
    receive do
      :tick ->
        IO.puts("#{DateTime.utc_now()} Tick received!")
        loop()
    end
  end
end
