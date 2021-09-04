defmodule Cms.Release do
  @app :cms

  def setup do
    create()
    migrate()
  end

  def create do
    load_app()

    for repo <- repos() do
      case repo.__adapter__.storage_up(repo.config) do
        :ok ->
          :ok

        {:error, :already_up} ->
          :ok

        {:error, term} when is_binary(term) ->
          raise "The database for #{inspect(repo)} couldn't be created: #{term}"

        {:error, term} ->
          raise "The database for #{inspect(repo)} couldn't be created: #{inspect(term)}"
      end
    end
  end

  def migrate do
    load_app()

    for repo <- repos() do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end
  end

  def rollback(repo, version) do
    load_app()
    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
  end

  defp repos do
    Application.fetch_env!(@app, :ecto_repos)
  end

  defp load_app do
    Application.load(@app)
  end
end
