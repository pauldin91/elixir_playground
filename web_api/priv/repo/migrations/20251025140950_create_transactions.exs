defmodule WebApi.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :receiver, :string
      add :sender, :string
      add :comment, :string
      add :amount, :float

      timestamps(type: :utc_datetime)
    end
  end
end
