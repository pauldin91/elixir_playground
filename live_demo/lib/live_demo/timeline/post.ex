defmodule LiveDemo.Timeline.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :body, :string
    field :username, :string
    field :like_count, :integer
    field :repost_count, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:username, :body, :like_count, :repost_count])
    |> validate_required([:username, :body, :like_count, :repost_count])
  end
end
