defmodule PayfiWeb.DrawControllerTest do
  use PayfiWeb.ConnCase

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
  end
end
