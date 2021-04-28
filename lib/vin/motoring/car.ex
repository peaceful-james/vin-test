defmodule Vin.Motoring.Car do
  use Ecto.Schema
  import Ecto.Changeset
  alias Vin.Motoring.Driver
  alias Vin.Vin

  schema "cars" do
    field(:charge_status, Ecto.Enum, values: [:charging, :disconnected])
    field(:vin, :string)
    belongs_to(:driver, Driver)

    timestamps()
  end

  @doc false
  def changeset(car, attrs) do
    car
    |> cast(attrs, [:vin, :charge_status, :driver_id])
    |> validate_required([:vin, :charge_status])
    |> validate_vin()
  end

  @doc """
  Validates a car's VIN using check digit calculation
  See https://en.wikipedia.org/wiki/Vehicle_identification_number#Check-digit_calculation
  """
  @spec validate_vin(%Ecto.Changeset{}) :: %Ecto.Changeset{}
  def validate_vin(changeset) do
    message = "Is not a valid VIN format."

    changeset
    |> validate_change(:vin, {:vin, [message: message]}, fn _, value ->
      case Vin.is_valid?(value) do
        true ->
          []

        false ->
          [{:vin, {message, [validation: :vin]}}]
      end
    end)
  end
end
