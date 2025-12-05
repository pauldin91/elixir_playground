defmodule Demo.Uploads do
  @moduledoc """
  Context for handling file uploads and metadata extraction.
  """

  @upload_dir "priv/uploads"

  def create_transaction do
    UUID.uuid4()
  end

  def save_files(transaction_id, uploaded_entries) do
    transaction_dir = Path.join([@upload_dir, transaction_id])

    metadata = %{
      transaction_id: transaction_id,
      timestamp: DateTime.utc_now(),
      files: [],
      file_count: length(uploaded_entries)
    }

    files_metadata =
      Enum.map(uploaded_entries, fn entry ->
        %{
          filename: entry.client_name,
          size: File.stat!(entry.path).size,
          content_type: entry.client_type
        }
      end)

    final_metadata = %{metadata | files: files_metadata}

    # Save metadata as JSON
    metadata_path = Path.join([transaction_dir, "metadata.json"])
    File.write!(metadata_path, Jason.encode!(final_metadata, pretty: true))

    final_metadata
  end

  def list_all_transactions do
    case File.ls(@upload_dir) do
      {:ok, dirs} ->
        Enum.map(dirs, fn transaction_id ->
          get_transaction_metadata(transaction_id)
        end)
        |> Enum.filter(& &1)

      {:error, _} ->
        []
    end
  end

  def get_transaction_metadata(transaction_id) do
    metadata_path = Path.join([@upload_dir, transaction_id, "metadata.json"])

    case File.read(metadata_path) do
      {:ok, content} -> Jason.decode!(content, keys: :atoms)
      {:error, _} -> nil
    end
  end

  def delete_transaction(transaction_id) do
    transaction_dir = Path.join([@upload_dir, transaction_id])
    File.rm_rf(transaction_dir)
  end

  def download_file(transaction_id, filename) do
    file_path = Path.join([@upload_dir, transaction_id, filename])

    if File.exists?(file_path) do
      {:ok, file_path}
    else
      {:error, :not_found}
    end
  end

  def download_transaction(transaction_id) do
    transaction_dir = Path.join([@upload_dir, transaction_id])

    if File.dir?(transaction_dir) do
      files = File.ls!(transaction_dir) |> Enum.map(&String.to_charlist/1)
      zip_filename = String.to_charlist(transaction_id <> ".zip")

      case :zip.create(zip_filename, files, cwd: String.to_charlist(transaction_dir)) do
        {:ok, zip_path} -> {:ok, zip_path}
        {:error, reason} -> {:error, reason}
      end
    else
      {:error, :not_found}
    end
  end
end