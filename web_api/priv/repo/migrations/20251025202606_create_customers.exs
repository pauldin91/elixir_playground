defmodule WebApi.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :name, :string
      add :balance, :float
      add :email, :string
      add :phone, :string

      timestamps(type: :utc_datetime)
    end
  end
end
