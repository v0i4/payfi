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
    |> cast(attrs, [:name, :date, :active, :winner_id])
    |> validate_required([:name, :date])
    |> validate_draw_expiration()
  end

  def validate_draw_expiration(%Ecto.Changeset{valid?: true} = changeset) do
    date = get_field(changeset, :date)

    case Date.compare(date, Date.utc_today()) do
      :lt -> add_error(changeset, :date, "must be in the future")
      _ -> changeset
    end
  end

  def validate_draw_expiration(changeset) do
    changeset
  end
end
