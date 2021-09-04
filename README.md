# OpenTelemetry Demo

To run this demo, you only need Docker, `docker-compose`, and the Loki Docker plugin.

You can install the Loki Docker plugin using:

```bash
docker plugin install grafana/loki-docker-driver:latest --alias loki --grant-all-permissions
```

The `main` branch contains the basic app, before instrumenting with OpenTelemetry, but with Grafana, Tempo and Loki available.

The `instrumented` branch is the instrumented app, the outcome of going through the demo steps below.

To bring up all services and test the app, run:

```bash
docker-compose up -d
```

If you want to work on the `cms` app, just shut it down in Docker:

```bash
docker-compose stop cms
```

# Demo steps

## Install the SDK

Add the following deps:

```elixir
[
  {:opentelemetry, "~> 1.0.0-rc.2"},
]
```

Configure the console exporter:

```elixir
# config/dev.exs
config :opentelemetry, :processors,
  otel_batch_processor: %{
    exporter: {:otel_exporter_stdout, []}
  }
```

## Add instrumentation libraries

Add the following deps:

```elixir
[
  {:opentelemetry_ecto, "~> 1.0.0-rc.1"},
  {:opentelemetry_phoenix, "~> 1.0.0-rc.2"},
]
```

Add the following to the `Cms.Application.start/2` function:

```elixir
OpentelemetryEcto.setup([:cms, :repo])
OpentelemetryPhoenix.setup()
```

## Send it over to Tempo

Install the OpenTelemetry exporter:

```elixir
[
  {:opentelemetry_exporter, "~> 1.0.0-rc.1"},
]
```

Configure it:

```elixir
# config/config.exs
config :opentelemetry, :resource, service: %{name: "cms"}

# config/dev.exs
config :opentelemetry, :processors,
  otel_batch_processor: %{
    exporter: {:opentelemetry_exporter, %{endpoints: [{:http, 'localhost', 55681, []}]}}
  }
```

# Add trace_id and span_id to logger metadata

Install the logger metadata library:

```elixir
[
  {:opentelemetry_logger_metadata, "~> 0.1.0-rc"},
]
```

Configure it in `Cms.Application.start/2`:

```elixir
OpentelemetryLoggerMetadata.setup()
```

Show span_id and trace_id in logs:

```elixir
# config/config.exs

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:span_id, :trace_id]
```

## Connect Loki and Tempo

Add environment variables to cms service:

```yml
# compose.yaml
cms:
  environment:
    # ...
    OTEL_COLLECTOR_HOST: "tempo"
    OTEL_COLLECTOR_PORT: "55681"
```

Configure the exporter for production:

```elixir
# config/releases.exs
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
```

## Configure distributed tracing

Install a Tesla middleware that injects OpenTelemetry propagator headers:

```elixir
[
  {:tesla_middleware_opentelemetry, github: "kamilkowalski/tesla_middleware_opentelemetry"},
]
```

Use it in the Time Tracking client (after the BaseUrl middleware):

```elixir
middleware = [
  # ...
  TeslaMiddlewareOpentelemetry,
]
```
