defmodule FileUploadDemo.PeopleFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FileUploadDemo.People` context.
  """

  @doc """
  Generate a person.
  """
  def person_fixture(attrs \\ %{}) do
    {:ok, person} =
      attrs
      |> Enum.into(%{
        bitrhdate: ~U[2025-12-04 14:52:00Z],
        name: "some name"
      })
      |> FileUploadDemo.People.create_person()

    person
  end
end
