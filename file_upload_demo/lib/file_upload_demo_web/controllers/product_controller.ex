defmodule FileUploadDemoWeb.ProductController do
  use FileUploadDemoWeb, :controller

  alias FileUploadDemo.Products

  def index(conn, _params) do
    products = Products.list_products()

    conn
    |> assign(:products, products)
    |> render(:index)
  end

  def show(conn, %{"slug" => slug}) do
    product = Products.get_by_slug(slug)

    conn
    |> assign(:product, product)
    |> render(:show)
  end
end
