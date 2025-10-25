import Config

config :arch, Arch.Scheduler,
  debug_logging: false,
  jobs: [
    simple = [
      schedule: {:extended, "*/10"},
      task: {Arch.Worker, :exec, []}
    ]
  ]
