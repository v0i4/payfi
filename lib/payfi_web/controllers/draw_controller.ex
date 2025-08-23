defmodule PayfiWeb.DrawController do
  use PayfiWeb, :controller
  alias Payfi.Handlers.DrawHandler

  def create(conn, params) do
    with {:ok, draw} <- DrawHandler.create_draw(params) do
      conn
      |> put_status(201)
      |> json(%{id: draw.id})
    else
      {:error, reason} ->
        conn
        |> put_status(422)
        |> json(%{error: reason})
    end
  end

  def get_result(conn, %{"id" => id}) do
    with {:ok, winner} <- DrawHandler.get_result(id) do
      conn
      |> put_status(203)
      |> json(%{result: winner})
    else
      {:error, reason} ->
        conn
        |> put_status(:bad_request)
        |> json(%{error: reason})
    end
  end
end
