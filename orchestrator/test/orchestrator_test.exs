defmodule OrchestratorTest do
  use ExUnit.Case
  doctest Orchestrator

  test "greets the world" do
    name = "a unique name that won't be shared"
    assert is_nil(Orchestrator.lookup_queue(name))

    assert {:ok, bucket} = Orchestrator.create_queue(name)
    assert Orchestrator.lookup_queue(name) == bucket

    assert Orchestrator.create_queue(name) == {:error, {:already_started, bucket}}
  end
end
