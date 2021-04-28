defmodule Vin.Repo.Migrations.CreateCars do
  use Ecto.Migration

  def change do
    create table(:cars) do
      add :vin, :string
      add :charge_status, :string

      timestamps()
    end

  end
end
