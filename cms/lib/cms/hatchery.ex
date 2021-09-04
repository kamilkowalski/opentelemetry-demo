defmodule Cms.Hatchery do
  @moduledoc """
  The Hatchery context.
  """

  import Ecto.Query, warn: false
  alias Cms.Repo

  alias Cms.Hatchery.Egg

  @doc """
  Returns the list of eggs.

  ## Examples

      iex> list_eggs()
      [%Egg{}, ...]

  """
  def list_eggs do
    Repo.all(Egg)
  end

  @doc """
  Gets a single egg.

  Raises `Ecto.NoResultsError` if the Egg does not exist.

  ## Examples

      iex> get_egg!(123)
      %Egg{}

      iex> get_egg!(456)
      ** (Ecto.NoResultsError)

  """
  def get_egg!(id), do: Repo.get!(Egg, id)

  @doc """
  Creates a egg.

  ## Examples

      iex> create_egg(%{field: value})
      {:ok, %Egg{}}

      iex> create_egg(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_egg(attrs \\ %{}) do
    %Egg{}
    |> Egg.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a egg.

  ## Examples

      iex> update_egg(egg, %{field: new_value})
      {:ok, %Egg{}}

      iex> update_egg(egg, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_egg(%Egg{} = egg, attrs) do
    egg
    |> Egg.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a egg.

  ## Examples

      iex> delete_egg(egg)
      {:ok, %Egg{}}

      iex> delete_egg(egg)
      {:error, %Ecto.Changeset{}}

  """
  def delete_egg(%Egg{} = egg) do
    Repo.delete(egg)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking egg changes.

  ## Examples

      iex> change_egg(egg)
      %Ecto.Changeset{data: %Egg{}}

  """
  def change_egg(%Egg{} = egg, attrs \\ %{}) do
    Egg.changeset(egg, attrs)
  end
end
