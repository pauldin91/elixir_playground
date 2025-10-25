defmodule WebApiWeb.TransactionController do
  use WebApiWeb, :controller

  alias WebApi.Ledger
  alias WebApi.Ledger.Transaction

  action_fallback WebApiWeb.FallbackController

  def index(conn, _params) do
    transactions = Ledger.list_transactions()
    render(conn, :index, transactions: transactions)
  end

  def create(conn, %{"transaction" => transaction_params}) do
    with {:ok, %Transaction{} = transaction} <- Ledger.create_transaction(transaction_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/transactions/#{transaction}")
      |> render(:show, transaction: transaction)
    end
  end

  def show(conn, %{"id" => id}) do
    transaction = Ledger.get_transaction!(id)
    render(conn, :show, transaction: transaction)
  end

  def update(conn, %{"id" => id, "transaction" => transaction_params}) do
    transaction = Ledger.get_transaction!(id)

    with {:ok, %Transaction{} = transaction} <- Ledger.update_transaction(transaction, transaction_params) do
      render(conn, :show, transaction: transaction)
    end
  end

  def delete(conn, %{"id" => id}) do
    transaction = Ledger.get_transaction!(id)

    with {:ok, %Transaction{}} <- Ledger.delete_transaction(transaction) do
      send_resp(conn, :no_content, "")
    end
  end
end
