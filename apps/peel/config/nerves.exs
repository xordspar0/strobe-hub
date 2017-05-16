use Mix.Config

config :logger, :console,
  level: :info,
  format: "$date $time $metadata [$level]$levelpad $message\n",
  metadata: [:module, :line],
  colors: [enabled: false]

config :peel, Peel.Repo,
  adapter: Sqlite.Ecto,
  database: "/state/db/current/peel.sqlite"

config :peel, Peel.Webdav,
  root: "/state/data/peel",
  port: 8080

config :peel, Peel.Modifications.Create, [
  # wait between getting event and testing the file status (ms)
  queue_delay: 2_000,
]
