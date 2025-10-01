defmodule StackTest do
  use ExUnit.Case

  test "push to stack" do
    {:ok, pid} = Stack.start_link([])
    Stack.push("oumpa")
    Stack.push("lumpa")
    actual = Stack.peek()
    assert actual == "lumpa"
  end

  test "pop from stack" do
    {:ok, pid} = Stack.start_link([])
    Stack.push("oumpa")
    Stack.push("lumpa")
    actual = Stack.pop()
    assert actual == "lumpa"
  end

  test "pop from empty stack" do
    {:ok, pid} = Stack.start_link([])
    actual = Stack.pop()
    assert actual == :empty
  end

  test "peek empty stack" do
    {:ok, pid} = Stack.start_link([])
    actual = Stack.peek()
    assert actual == :empty
  end
end
