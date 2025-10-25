defmodule WebApi.Bank.TransactionFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `WebApi.Bank.Transaction` context.
  """

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
      |> WebApi.Bank.Transaction.create_transaction()

    transaction
  end
end
