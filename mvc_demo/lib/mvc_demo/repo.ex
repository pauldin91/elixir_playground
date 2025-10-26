defmodule MvcDemo.Repo do
  use Ecto.Repo,
    otp_app: :mvc_demo,
    adapter: Ecto.Adapters.Postgres
end
