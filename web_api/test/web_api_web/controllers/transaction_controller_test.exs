defmodule WebApiWeb.TransactionControllerTest do
  use WebApiWeb.ConnCase

  import WebApi.LedgerFixtures

  alias WebApi.Ledger.Transaction

  @create_attrs %{
    receiver: "some receiver",
    amount: 120.5,
    sender: "some sender"
  }
  @update_attrs %{
    receiver: "some updated receiver",
    amount: 456.7,
    sender: "some updated sender"
  }
  @invalid_attrs %{receiver: nil, amount: nil, sender: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all transactions", %{conn: conn} do
      conn = get(conn, ~p"/api/transactions")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create transaction" do
    test "renders transaction when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/transactions", transaction: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/transactions/#{id}")

      assert %{
               "id" => ^id,
               "amount" => 120.5,
               "receiver" => "some receiver",
               "sender" => "some sender"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/transactions", transaction: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update transaction" do
    setup [:create_transaction]

    test "renders transaction when data is valid", %{conn: conn, transaction: %Transaction{id: id} = transaction} do
      conn = put(conn, ~p"/api/transactions/#{transaction}", transaction: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/transactions/#{id}")

      assert %{
               "id" => ^id,
               "amount" => 456.7,
               "receiver" => "some updated receiver",
               "sender" => "some updated sender"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, transaction: transaction} do
      conn = put(conn, ~p"/api/transactions/#{transaction}", transaction: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete transaction" do
    setup [:create_transaction]

    test "deletes chosen transaction", %{conn: conn, transaction: transaction} do
      conn = delete(conn, ~p"/api/transactions/#{transaction}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/transactions/#{transaction}")
      end
    end
  end

  defp create_transaction(_) do
    transaction = transaction_fixture()
    %{transaction: transaction}
  end
end
