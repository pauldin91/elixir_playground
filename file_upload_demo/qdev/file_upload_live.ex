defmodule DemoWeb.FileUploadLive do
  use DemoWeb, :live_view
  alias Demo.Uploads

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:uploaded_files, [])
      |> assign(:transaction_id, nil)
      |> assign(:metadata, nil)
      |> assign(:processing, false)
      |> allow_upload(:files, 
          accept: :any, 
          max_entries: 10, 
          max_file_size: 50_000_000
        )

    {:ok, socket}
  end

  @impl true
  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_event("cancel-upload", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :files, ref)}
  end

  @impl true
  def handle_event("save", _params, socket) do
    transaction_id = Uploads.create_transaction()
    
    uploaded_files =
      consume_uploaded_entries(socket, :files, fn %{path: path}, entry ->
        dest = Path.join(["priv/uploads", transaction_id, entry.client_name])
        File.mkdir_p!(Path.dirname(dest))
        File.cp!(path, dest)
        %{path: dest, client_name: entry.client_name, client_type: entry.client_type}
      end)

    if uploaded_files != [] do
      metadata = Uploads.save_files(transaction_id, uploaded_files)

      # Start async processing
      pid = self()
      spawn(fn ->
        Process.sleep(5000)
        send(pid, {:processing_complete, transaction_id})
      end)

      socket =
        socket
        |> assign(:transaction_id, transaction_id)
        |> assign(:metadata, metadata)
        |> assign(:uploaded_files, uploaded_files)
        |> assign(:processing, true)

      {:noreply, socket}
    else
      {:noreply, socket}
    end
  end

  @impl true
  def handle_info({:processing_complete, transaction_id}, socket) do
    socket =
      socket
      |> assign(:processing, false)
      |> put_flash(:info, "Processing complete! Transaction ID: #{transaction_id}")

    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="max-w-4xl mx-auto p-6">
      <h1 class="text-3xl font-bold mb-6 text-base-content">File Upload</h1>
      
      <form id="upload-form" phx-submit="save" phx-change="validate">
        <div class="border-2 border-dashed border-base-300 rounded-lg p-6 mb-4">
          <div class="text-center">
            <svg class="mx-auto h-12 w-12 text-base-content/40" stroke="currentColor" fill="none" viewBox="0 0 48 48">
              <path d="M28 8H12a4 4 0 00-4 4v20m32-12v8m0 0v8a4 4 0 01-4 4H12a4 4 0 01-4-4v-4m32-4l-3.172-3.172a4 4 0 00-5.656 0L28 28M8 32l9.172-9.172a4 4 0 015.656 0L28 28m0 0l4 4m4-24h8m-4-4v8m-12 4h.02" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
            </svg>
            <div class="mt-4">
              <.live_file_input upload={@uploads.files} class="sr-only" />
              <label for={@uploads.files.ref} class="cursor-pointer">
                <span class="mt-2 block text-sm font-medium text-base-content">
                  Drop files here or click to browse
                </span>
              </label>
            </div>
          </div>
        </div>

        <%= for entry <- @uploads.files.entries do %>
          <div class="flex items-center justify-between p-3 bg-base-200 rounded mb-2">
            <div class="flex items-center">
              <div class="text-sm font-medium text-base-content"><%= entry.client_name %></div>
              <div class="text-sm text-base-content/70 ml-2">(<%= format_bytes(entry.client_size) %>)</div>
            </div>
            <button type="button" phx-click="cancel-upload" phx-value-ref={entry.ref} class="text-error hover:text-error/80">
              ✕
            </button>
          </div>
          
          <div class="w-full bg-base-300 rounded-full h-2 mb-2">
            <div class="bg-primary h-2 rounded-full" style={"width: #{entry.progress}%"}></div>
          </div>
        <% end %>

        <%= for err <- upload_errors(@uploads.files) do %>
          <div class="text-error text-sm mb-2">
            <%= error_to_string(err) %>
          </div>
        <% end %>

        <button type="submit" 
                disabled={@uploads.files.entries == [] or @processing} 
                class="btn btn-primary w-full">
          <%= if @processing, do: "Processing...", else: "Upload Files" %>
        </button>
      </form>

      <%= if @processing do %>
        <div class="mt-8 p-6 bg-warning/10 border border-warning/20 rounded-lg">
          <div class="flex items-center">
            <svg class="animate-spin h-5 w-5 text-warning mr-3" fill="none" viewBox="0 0 24 24">
              <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
              <path class="opacity-75" fill="currentColor" d="m4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
            </svg>
            <span class="text-warning font-medium">Processing files...</span>
          </div>
        </div>
      <% end %>

      <%= if @metadata && !@processing do %>
        <div class="mt-8 p-6 bg-success/10 border border-success/20 rounded-lg">
          <h2 class="text-xl font-semibold text-success mb-4">Upload Successful!</h2>
          
          <div class="space-y-2 text-sm text-base-content">
            <div><strong>Transaction ID:</strong> <code class="bg-base-300 px-2 py-1 rounded text-base-content"><%= @transaction_id %></code></div>
            <div><strong>Timestamp:</strong> <%= Calendar.strftime(@metadata.timestamp, "%Y-%m-%d %H:%M:%S UTC") %></div>
            <div><strong>Files Uploaded:</strong> <%= @metadata.file_count %></div>
          </div>

          <div class="mt-4">
            <h3 class="font-medium text-success mb-2">Files:</h3>
            <ul class="space-y-1">
              <%= for file <- @metadata.files do %>
                <li class="flex justify-between items-center text-sm text-base-content">
                  <span><%= file.filename %></span>
                  <span class="text-base-content/70">(<%= format_bytes(file.size) %>)</span>
                </li>
              <% end %>
            </ul>
          </div>

          <div class="mt-4 p-3 bg-info/10 border border-info/20 rounded">
            <p class="text-sm text-info">
              <strong>Note:</strong> Save your transaction ID to download these files later.
            </p>
          </div>
        </div>
      <% end %>
    </div>
    """
  end

  defp format_bytes(bytes) when is_integer(bytes) do
    cond do
      bytes >= 1_073_741_824 -> "#{Float.round(bytes / 1_073_741_824, 2)} GB"
      bytes >= 1_048_576 -> "#{Float.round(bytes / 1_048_576, 2)} MB"
      bytes >= 1024 -> "#{Float.round(bytes / 1024, 2)} KB"
      true -> "#{bytes} B"
    end
  end

  defp format_bytes(_), do: "Unknown"

  defp error_to_string(:too_large), do: "File is too large (max 50MB)"
  defp error_to_string(:too_many_files), do: "Too many files (max 10)"
  defp error_to_string(:not_accepted), do: "File type not accepted"
  defp error_to_string(_), do: "Upload error"
end