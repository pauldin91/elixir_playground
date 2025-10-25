defmodule WebApi.Repo do
  use Ecto.Repo,
    otp_app: :web_api,
    adapter: Ecto.Adapters.Postgres
end
