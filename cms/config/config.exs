import Config

config :cms,
  ecto_repos: [Cms.Repo]

config :cms, CmsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "4xDQtlD6uEfnjzYyIJEk3sJJo5gzFgaeKo4DLEPVqq5zlJtc7pOD6CEY+LM5ZUJx",
  render_errors: [view: CmsWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Cms.PubSub,
  live_view: [signing_salt: "LeLxjdUx"]

config :logger, :console, format: "$time $metadata[$level] $message\n"

config :phoenix, :json_library, Jason

config :tesla, adapter: Tesla.Adapter.Hackney

import_config "#{Mix.env()}.exs"
