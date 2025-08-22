defmodule PayfiWeb.DrawController do
  use PayfiWeb, :controller
  alias Payfi.Handlers.DrawHandler

  def create(conn, params) do
    with {:ok, draw} <- DrawHandler.create_draw(params) do
      conn
      |> put_status(:created)
      |> json(%{id: draw.id})
    else
      {:error, reason} ->
        conn
        |> put_status(:bad_request)
        |> json(%{error: reason})
    end
  end
end
