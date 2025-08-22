defmodule Payfi.Repo.Migrations.CreateDraws do
  use Ecto.Migration

  def change do
    create table(:draws) do
      add :name, :string
      add :date, :date
      add :active, :boolean, default: true

      timestamps(type: :utc_datetime)
    end
  end
end
