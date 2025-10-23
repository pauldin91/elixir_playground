defmodule ArchTest do
  use ExUnit.Case
  doctest Arch

  test "greets the world" do
    assert Arch.hello() == :world
  end
end
