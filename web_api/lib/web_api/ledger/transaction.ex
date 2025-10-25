defmodule WebApi.Ledger.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transactions" do
    field :receiver, :string
    field :amount, :float
    field :sender, :string
    field :timestamp, :utc_datetime
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:amount, :sender, :receiver])
    |> validate_required([:amount, :sender, :receiver])
  end
end
