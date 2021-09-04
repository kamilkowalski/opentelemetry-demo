import Config

config :cms, Cms.Repo,
  username: "postgres",
  password: "postgres",
  database: "cms_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :cms, CmsWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [
    node: [
      "node_modules/webpack/bin/webpack.js",
      "--mode",
      "development",
      "--watch-stdin",
      cd: Path.expand("../assets", __DIR__)
    ]
  ]

config :cms, CmsWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/cms_web/(live|views)/.*(ex)$",
      ~r"lib/cms_web/templates/.*(eex)$"
    ]
  ]

config :cms, Cms.TimeTracking, base_url: "http://localhost:3000"

config :phoenix, :stacktrace_depth, 20

config :phoenix, :plug_init_mode, :runtime
