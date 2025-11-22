defmodule FileUploadDemo.Products do
  alias FileUploadDemo.Repo
  alias FileUploadDemo.Products.Product

  def list_products(), do: Repo.all(Product)
  def get_by_slug(slug) when is_binary(slug), do: Repo.get_by(Product, slug: slug)
  def get_by_id(id), do: Repo.get(Product, id)
  def delete_by_id(id), do: Repo.delete(Product, id: id)
end
