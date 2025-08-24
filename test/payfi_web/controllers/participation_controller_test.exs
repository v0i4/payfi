defmodule PayfiWeb.ParticipationControllerTest do
  use PayfiWeb.ConnCase
  use Oban.Testing, repo: Payfi.Repo
  alias Payfi.AccountsFixtures
  alias Payfi.DrawsFixtures

  describe "participation routes" do
    test "participation create success", %{conn: conn} do
      user = AccountsFixtures.user_fixture()
      draw = DrawsFixtures.draw_fixture()

      params =
        %{
          "user_id" => user.id,
          "draw_id" => draw.id
        }

      conn =
        conn
        |> post("/api/participation/create", params)

      assert conn.status == 201
      assert conn.resp_body == "{\"status\":\"ok\"}"
    end

    test "participation create with invalid params", %{conn: conn} do
      user = AccountsFixtures.user_fixture()

      params = %{
        "user_id" => user.id,
        "draw_id" => 999
      }

      conn =
        conn
        |> post("/api/participation/create", params)

      participations = Payfi.Participations.list_participations()

      assert length(participations) == 0
      assert conn.status == 422
      assert conn.resp_body == "{\"error\":\"Incorrect params or this draw is already expired\"}"
    end

    test "participation must fail when user try to join twice at the same draw", %{conn: conn} do
      user = AccountsFixtures.user_fixture()
      draw = DrawsFixtures.draw_fixture()

      params = %{
        "user_id" => user.id,
        "draw_id" => draw.id
      }

      first_conn =
        conn
        |> post("/api/participation/create", params)

      participations = Payfi.Participations.list_participations()

      assert length(participations) == 1
      assert first_conn.status == 201

      second_conn =
        conn
        |> post("/api/participation/create", params)

      participations = Payfi.Participations.list_participations()

      assert length(participations) == 1
      assert second_conn.status == 422

      assert second_conn.resp_body ==
               "{\"error\":\"user_id has already been taken\"}"
    end

    test "participation create fail when user try to join a non existing draw", %{conn: conn} do
      user = AccountsFixtures.user_fixture()

      invalid_draw = %{
        "user_id" => user.id,
        "draw_id" => 999
      }

      conn =
        conn
        |> post("/api/participation/create", invalid_draw)

      participations = Payfi.Participations.list_participations()

      assert length(participations) == 0
      assert conn.status == 422
      assert conn.resp_body == "{\"error\":\"Incorrect params or this draw is already expired\"}"
    end

    test "participation create fail when user try to join a non existing user", %{conn: conn} do
      draw = DrawsFixtures.draw_fixture()

      invalid_user = %{
        "user_id" => 999,
        "draw_id" => draw.id
      }

      conn =
        conn
        |> post("/api/participation/create", invalid_user)

      participations = Payfi.Participations.list_participations()

      assert length(participations) == 0
      assert conn.status == 422
      assert conn.resp_body == "{\"error\":\"Incorrect params or this draw is already expired\"}"
    end

    test "participation create fail when user try to join a non existing user and draw", %{
      conn: conn
    } do
      invalid_user = %{}

      conn =
        conn
        |> post("/api/participation/create", invalid_user)

      participations = Payfi.Participations.list_participations()

      assert length(participations) == 0
      assert conn.status == 422
      assert conn.resp_body == "{\"error\":\"Invalid params\"}"
    end

    test "participation should fail when draw is not active anymore", %{conn: conn} do
      user = AccountsFixtures.user_fixture()
      draw = DrawsFixtures.draw_fixture()

      params = %{
        "user_id" => user.id,
        "draw_id" => draw.id
      }

      conn =
        conn
        |> post("/api/participation/create", params)

      assert conn.status == 201

      perform_job(Payfi.Workers.DailyDrawRun, %{})

      another_user = AccountsFixtures.user_fixture()

      new_params = %{
        "user_id" => another_user.id,
        "draw_id" => draw.id
      }

      conn =
        conn
        |> post("/api/participation/create", new_params)

      assert conn.status == 422
      assert conn.resp_body == "{\"error\":\"Incorrect params or this draw is already expired\"}"
    end
  end
end
