defmodule WebApiWeb.CustomerControllerTest do
  use WebApiWeb.ConnCase

  import WebApi.BankFixtures

  alias WebApi.Bank.Customer

  @create_attrs %{
    name: "some name",
    balance: 120.5,
    email: "some email",
    phone: "some phone"
  }
  @update_attrs %{
    name: "some updated name",
    balance: 456.7,
    email: "some updated email",
    phone: "some updated phone"
  }
  @invalid_attrs %{name: nil, balance: nil, email: nil, phone: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all customers", %{conn: conn} do
      conn = get(conn, ~p"/api/customers")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create customer" do
    test "renders customer when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/customers", customer: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/customers/#{id}")

      assert %{
               "id" => ^id,
               "balance" => 120.5,
               "email" => "some email",
               "name" => "some name",
               "phone" => "some phone"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/customers", customer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update customer" do
    setup [:create_customer]

    test "renders customer when data is valid", %{conn: conn, customer: %Customer{id: id} = customer} do
      conn = put(conn, ~p"/api/customers/#{customer}", customer: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/customers/#{id}")

      assert %{
               "id" => ^id,
               "balance" => 456.7,
               "email" => "some updated email",
               "name" => "some updated name",
               "phone" => "some updated phone"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, customer: customer} do
      conn = put(conn, ~p"/api/customers/#{customer}", customer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete customer" do
    setup [:create_customer]

    test "deletes chosen customer", %{conn: conn, customer: customer} do
      conn = delete(conn, ~p"/api/customers/#{customer}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/customers/#{customer}")
      end
    end
  end

  defp create_customer(_) do
    customer = customer_fixture()
    %{customer: customer}
  end
end
