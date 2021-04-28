defmodule VinWeb.Resolvers.Drivers do
  @driver %{id: 0, name: "Example Driver"}
  @car_1 %{id: 0, vin: "11111111111111111", charge_status: "disconnected"}
  @car_2 %{id: 1, vin: "22222222222222222", charge_status: "charging"}

  def create_driver(_, _, _) do
    {:ok, @driver}
  end

  def get_driver(_, _, _) do
    {:ok, @driver}
  end

  def list_drivers(_, _, _) do
    {:ok, [@driver]}
  end

  def create_car(_, _, _) do
    {:ok, @car_1}
  end

  def cars(_, _, _) do
    {:ok, [@car_1, @car_2]}
  end

  def delete_car(_, _, _) do
    {:ok, @car_1}
  end
end
