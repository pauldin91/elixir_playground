defmodule MvcDemo.Cms.Page do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pages" do
    field :title, :string
    field :body, :string
    field :views, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(page, attrs) do
    page
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
  end
end
