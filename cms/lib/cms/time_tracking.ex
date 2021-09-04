defmodule Cms.TimeTracking do
  alias Cms.TimeTracking.Client
  require Logger

  def cluck_in do
    case Client.cluck_in() do
      {:ok, _} ->
        :ok

      {:error, error} ->
        Logger.error("Error clucking in: #{inspect(error)}")
        :error
    end
  end
end
