defmodule WebApi.Models.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transactions" do
    field :comment, :string
    field :receiver, :string
    field :sender, :string
    field :amount, :float

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:receiver, :sender, :comment, :amount])
    |> validate_required([:receiver, :sender, :comment, :amount])
  end
end
