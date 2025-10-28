defmodule MvcDemoWeb.SessionController do
  use MvcDemoWeb, :controller
  alias MvcDemo.Accounts

  def new(conn, _) do
    render(conn, :new)
  end

  def create(conn, %{"user" => email, "password" => password}) do
    IO.puts(email)
    IO.puts(password)

    case(Accounts.authenticate(email, password)) do
      {:error, :unauthorized} ->
        conn
        |> put_flash(:error, "Invalid credentials")
        |> redirect(to: ~p"/sessions/new")

      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> put_session(:user_id, user.id)
        |> configure_session(renew: true)
        |> redirect(to: "/")
    end
  end

  def delete(conn, _) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end
end
