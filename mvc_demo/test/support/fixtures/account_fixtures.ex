defmodule MvcDemo.AccountFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MvcDemo.Account` context.
  """

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
      |> MvcDemo.Account.create_credential()

    credential
  end
end
