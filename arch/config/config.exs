import Config

config :arch, Arch.Scheduler,
  jobs: [
    {"* * * * *", {Heartbeat, :send, []}}
  ]
