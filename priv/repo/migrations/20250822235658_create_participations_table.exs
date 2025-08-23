defmodule Payfi.Repo.Migrations.CreateParticipationsTable do
  use Ecto.Migration

  def change do
    create table(:participations) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :draw_id, references(:draws, on_delete: :delete_all), null: false

      timestamps()
    end

    create unique_index(:participations, [:user_id, :draw_id],
             name: :participations_user_draw_unique
           )

    create index(:participations, [:user_id])
    create index(:participations, [:draw_id])
  end
end
