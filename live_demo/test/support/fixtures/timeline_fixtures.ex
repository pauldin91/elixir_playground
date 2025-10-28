defmodule LiveDemo.TimelineFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveDemo.Timeline` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        body: "some body",
        like_count: 42,
        repost_count: 42,
        username: "some username"
      })
      |> LiveDemo.Timeline.create_post()

    post
  end
end
