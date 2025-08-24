defmodule PayfiWeb.DrawControllerTest do
  use PayfiWeb.ConnCase
  use Oban.Testing, repo: Payfi.Repo
  alias Payfi.Draws
  alias Payfi.AccountsFixtures
  alias Payfi.DrawsFixtures

  @invalid_attrs %{name: nil, date: nil}
  @invalid_date_format_attrs %{name: nil, date: "01/01/2022"}
  @valid_date_missing_name %{name: nil, date: "2022-01-01"}

  describe "draw routes" do
    test "draw create success", %{conn: conn} do
      params = %{
        "name" => "draw 1",
        "date" => "2022-01-01"
      }

      conn =
        conn
        |> post("/api/draw/create", params)

      draw =
        Payfi.Draws.list_draws()
        |> List.last()

      assert conn.status == 201
      assert conn.resp_body == "{\"id\":#{draw.id}}"
    end

    test "draw create failure", %{conn: conn} do
      conn =
        conn
        |> post("/api/draw/create", @invalid_attrs)

      draws = Payfi.Draws.list_draws()

      assert length(draws) == 0
      assert conn.status == 422
      assert conn.resp_body == "{\"error\":\"name can't be blank, date can't be blank\"}"
    end

    test "draw create with invalid date format", %{conn: conn} do
      conn =
        conn
        |> post("/api/draw/create", @invalid_date_format_attrs)

      draws = Payfi.Draws.list_draws()

      assert length(draws) == 0
      assert conn.status == 422
      assert conn.resp_body == "{\"error\":\"name can't be blank, date is invalid\"}"
    end

    test "draw create with valid date format but missing name", %{conn: conn} do
      conn =
        conn
        |> post("/api/draw/create", @valid_date_missing_name)

      draws = Payfi.Draws.list_draws()

      assert length(draws) == 0
      assert conn.status == 422
      assert conn.resp_body == "{\"error\":\"name can't be blank\"}"
    end

    test "draw result - after run", %{conn: conn} do
      draw =
        DrawsFixtures.draw_fixture()

      user1 = AccountsFixtures.user_fixture()
      user2 = AccountsFixtures.user_fixture()
      user3 = AccountsFixtures.user_fixture()

      Payfi.Participations.create_participation(%{
        "user_id" => user1.id,
        "draw_id" => draw.id
      })

      Payfi.Participations.create_participation(%{
        "user_id" => user2.id,
        "draw_id" => draw.id
      })

      Payfi.Participations.create_participation(%{
        "user_id" => user3.id,
        "draw_id" => draw.id
      })

      Payfi.Draws.run(draw.id)

      draw_after =
        Payfi.Draws.get_draw!(draw.id)

      conn =
        conn
        |> get("/api/draw/result/#{draw.id}")

      assert conn.status == 200
      assert draw_after.active == false
      refute draw_after.winner_id == nil

      {:ok, result} = Draws.get_result(draw_after.id)
      refute is_nil(result)
      refute is_nil(result.name)
      refute is_nil(result.email)
      assert result.id == draw_after.winner_id

      assert {:ok, %{id: _, name: _, email: _}} = Draws.get_result(draw_after.id)
    end

    test "draw result - before run", %{conn: conn} do
      draw =
        DrawsFixtures.draw_fixture()

      user1 = AccountsFixtures.user_fixture()
      user2 = AccountsFixtures.user_fixture()
      user3 = AccountsFixtures.user_fixture()

      Payfi.Participations.create_participation(%{
        "user_id" => user1.id,
        "draw_id" => draw.id
      })

      Payfi.Participations.create_participation(%{
        "user_id" => user2.id,
        "draw_id" => draw.id
      })

      Payfi.Participations.create_participation(%{
        "user_id" => user3.id,
        "draw_id" => draw.id
      })

      conn =
        conn
        |> get("/api/draw/result/#{draw.id}")

      assert conn.status == 404
      assert draw.active == true
      assert draw.winner_id == nil

      assert {:error, "This draw does not have a winner yet."} = Draws.get_result(draw.id)
    end
  end

  describe "oban jobs" do
    test "daily draw run" do
      user1 = AccountsFixtures.user_fixture()
      user2 = AccountsFixtures.user_fixture()
      user3 = AccountsFixtures.user_fixture()

      draw = DrawsFixtures.draw_fixture()

      Payfi.Participations.create_participation(%{
        "user_id" => user1.id,
        "draw_id" => draw.id
      })

      Payfi.Participations.create_participation(%{
        "user_id" => user2.id,
        "draw_id" => draw.id
      })

      Payfi.Participations.create_participation(%{
        "user_id" => user3.id,
        "draw_id" => draw.id
      })

      assert draw.active == true
      assert is_nil(draw.winner_id)
      assert {:error, "This draw does not have a winner yet."} = Draws.get_result(draw.id)

      assert :ok = perform_job(Payfi.Workers.DailyDrawRun, %{})

      after_job_draw =
        Payfi.Draws.get_draw!(draw.id)

      assert after_job_draw.active == false
      refute is_nil(after_job_draw.winner_id)

      assert {:ok, %{id: _, name: _, email: _}} = Draws.get_result(draw.id)
    end
  end
end
