defmodule Arch.Application do
  use Application

  def start(_type, _args) do
    children = [
      # This is the new line
      Arch.Scheduler
    ]

    opts = [strategy: :one_for_one, name: Arch.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
