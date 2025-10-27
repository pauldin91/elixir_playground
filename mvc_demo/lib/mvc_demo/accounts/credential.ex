defmodule MvcDemo.Accounts.Credential do
  use Ecto.Schema
  import Ecto.Changeset
  alias MvcDemo.Accounts.User

  schema "credentials" do
    field :email, :string
    belongs_to :user, User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(credential, attrs) do
    credential
    |> cast(attrs, [:email])
    |> validate_required([:email])
    |> unique_constraint(:email)
  end
end
