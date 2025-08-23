defmodule Payfi.Participations.Participation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "participations" do
    field :user_id, :integer
    field :draw_id, :integer

    timestamps()
  end

  def changeset(participation, attrs) do
    participation
    |> cast(attrs, [:user_id, :draw_id])
    |> validate_required([:user_id, :draw_id])
    |> unique_constraint(:user_id, name: :participations_user_draw_unique)
  end
end
