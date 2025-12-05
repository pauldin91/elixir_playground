defmodule FileUploadDemo.People.Person do
  use Ecto.Schema
  import Ecto.Changeset

  schema "people" do
    field :name, :string
    field :bitrhdate, :utc_datetime

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(person, attrs) do
    person
    |> cast(attrs, [:name, :bitrhdate])
    |> validate_required([:name, :bitrhdate])
  end
end
