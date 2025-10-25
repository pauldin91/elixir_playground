defmodule WebApi.Bank.CustomerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `WebApi.Bank.Customer` context.
  """

  @doc """
  Generate a customer.
  """
  def customer_fixture(attrs \\ %{}) do
    {:ok, customer} =
      attrs
      |> Enum.into(%{
        balance: 120.5,
        email: "some email",
        name: "some name",
        phone: "some phone"
      })
      |> WebApi.Bank.Customer.create_customer()

    customer
  end
end
