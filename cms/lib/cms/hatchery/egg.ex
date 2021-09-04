defmodule Cms.Hatchery.Egg do
  use Ecto.Schema
  import Ecto.Changeset

  schema "eggs" do
    field :laid_at, :naive_datetime
    field :status, Ecto.Enum, values: [:registered, :incubating, :hatched]

    timestamps()
  end

  @doc false
  def changeset(egg, attrs) do
    egg
    |> cast(attrs, [:laid_at, :status])
    |> validate_required([:laid_at, :status])
  end
end
