defmodule CmsWeb.EggControllerTest do
  use CmsWeb.ConnCase

  alias Cms.Hatchery

  @create_attrs %{laid_at: ~N[2010-04-17 14:00:00], status: "some status"}
  @update_attrs %{laid_at: ~N[2011-05-18 15:01:01], status: "some updated status"}
  @invalid_attrs %{laid_at: nil, status: nil}

  def fixture(:egg) do
    {:ok, egg} = Hatchery.create_egg(@create_attrs)
    egg
  end

  describe "index" do
    test "lists all eggs", %{conn: conn} do
      conn = get(conn, Routes.egg_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Eggs"
    end
  end

  describe "new egg" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.egg_path(conn, :new))
      assert html_response(conn, 200) =~ "New Egg"
    end
  end

  describe "create egg" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.egg_path(conn, :create), egg: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.egg_path(conn, :show, id)

      conn = get(conn, Routes.egg_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Egg"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.egg_path(conn, :create), egg: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Egg"
    end
  end

  describe "edit egg" do
    setup [:create_egg]

    test "renders form for editing chosen egg", %{conn: conn, egg: egg} do
      conn = get(conn, Routes.egg_path(conn, :edit, egg))
      assert html_response(conn, 200) =~ "Edit Egg"
    end
  end

  describe "update egg" do
    setup [:create_egg]

    test "redirects when data is valid", %{conn: conn, egg: egg} do
      conn = put(conn, Routes.egg_path(conn, :update, egg), egg: @update_attrs)
      assert redirected_to(conn) == Routes.egg_path(conn, :show, egg)

      conn = get(conn, Routes.egg_path(conn, :show, egg))
      assert html_response(conn, 200) =~ "some updated status"
    end

    test "renders errors when data is invalid", %{conn: conn, egg: egg} do
      conn = put(conn, Routes.egg_path(conn, :update, egg), egg: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Egg"
    end
  end

  describe "delete egg" do
    setup [:create_egg]

    test "deletes chosen egg", %{conn: conn, egg: egg} do
      conn = delete(conn, Routes.egg_path(conn, :delete, egg))
      assert redirected_to(conn) == Routes.egg_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.egg_path(conn, :show, egg))
      end
    end
  end

  defp create_egg(_) do
    egg = fixture(:egg)
    %{egg: egg}
  end
end
