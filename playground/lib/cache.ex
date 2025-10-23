defmodule Cache do
  def init() do
    Task.start_link(fn -> loop(%{}) end)
  end

  def loop(map) do
    receive do
      {:get, key, caller} ->
        send(caller, Map.get(map, key, nil))
        loop(map)

      {:put, key, value} ->
        loop(Map.put(map, key, value))

      {:del, key} ->
        loop(Map.delete(map, key))

      {:retrieve, caller} ->
        send(caller, {:ok, map})
        loop(map)
    end
  end
end
