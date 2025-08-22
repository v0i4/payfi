defmodule PayfiWeb.UserController do
  use PayfiWeb, :controller
  alias Payfi.Handlers.UserHandler

  def create(conn, params) do
    with {:ok, user} <- UserHandler.create_user(params) do
      conn
      |> put_status(:created)
      |> json(%{id: user.id})
    else
      {:error, message} ->
        conn
        |> put_status(:bad_request)
        |> json(%{error: message})
    end
  end
end
