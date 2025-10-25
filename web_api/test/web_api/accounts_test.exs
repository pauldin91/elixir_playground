defmodule WebApi.AccountsTest do
  use WebApi.DataCase

  alias WebApi.Accounts

  describe "transactions" do
    alias WebApi.Accounts.Transaction

    import WebApi.AccountsFixtures

    @invalid_attrs %{comment: nil, receiver: nil, sender: nil, amount: nil}

    test "list_transactions/0 returns all transactions" do
      transaction = transaction_fixture()
      assert Accounts.list_transactions() == [transaction]
    end

    test "get_transaction!/1 returns the transaction with given id" do
      transaction = transaction_fixture()
      assert Accounts.get_transaction!(transaction.id) == transaction
    end

    test "create_transaction/1 with valid data creates a transaction" do
      valid_attrs = %{comment: "some comment", receiver: "some receiver", sender: "some sender", amount: 120.5}

      assert {:ok, %Transaction{} = transaction} = Accounts.create_transaction(valid_attrs)
      assert transaction.comment == "some comment"
      assert transaction.receiver == "some receiver"
      assert transaction.sender == "some sender"
      assert transaction.amount == 120.5
    end

    test "create_transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_transaction(@invalid_attrs)
    end

    test "update_transaction/2 with valid data updates the transaction" do
      transaction = transaction_fixture()
      update_attrs = %{comment: "some updated comment", receiver: "some updated receiver", sender: "some updated sender", amount: 456.7}

      assert {:ok, %Transaction{} = transaction} = Accounts.update_transaction(transaction, update_attrs)
      assert transaction.comment == "some updated comment"
      assert transaction.receiver == "some updated receiver"
      assert transaction.sender == "some updated sender"
      assert transaction.amount == 456.7
    end

    test "update_transaction/2 with invalid data returns error changeset" do
      transaction = transaction_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_transaction(transaction, @invalid_attrs)
      assert transaction == Accounts.get_transaction!(transaction.id)
    end

    test "delete_transaction/1 deletes the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{}} = Accounts.delete_transaction(transaction)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_transaction!(transaction.id) end
    end

    test "change_transaction/1 returns a transaction changeset" do
      transaction = transaction_fixture()
      assert %Ecto.Changeset{} = Accounts.change_transaction(transaction)
    end
  end
end
