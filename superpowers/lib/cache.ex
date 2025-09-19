defmodule Cache do
  def init() do
    Task.start_link(fn -> add(%{}) end)
  end

  def add(map) do
    receive do
      {:get, key, caller} ->
        send(caller, Map.get(map, key, nil))
        add(map)

      {:put, key, value} ->
        add(Map.put(map, key, value))

      {:del, key} ->
        add(Map.delete(map, key))

      {:retrieve, caller} ->
        send(caller, {:ok, map})
        add(map)
    end
  end
end
