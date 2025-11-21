defmodule FileUploadDemoWeb.ProductController do
  use FileUploadDemoWeb, :controller

  alias FileUploadDemo.{Repo, Product}

  def index(conn, _params) do
    products = Repo.all(Product)

    conn
    |> assign(:products, products)
    |> render(:index)
  end

  def show(conn, %{"slug" => slug}) do
    product = Repo.get_by(Product, slug: slug)

    conn
    |> assign(:product, product)
    |> render(:show)
  end
end
