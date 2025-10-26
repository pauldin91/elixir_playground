defmodule MvcDemoWeb.TempController do
  use MvcDemoWeb, :controller

  def index(conn, _params) do
    conn
    |> put_flash(:info, "welcome back!")
    |> render("index.html")
  end

  def show(conn, %{"name" => name}) do
    render(conn, "show.html", name: name)
  end
end
