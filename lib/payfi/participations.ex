defmodule Payfi.Participations do
  alias Payfi.Accounts
  alias Payfi.Draws
  alias Payfi.Participations.Participation
  alias Payfi.Repo

  import Ecto.Query

  def create_participation(%{"user_id" => user_id, "draw_id" => draw_id} = _params) do
    with true <- not is_nil(user_id) and not is_nil(draw_id),
         %Accounts.User{} = user <- Accounts.get_user(user_id),
         %Draws.Draw{} = draw <- Draws.get_draw(draw_id),
         true <- draw.active do
      %Participation{}
      |> Participation.changeset(%{user_id: user.id, draw_id: draw.id})
      |> Repo.insert()
    else
      {:cache, true} -> {:error, "user_id has already been taken"}
      _ -> {:error, "Incorrect params or this draw is already expired"}
    end
  end

  def create_participation(_), do: {:error, "Invalid params"}

  def list_participations() do
    from(p in Participation)
    |> Repo.all()
  end

  def list_participations(draw_id) do
    from(p in Participation, where: p.draw_id == ^draw_id)
    |> Repo.all()
  end
end
