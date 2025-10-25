defmodule WebApiWeb.TransactionJSON do
  alias WebApi.Models.Transaction

  @doc """
  Renders a list of transactions.
  """
  def index(%{transactions: transactions}) do
    %{data: for(transaction <- transactions, do: data(transaction))}
  end

  @doc """
  Renders a single transaction.
  """
  def show(%{transaction: transaction}) do
    %{data: data(transaction)}
  end

  defp data(%Transaction{} = transaction) do
    %{
      id: transaction.id,
      receiver: transaction.receiver,
      sender: transaction.sender,
      comment: transaction.comment,
      amount: transaction.amount
    }
  end
end
