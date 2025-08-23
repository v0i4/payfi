defmodule PayfiWeb.ParticipationController do
  use PayfiWeb, :controller
  require Protocol
  alias Payfi.Utils

  def create(conn, params) do
    with {:ok, _participation} <- Payfi.Handlers.ParticipationHandler.create_participation(params) do
      conn
      |> put_status(201)
      |> json(%{"status" => "ok"})
    else
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(422)
        |> json(%{error: Utils.get_error_message(changeset)})

      {:error, reason} ->
        conn
        |> put_status(422)
        |> json(%{error: reason})
    end
  end
end
