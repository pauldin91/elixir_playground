defmodule WebApi.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `WebApi.Accounts` context.
  """

  @doc """
  Generate a transaction.
  """
  def transaction_fixture(attrs \\ %{}) do
    {:ok, transaction} =
      attrs
      |> Enum.into(%{
        amount: 120.5,
        comment: "some comment",
        receiver: "some receiver",
        sender: "some sender"
      })
      |> WebApi.Accounts.create_transaction()

    transaction
  end
end
