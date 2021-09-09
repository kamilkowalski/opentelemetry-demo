import Config

database_url =
  System.get_env("DATABASE_URL") ||
    raise """
    environment variable DATABASE_URL is missing.
    For example: ecto://USER:PASS@HOST/DATABASE
    """

config :cms, Cms.Repo,
  # ssl: true,
  url: database_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

config :cms, CmsWeb.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT") || "4000"),
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: secret_key_base

config :cms, CmsWeb.Endpoint, server: true

time_tracking_url =
  System.get_env("TIME_TRACKING_URL") ||
    raise """
    environment variable TIME_TRACKING_URL is missing.
    Point it to the Time Tracking application URL.
    """

config :cms, Cms.TimeTracking, base_url: time_tracking_url

otel_collector_host = System.get_env("OTEL_COLLECTOR_HOST")
otel_collector_port = System.get_env("OTEL_COLLECTOR_PORT")

if otel_collector_host && otel_collector_port do
  otel_collector_host = String.to_charlist(otel_collector_host)
  {otel_collector_port, ""} = Integer.parse(otel_collector_port)

  config :opentelemetry, :processors,
    otel_batch_processor: %{
      exporter:
        {:opentelemetry_exporter,
         %{endpoints: [{:http, otel_collector_host, otel_collector_port, []}]}}
    }
end
