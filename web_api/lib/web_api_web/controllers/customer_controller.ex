defmodule WebApiWeb.CustomerController do
  use WebApiWeb, :controller

  alias WebApi.Bank
  alias WebApi.Bank.Customer

  action_fallback WebApiWeb.FallbackController

  def index(conn, _params) do
    customers = Bank.list_customers()
    render(conn, :index, customers: customers)
  end

  def create(conn, %{"customer" => customer_params}) do
    with {:ok, %Customer{} = customer} <- Bank.create_customer(customer_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/customers/#{customer}")
      |> render(:show, customer: customer)
    end
  end

  def show(conn, %{"id" => id}) do
    customer = Bank.get_customer!(id)
    render(conn, :show, customer: customer)
  end

  def update(conn, %{"id" => id, "customer" => customer_params}) do
    customer = Bank.get_customer!(id)

    with {:ok, %Customer{} = customer} <- Bank.update_customer(customer, customer_params) do
      render(conn, :show, customer: customer)
    end
  end

  def delete(conn, %{"id" => id}) do
    customer = Bank.get_customer!(id)

    with {:ok, %Customer{}} <- Bank.delete_customer(customer) do
      send_resp(conn, :no_content, "")
    end
  end
end
