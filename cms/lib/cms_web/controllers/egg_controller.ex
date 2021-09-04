defmodule CmsWeb.EggController do
  use CmsWeb, :controller

  alias Cms.Hatchery
  alias Cms.Hatchery.Egg

  def index(conn, _params) do
    eggs = Hatchery.list_eggs()
    render(conn, "index.html", eggs: eggs)
  end

  def new(conn, _params) do
    changeset = Hatchery.change_egg(%Egg{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"egg" => egg_params}) do
    case Hatchery.create_egg(egg_params) do
      {:ok, egg} ->
        conn
        |> put_flash(:info, "Egg created successfully.")
        |> redirect(to: Routes.egg_path(conn, :show, egg))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    egg = Hatchery.get_egg!(id)
    render(conn, "show.html", egg: egg)
  end

  def edit(conn, %{"id" => id}) do
    egg = Hatchery.get_egg!(id)
    changeset = Hatchery.change_egg(egg)
    render(conn, "edit.html", egg: egg, changeset: changeset)
  end

  def update(conn, %{"id" => id, "egg" => egg_params}) do
    egg = Hatchery.get_egg!(id)

    case Hatchery.update_egg(egg, egg_params) do
      {:ok, egg} ->
        conn
        |> put_flash(:info, "Egg updated successfully.")
        |> redirect(to: Routes.egg_path(conn, :show, egg))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", egg: egg, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    egg = Hatchery.get_egg!(id)
    {:ok, _egg} = Hatchery.delete_egg(egg)

    conn
    |> put_flash(:info, "Egg deleted successfully.")
    |> redirect(to: Routes.egg_path(conn, :index))
  end
end
