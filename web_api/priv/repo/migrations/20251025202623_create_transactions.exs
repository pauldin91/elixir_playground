defmodule WebApi.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :amount, :float
      add :sender, :string
      add :receiver, :string

      timestamps(type: :utc_datetime)
    end
  end
end
