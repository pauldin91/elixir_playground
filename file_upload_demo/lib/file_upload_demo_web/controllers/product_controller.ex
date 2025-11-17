defmodule FileUploadDemoWeb.ProductController do
  use FileUploadDemoWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end

  def show(conn, %{"id" => id}) do
    render(conn, :show, id: id)
  end
end
