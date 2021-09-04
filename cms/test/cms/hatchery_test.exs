defmodule Cms.HatcheryTest do
  use Cms.DataCase

  alias Cms.Hatchery

  describe "eggs" do
    alias Cms.Hatchery.Egg

    @valid_attrs %{laid_at: ~N[2010-04-17 14:00:00], status: "some status"}
    @update_attrs %{laid_at: ~N[2011-05-18 15:01:01], status: "some updated status"}
    @invalid_attrs %{laid_at: nil, status: nil}

    def egg_fixture(attrs \\ %{}) do
      {:ok, egg} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Hatchery.create_egg()

      egg
    end

    test "list_eggs/0 returns all eggs" do
      egg = egg_fixture()
      assert Hatchery.list_eggs() == [egg]
    end

    test "get_egg!/1 returns the egg with given id" do
      egg = egg_fixture()
      assert Hatchery.get_egg!(egg.id) == egg
    end

    test "create_egg/1 with valid data creates a egg" do
      assert {:ok, %Egg{} = egg} = Hatchery.create_egg(@valid_attrs)
      assert egg.laid_at == ~N[2010-04-17 14:00:00]
      assert egg.status == "some status"
    end

    test "create_egg/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Hatchery.create_egg(@invalid_attrs)
    end

    test "update_egg/2 with valid data updates the egg" do
      egg = egg_fixture()
      assert {:ok, %Egg{} = egg} = Hatchery.update_egg(egg, @update_attrs)
      assert egg.laid_at == ~N[2011-05-18 15:01:01]
      assert egg.status == "some updated status"
    end

    test "update_egg/2 with invalid data returns error changeset" do
      egg = egg_fixture()
      assert {:error, %Ecto.Changeset{}} = Hatchery.update_egg(egg, @invalid_attrs)
      assert egg == Hatchery.get_egg!(egg.id)
    end

    test "delete_egg/1 deletes the egg" do
      egg = egg_fixture()
      assert {:ok, %Egg{}} = Hatchery.delete_egg(egg)
      assert_raise Ecto.NoResultsError, fn -> Hatchery.get_egg!(egg.id) end
    end

    test "change_egg/1 returns a egg changeset" do
      egg = egg_fixture()
      assert %Ecto.Changeset{} = Hatchery.change_egg(egg)
    end
  end
end
