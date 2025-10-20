defmodule CacheTest do
  use ExUnit.Case

  test "retrieve empty map" do
    {:ok, cache} = Cache.init()
    send(cache, {:retrieve, self()})

    map =
      receive do
        {:ok, m} -> m
      end

    assert map == %{}
  end

  test "put items to cache" do
    {:ok, cache} = Cache.init()
    send(cache, {:put, :foo, "bar"})
    send(cache, {:put, "oumpa", "lumpa"})
    send(cache, {:put, 123, 456.0})
    send(cache, {:retrieve, self()})

    map =
      receive do
        {:ok, m} -> m
      end

    assert map == %{:foo => "bar", "oumpa" => "lumpa", 123 => 456.0}
  end

  test "get items from cache" do
    {:ok, cache} = Cache.init()
    send(cache, {:put, "oumpa", "lumpa"})
    send(cache, {:get, "oumpa", self()})
    send(cache, {:get, :oops, self()})

    got =
      receive do
        m -> m
      end

    oops =
      receive do
        m -> m
      end

    assert got == "lumpa"
    assert oops == nil
  end
end
