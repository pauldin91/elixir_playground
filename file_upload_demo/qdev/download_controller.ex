defmodule DemoWeb.DownloadController do
  use DemoWeb, :controller
  alias Demo.Uploads

  def download(conn, %{"transaction_id" => transaction_id}) do
    case Uploads.download_transaction(transaction_id) do
      {:ok, zip_path} ->
        zip_filename = transaction_id <> ".zip"
        conn
        |> put_resp_header("content-disposition", "attachment; filename=\"#{zip_filename}\"")
        |> send_file(200, List.to_string(zip_path))

      {:error, :not_found} ->
        conn
        |> put_status(:not_found)
        |> text("File not found")
    end
  end
end