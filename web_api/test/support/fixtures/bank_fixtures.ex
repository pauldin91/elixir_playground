defmodule WebApi.BankFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `WebApi.Bank` context.
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
      |> WebApi.Bank.create_customer()

    customer
  end

  @doc """
  Generate a transaction.
  """
  def transaction_fixture(attrs \\ %{}) do
    {:ok, transaction} =
      attrs
      |> Enum.into(%{
        amount: 120.5,
        receiver: "some receiver",
        sender: "some sender"
      })
      |> WebApi.Bank.create_transaction()

    transaction
  end
end
