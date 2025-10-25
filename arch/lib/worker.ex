defmodule Arch.Worker do
  require Logger

  def exec do
    Task.start(fn ->
      try do
        Logger.info("Running cron job at #{DateTime.utc_now()}")
      rescue
        e -> Logger.error("Cron job failed: #{inspect(e)}")
      end
    end)
  end
end
