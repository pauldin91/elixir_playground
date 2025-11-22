defmodule FileUploadDemo.PromotionsFixtures do
  @doc """
  Generate a unique promotion code.
  """
  def unique_promotion_code, do: "some code#{System.unique_integer([:positive])}"

  @doc """
  Generate a promotion.
  """
  def promotion_fixture(attrs \\ %{}) do
    {:ok, promotion} =
      attrs
      |> Enum.into(%{
        code: unique_promotion_code(),
        expires_at: ~U[2025-11-21 07:13:00Z],
        name: "some name"
      })
      |> FileUploadDemo.Promotions.create_promotion()

    promotion
  end
end
