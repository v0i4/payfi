defmodule Payfi.DrawsTest do
  use Payfi.DataCase

  alias Payfi.Draws

  describe "draws" do
    alias Payfi.Draws.Draw

    import Payfi.DrawsFixtures

    @invalid_attrs %{name: nil, date: nil}

    test "list_draws/0 returns all draws" do
      draw = draw_fixture()
      assert Draws.list_draws() == [draw]
    end

    test "get_draw!/1 returns the draw with given id" do
      draw = draw_fixture()
      assert Draws.get_draw!(draw.id) == draw
    end

    test "create_draw/1 with valid data creates a draw" do
      valid_attrs = %{name: "some name", date: ~D[2025-08-21]}

      assert {:ok, %Draw{} = draw} = Draws.create_draw(valid_attrs)
      assert draw.name == "some name"
      assert draw.date == ~D[2025-08-21]
    end

    test "create_draw/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Draws.create_draw(@invalid_attrs)
    end

    test "update_draw/2 with valid data updates the draw" do
      draw = draw_fixture()
      update_attrs = %{name: "some updated name", date: ~D[2025-08-22]}

      assert {:ok, %Draw{} = draw} = Draws.update_draw(draw, update_attrs)
      assert draw.name == "some updated name"
      assert draw.date == ~D[2025-08-22]
    end

    test "update_draw/2 with invalid data returns error changeset" do
      draw = draw_fixture()
      assert {:error, %Ecto.Changeset{}} = Draws.update_draw(draw, @invalid_attrs)
      assert draw == Draws.get_draw!(draw.id)
    end

    test "delete_draw/1 deletes the draw" do
      draw = draw_fixture()
      assert {:ok, %Draw{}} = Draws.delete_draw(draw)
      assert_raise Ecto.NoResultsError, fn -> Draws.get_draw!(draw.id) end
    end

    test "change_draw/1 returns a draw changeset" do
      draw = draw_fixture()
      assert %Ecto.Changeset{} = Draws.change_draw(draw)
    end
  end
end
