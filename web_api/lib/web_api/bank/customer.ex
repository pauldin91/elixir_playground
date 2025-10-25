defmodule WebApi.Bank.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "customers" do
    field :name, :string
    field :balance, :float
    field :email, :string
    field :phone, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:name, :balance, :email, :phone])
    |> validate_required([:name, :balance, :email, :phone])
  end
end
