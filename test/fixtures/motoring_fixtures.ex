defmodule Vin.MotoringFixtures do
  alias Vin.Motoring

  def driver_fixture(attrs \\ %{}) do
    {:ok, driver} = Motoring.create_driver(attrs |> Enum.into(%{name: "Example Driver"}))
    driver
  end

  def car_fixture(attrs \\ %{}) do
    driver_id = attrs |> Map.take([:driver_id, "driver_id"]) |> Map.values() |> List.first()

    {:ok, car} =
      Motoring.create_car(
        attrs
        |> Enum.into(%{
          vin: "11111111111111111",
          charge_status: :disconnected,
          driver_id: driver_id || driver_fixture().id
        })
      )

    car
  end
end
