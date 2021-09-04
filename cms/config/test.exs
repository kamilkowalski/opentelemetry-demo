import Config

config :cms, Cms.Repo,
  username: "postgres",
  password: "postgres",
  database: "cms_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :cms, CmsWeb.Endpoint,
  http: [port: 4002],
  server: false

config :logger, level: :warn
