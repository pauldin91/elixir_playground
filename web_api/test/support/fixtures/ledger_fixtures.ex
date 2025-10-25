defmodule WebApi.LedgerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `WebApi.Ledger` context.
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
      |> WebApi.Ledger.create_transaction()

    transaction
  end
end
