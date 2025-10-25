defmodule WebApi.ModelsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `WebApi.Models` context.
  """

  @doc """
  Generate a customer.
  """
  def customer_fixture(attrs \\ %{}) do
    {:ok, customer} =
      attrs
      |> Enum.into(%{
        balance: 120.5,
        email: "some email",
        name: "some name",
        phone: "some phone"
      })
      |> WebApi.Models.create_customer()

    customer
  end
end
