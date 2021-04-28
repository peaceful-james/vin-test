defmodule Vin.Repo.Migrations.AddDriverIdToCars do
  use Ecto.Migration

  def change do
    alter table(:cars) do
      add :driver_id, references(:drivers, on_delete: :nothing), null: true
    end
  end
end
