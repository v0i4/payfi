defmodule PayfiWeb.UserController do
  use PayfiWeb, :controller
  alias Payfi.Handlers.UserHandler
  alias Payfi.Utils

  def create(conn, params) do
    with {:ok, user} <- UserHandler.create_user(params) do
      conn
      |> put_status(201)
      |> json(%{id: user.id})
    else
      {:error, message} ->
        conn
        |> put_status(422)
        |> json(%{error: Utils.get_error_message(message)})
    end
  end
end
