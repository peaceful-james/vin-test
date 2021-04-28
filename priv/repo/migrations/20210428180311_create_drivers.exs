defmodule Vin.Repo.Migrations.CreateDrivers do
  use Ecto.Migration

  def change do
    create table(:drivers) do
      add :name, :string

      timestamps()
    end

  end
end
