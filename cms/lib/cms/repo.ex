defmodule Cms.Repo do
  use Ecto.Repo,
    otp_app: :cms,
    adapter: Ecto.Adapters.Postgres
end
