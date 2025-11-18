defmodule FileUploadDemoWeb.ProductHTML do
  use FileUploadDemoWeb, :html

  embed_templates "product_html/*"

  def product(assigns) do
    ~H"""
    <h1>Product: {assigns.name}</h1>
    """
  end
end
