defmodule FileUploadDemoWeb.ProductController do
  use FileUploadDemoWeb, :controller

  alias FileUploadDemo.{Repo, Product}

  def index(conn, _params) do
    products = Repo.all(Product)

    conn
    |> assign(:products, products)
    |> render(:index)
  end

  def show(conn, %{"id" => id}) do
    product = Repo.get(Product, id)

    conn
    |> assign(:product, product)
    |> render(:show, id: id)
  end
end
