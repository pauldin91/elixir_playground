defmodule MvcDemo.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MvcDemo.Accounts` context.
  """

  @doc """
  Generate a unique user username.
  """
  def unique_user_username, do: "some username#{System.unique_integer([:positive])}"

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        name: "some name",
        username: unique_user_username()
      })
      |> MvcDemo.Accounts.create_user()

    user
  end

  @doc """
  Generate a unique credential email.
  """
  def unique_credential_email, do: "some email#{System.unique_integer([:positive])}"

  @doc """
  Generate a credential.
  """
  def credential_fixture(attrs \\ %{}) do
    {:ok, credential} =
      attrs
      |> Enum.into(%{
        email: unique_credential_email()
      })
      |> MvcDemo.Accounts.create_credential()

    credential
  end
end
