defmodule Cms.TimeTracking.Client do
  def cluck_in() do
    Tesla.post(client(), "/cluckIn", %{})
  end

  defp client do
    config = Application.get_env(:cms, Cms.TimeTracking)

    middleware = [
      TeslaMiddlewareOpentelemetry,
      Tesla.Middleware.Telemetry,
      {Tesla.Middleware.BaseUrl, config[:base_url]},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Timeout, timeout: 2_000}
    ]

    Tesla.client(middleware)
  end
end
