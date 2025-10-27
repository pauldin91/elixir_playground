defmodule MvcDemo.Repo.Migrations.CreatePages do
  use Ecto.Migration

  def change do
    create table(:pages) do
      add :title, :string
      add :body, :text
      add :views, :integer, default: 0

      timestamps(type: :utc_datetime)
    end
  end
end
