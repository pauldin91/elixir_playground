defmodule MultiTest do
  use ExUnit.Case
  doctest Multi

  test "send ping to pong process" do
    parent = self()
    pong = Multi.pong_process(parent)
    send(pong, {:ping, "makarena"})
    expected = "echo: " <> "makarena"

    receive do
      {:pong, msg} -> assert msg == expected
    end
  end
end
