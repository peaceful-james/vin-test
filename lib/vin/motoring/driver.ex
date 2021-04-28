defmodule Vin.Motoring.Driver do
  use Ecto.Schema
  import Ecto.Changeset
  alias Vin.Motoring.Car

  schema "drivers" do
    field(:name, :string)
    has_many(:car, Car)

    timestamps()
  end

  @doc false
  def changeset(driver, attrs) do
    driver
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
