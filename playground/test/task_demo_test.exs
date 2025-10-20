defmodule TaskDemoTest do
  use ExUnit.Case

  test "heavy job is done async" do
    task = TaskDemo.calculate()
    {micro, result} = :timer.tc(fn -> Task.await(task) end)
    assert micro / 1000 >= 1000
    assert result == for(n <- 0..10, do: n * n)
  end
end
