defmodule AnimalKingom do
  defprotocol Animal do
    @spec transport_via(t) :: String.t()
    def transport_via(t)
  end

  defmodule Mammal do
    defstruct [:name, :method]
  end

  defmodule Serpent do
    defstruct [:name, :method]
  end

  defmodule Fish do
    defstruct [:name]
  end

  defmodule Bird do
    defstruct [:name, :method]
  end

  defimpl Animal, for: [Mammal, Serpent, Bird] do
    def transport_via(%{method: method}), do: method
  end

  defimpl Animal, for: Fish do
    def transport_via(_t), do: "swimming"
  end
end
