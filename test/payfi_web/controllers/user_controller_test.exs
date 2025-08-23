defmodule PayfiWeb.UserControllerTest do
  use PayfiWeb.ConnCase
  alias Payfi.Accounts
  @invalid_attrs %{name: nil, email: nil}

  describe "user routes" do
    test "registration success", %{conn: conn} do
      params = %{
        "email" => "antonio@email.com",
        "name" => "antonio"
      }

      conn =
        conn
        |> post("/api/user/create", params)

      list_users =
        Accounts.list_users()

      user =
        list_users
        |> List.last()

      assert conn.status == 201
      assert conn.resp_body == "{\"id\":#{user.id}}"
      assert length(list_users) == 1
    end

    test "registration failure", %{conn: conn} do
      conn =
        conn
        |> post("/api/user/create", @invalid_attrs)

      users = Accounts.list_users()

      assert length(users) == 0
      assert conn.status == 422
      assert conn.resp_body == "{\"error\":\"name can't be blank, email can't be blank\"}"
    end
  end
end
