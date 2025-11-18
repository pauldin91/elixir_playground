defmodule FileUploadDemoWeb.ProductController do
  use FileUploadDemoWeb, :controller

  @products [
    %{id: "1", name: "Product_1"},
    %{id: "2", name: "Product_2"},
    %{id: "3", name: "Product_3"}
  ]

  def index(conn, _params) do
    conn
    |> assign(:products, @products)
    |> render(:index)
  end

  def show(conn, %{"id" => id}) do
    product = Enum.find(@products, fn p -> p.id == id end)

    conn
    |> assign(:product, product)
    |> render(:show, id: id)
  end
end
