defmodule AnimalKingdomTest do
  use ExUnit.Case

  test "protocol implementations" do
    bat = %AnimalKingom.Mammal{name: "bat", method: "flying"}
    chicken = %AnimalKingom.Bird{name: "chicken", method: "walking"}

    assert AnimalKingom.Animal.transport_via(bat) == "flying"
    assert AnimalKingom.Animal.transport_via(chicken) == "walking"
  end
end
