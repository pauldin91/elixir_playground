defmodule FileUploadDemoWeb.ProductHTML do
  use FileUploadDemoWeb, :html
  alias FileUploadDemo.Product

  embed_templates "product_html/*"
  attr :product, Product, required: true

  def product(assigns) do
    ~H"""
    <h1>Product: {@product.name}</h1>
    """
  end
end
