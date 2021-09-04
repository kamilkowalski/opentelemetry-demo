defmodule Cms.Repo.Migrations.CreateEggs do
  use Ecto.Migration

  def change do
    create table(:eggs) do
      add :laid_at, :naive_datetime
      add :status, :string

      timestamps()
    end

  end
end
