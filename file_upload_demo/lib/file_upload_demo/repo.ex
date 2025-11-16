defmodule FileUploadDemo.Repo do
  use Ecto.Repo,
    otp_app: :file_upload_demo,
    adapter: Ecto.Adapters.Postgres
end
