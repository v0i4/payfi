defmodule Payfi.Draws.Draw do
  use Ecto.Schema
  import Ecto.Changeset

  schema "draws" do
    field :name, :string
    field :date, :date
    field :active, :boolean, default: true
    field :winner_id, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(draw, attrs) do
    draw
    |> cast(attrs, [:name, :date])
    |> validate_required([:name, :date])
  end
end
