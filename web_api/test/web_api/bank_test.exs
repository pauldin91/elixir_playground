defmodule WebApi.BankTest do
  use WebApi.DataCase

  alias WebApi.Bank

  describe "customers" do
    alias WebApi.Bank.Customer

    import WebApi.BankFixtures

    @invalid_attrs %{name: nil, balance: nil, email: nil, phone: nil}

    test "list_customers/0 returns all customers" do
      customer = customer_fixture()
      assert Bank.list_customers() == [customer]
    end

    test "get_customer!/1 returns the customer with given id" do
      customer = customer_fixture()
      assert Bank.get_customer!(customer.id) == customer
    end

    test "create_customer/1 with valid data creates a customer" do
      valid_attrs = %{name: "some name", balance: 120.5, email: "some email", phone: "some phone"}

      assert {:ok, %Customer{} = customer} = Bank.create_customer(valid_attrs)
      assert customer.name == "some name"
      assert customer.balance == 120.5
      assert customer.email == "some email"
      assert customer.phone == "some phone"
    end

    test "create_customer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bank.create_customer(@invalid_attrs)
    end

    test "update_customer/2 with valid data updates the customer" do
      customer = customer_fixture()
      update_attrs = %{name: "some updated name", balance: 456.7, email: "some updated email", phone: "some updated phone"}

      assert {:ok, %Customer{} = customer} = Bank.update_customer(customer, update_attrs)
      assert customer.name == "some updated name"
      assert customer.balance == 456.7
      assert customer.email == "some updated email"
      assert customer.phone == "some updated phone"
    end

    test "update_customer/2 with invalid data returns error changeset" do
      customer = customer_fixture()
      assert {:error, %Ecto.Changeset{}} = Bank.update_customer(customer, @invalid_attrs)
      assert customer == Bank.get_customer!(customer.id)
    end

    test "delete_customer/1 deletes the customer" do
      customer = customer_fixture()
      assert {:ok, %Customer{}} = Bank.delete_customer(customer)
      assert_raise Ecto.NoResultsError, fn -> Bank.get_customer!(customer.id) end
    end

    test "change_customer/1 returns a customer changeset" do
      customer = customer_fixture()
      assert %Ecto.Changeset{} = Bank.change_customer(customer)
    end
  end

  describe "transactions" do
    alias WebApi.Bank.Transaction

    import WebApi.BankFixtures

    @invalid_attrs %{receiver: nil, amount: nil, sender: nil}

    test "list_transactions/0 returns all transactions" do
      transaction = transaction_fixture()
      assert Bank.list_transactions() == [transaction]
    end

    test "get_transaction!/1 returns the transaction with given id" do
      transaction = transaction_fixture()
      assert Bank.get_transaction!(transaction.id) == transaction
    end

    test "create_transaction/1 with valid data creates a transaction" do
      valid_attrs = %{receiver: "some receiver", amount: 120.5, sender: "some sender"}

      assert {:ok, %Transaction{} = transaction} = Bank.create_transaction(valid_attrs)
      assert transaction.receiver == "some receiver"
      assert transaction.amount == 120.5
      assert transaction.sender == "some sender"
    end

    test "create_transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bank.create_transaction(@invalid_attrs)
    end

    test "update_transaction/2 with valid data updates the transaction" do
      transaction = transaction_fixture()
      update_attrs = %{receiver: "some updated receiver", amount: 456.7, sender: "some updated sender"}

      assert {:ok, %Transaction{} = transaction} = Bank.update_transaction(transaction, update_attrs)
      assert transaction.receiver == "some updated receiver"
      assert transaction.amount == 456.7
      assert transaction.sender == "some updated sender"
    end

    test "update_transaction/2 with invalid data returns error changeset" do
      transaction = transaction_fixture()
      assert {:error, %Ecto.Changeset{}} = Bank.update_transaction(transaction, @invalid_attrs)
      assert transaction == Bank.get_transaction!(transaction.id)
    end

    test "delete_transaction/1 deletes the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{}} = Bank.delete_transaction(transaction)
      assert_raise Ecto.NoResultsError, fn -> Bank.get_transaction!(transaction.id) end
    end

    test "change_transaction/1 returns a transaction changeset" do
      transaction = transaction_fixture()
      assert %Ecto.Changeset{} = Bank.change_transaction(transaction)
    end
  end
end
