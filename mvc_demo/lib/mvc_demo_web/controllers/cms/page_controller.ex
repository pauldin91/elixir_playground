defmodule MvcDemoWeb.Cms.PageController do
  use MvcDemoWeb, :controller

  alias MvcDemo.Cms
  alias MvcDemo.Cms.Page

  def index(conn, _params) do
    pages = Cms.list_pages()
    render(conn, :index, pages: pages)
  end

  def new(conn, _params) do
    changeset = Cms.change_page(%Page{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"page" => page_params}) do
    case Cms.create_page(page_params) do
      {:ok, page} ->
        conn
        |> put_flash(:info, "Page created successfully.")
        |> redirect(to: ~p"/cms/pages/#{page}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    page = Cms.get_page!(id)
    render(conn, :show, page: page)
  end

  def edit(conn, %{"id" => id}) do
    page = Cms.get_page!(id)
    changeset = Cms.change_page(page)
    render(conn, :edit, page: page, changeset: changeset)
  end

  def update(conn, %{"id" => id, "page" => page_params}) do
    page = Cms.get_page!(id)

    case Cms.update_page(page, page_params) do
      {:ok, page} ->
        conn
        |> put_flash(:info, "Page updated successfully.")
        |> redirect(to: ~p"/cms/pages/#{page}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, page: page, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    page = Cms.get_page!(id)
    {:ok, _page} = Cms.delete_page(page)

    conn
    |> put_flash(:info, "Page deleted successfully.")
    |> redirect(to: ~p"/cms/pages")
  end
end
