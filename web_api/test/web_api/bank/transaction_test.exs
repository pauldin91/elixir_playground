defmodule WebApi.Bank.TransactionTest do
  use WebApi.DataCase

  alias WebApi.Bank.Transaction

  describe "transactions" do
    alias WebApi.Bank.Transaction.Transaction

    import WebApi.Bank.TransactionFixtures

    @invalid_attrs %{receiver: nil, amount: nil, sender: nil}

    test "list_transactions/0 returns all transactions" do
      transaction = transaction_fixture()
      assert Transaction.list_transactions() == [transaction]
    end

    test "get_transaction!/1 returns the transaction with given id" do
      transaction = transaction_fixture()
      assert Transaction.get_transaction!(transaction.id) == transaction
    end

    test "create_transaction/1 with valid data creates a transaction" do
      valid_attrs = %{receiver: "some receiver", amount: 120.5, sender: "some sender"}

      assert {:ok, %Transaction{} = transaction} = Transaction.create_transaction(valid_attrs)
      assert transaction.receiver == "some receiver"
      assert transaction.amount == 120.5
      assert transaction.sender == "some sender"
    end

    test "create_transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transaction.create_transaction(@invalid_attrs)
    end

    test "update_transaction/2 with valid data updates the transaction" do
      transaction = transaction_fixture()
      update_attrs = %{receiver: "some updated receiver", amount: 456.7, sender: "some updated sender"}

      assert {:ok, %Transaction{} = transaction} = Transaction.update_transaction(transaction, update_attrs)
      assert transaction.receiver == "some updated receiver"
      assert transaction.amount == 456.7
      assert transaction.sender == "some updated sender"
    end

    test "update_transaction/2 with invalid data returns error changeset" do
      transaction = transaction_fixture()
      assert {:error, %Ecto.Changeset{}} = Transaction.update_transaction(transaction, @invalid_attrs)
      assert transaction == Transaction.get_transaction!(transaction.id)
    end

    test "delete_transaction/1 deletes the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{}} = Transaction.delete_transaction(transaction)
      assert_raise Ecto.NoResultsError, fn -> Transaction.get_transaction!(transaction.id) end
    end

    test "change_transaction/1 returns a transaction changeset" do
      transaction = transaction_fixture()
      assert %Ecto.Changeset{} = Transaction.change_transaction(transaction)
    end
  end
end
