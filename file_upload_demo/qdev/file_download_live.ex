defmodule DemoWeb.FileDownloadLive do
  use DemoWeb, :live_view
  alias Demo.Uploads

  @impl true
  def mount(_params, _session, socket) do
    transactions = Uploads.list_all_transactions()

    socket =
      socket
      |> assign(:transactions, transactions)

    {:ok, socket}
  end

  @impl true
  def handle_event("delete_transaction", %{"transaction_id" => transaction_id}, socket) do
    Uploads.delete_transaction(transaction_id)
    transactions = Uploads.list_all_transactions()

    socket =
      socket
      |> assign(:transactions, transactions)
      |> put_flash(:info, "Transaction deleted successfully")

    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="max-w-6xl mx-auto p-6">
      <h1 class="text-3xl font-bold mb-6 text-base-content">All Transactions</h1>

      <%= if @transactions == [] do %>
        <div class="text-center py-12">
          <p class="text-base-content/70">No transactions found</p>
        </div>
      <% else %>
        <div class="grid gap-4">
          <%= for transaction <- @transactions do %>
            <div class="p-6 bg-base-200 border border-base-300 rounded-lg shadow-sm">
              <div class="flex items-center justify-between mb-4">
                <div>
                  <h3 class="font-semibold text-lg text-base-content">Transaction</h3>
                  <code class="text-sm bg-base-300 px-2 py-1 rounded text-base-content"><%= transaction.transaction_id %></code>
                </div>
                <div class="flex gap-2">
                  <a
                    href={~p"/download/#{transaction.transaction_id}"}
                    class="p-2 text-success hover:bg-success/10 rounded"
                    title="Download transaction as ZIP"
                  >
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                    </svg>
                  </a>
                  <button
                    phx-click="delete_transaction"
                    phx-value-transaction_id={transaction.transaction_id}
                    class="p-2 text-error hover:bg-error/10 rounded"
                    onclick="return confirm('Delete this transaction?')"
                  >
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>
                    </svg>
                  </button>
                </div>
              </div>

              <div class="text-sm text-base-content/70 mb-4">
                <div><strong>Upload Time:</strong> <%= transaction.timestamp %></div>
                <div><strong>Files:</strong> <%= transaction.file_count %></div>
              </div>

              <div class="space-y-2">
                <%= for file <- transaction.files do %>
                  <div class="flex items-center justify-between p-3 bg-base-100 rounded">
                    <div class="flex items-center">
                      <span class="font-medium text-base-content"><%= file.filename %></span>
                      <span class="text-base-content/50 ml-2">(<%= format_bytes(file.size) %>)</span>
                    </div>
                    <a
                      href={~p"/download/#{transaction.transaction_id}"}
                      class="p-2 text-success hover:bg-success/10 rounded"
                    >
                      <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                      </svg>
                    </a>
                  </div>
                <% end %>
              </div>
            </div>
          <% end %>
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
end