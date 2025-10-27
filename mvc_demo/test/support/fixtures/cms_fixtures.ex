defmodule MvcDemo.CmsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MvcDemo.Cms` context.
  """

  @doc """
  Generate a page.
  """
  def page_fixture(attrs \\ %{}) do
    {:ok, page} =
      attrs
      |> Enum.into(%{
        body: "some body",
        title: "some title",
        views: 42
      })
      |> MvcDemo.Cms.create_page()

    page
  end
end
