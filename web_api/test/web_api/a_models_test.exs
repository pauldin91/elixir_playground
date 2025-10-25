defmodule WebApi.AModelsTest do
  use WebApi.DataCase

  alias WebApi.AModels

  describe "customers" do
    alias WebApi.AModels.Customer

    import WebApi.AModelsFixtures

    @invalid_attrs %{name: nil, balance: nil, email: nil, phone: nil}

    test "list_customers/0 returns all customers" do
      customer = customer_fixture()
      assert AModels.list_customers() == [customer]
    end

    test "get_customer!/1 returns the customer with given id" do
      customer = customer_fixture()
      assert AModels.get_customer!(customer.id) == customer
    end

    test "create_customer/1 with valid data creates a customer" do
      valid_attrs = %{name: "some name", balance: 120.5, email: "some email", phone: "some phone"}

      assert {:ok, %Customer{} = customer} = AModels.create_customer(valid_attrs)
      assert customer.name == "some name"
      assert customer.balance == 120.5
      assert customer.email == "some email"
      assert customer.phone == "some phone"
    end

    test "create_customer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AModels.create_customer(@invalid_attrs)
    end

    test "update_customer/2 with valid data updates the customer" do
      customer = customer_fixture()
      update_attrs = %{name: "some updated name", balance: 456.7, email: "some updated email", phone: "some updated phone"}

      assert {:ok, %Customer{} = customer} = AModels.update_customer(customer, update_attrs)
      assert customer.name == "some updated name"
      assert customer.balance == 456.7
      assert customer.email == "some updated email"
      assert customer.phone == "some updated phone"
    end

    test "update_customer/2 with invalid data returns error changeset" do
      customer = customer_fixture()
      assert {:error, %Ecto.Changeset{}} = AModels.update_customer(customer, @invalid_attrs)
      assert customer == AModels.get_customer!(customer.id)
    end

    test "delete_customer/1 deletes the customer" do
      customer = customer_fixture()
      assert {:ok, %Customer{}} = AModels.delete_customer(customer)
      assert_raise Ecto.NoResultsError, fn -> AModels.get_customer!(customer.id) end
    end

    test "change_customer/1 returns a customer changeset" do
      customer = customer_fixture()
      assert %Ecto.Changeset{} = AModels.change_customer(customer)
    end
  end
end
