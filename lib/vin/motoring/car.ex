defmodule Vin.Motoring.Car do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cars" do
    field :charge_status, :string
    field :vin, :string

    timestamps()
  end

  @doc false
  def changeset(car, attrs) do
    car
    |> cast(attrs, [:vin, :charge_status])
    |> validate_required([:vin, :charge_status])
  end
end
