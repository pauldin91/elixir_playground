defmodule FileUploadDemo.Repo.Migrations.CreatePeople do
  use Ecto.Migration

  def change do
    create table(:people) do
      add :name, :string
      add :bitrhdate, :utc_datetime

      timestamps(type: :utc_datetime)
    end
  end
end
