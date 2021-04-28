defmodule Vin.MotoringTest do
  use Vin.DataCase

  alias Vin.Motoring

  describe "cars" do
    alias Vin.Motoring.Car

    @valid_attrs %{charge_status: :disconnected, vin: "11111111111111111"}
    @update_attrs %{charge_status: :charging, vin: "1M8GDM9AXKP042788"}
    @invalid_attrs %{vin: "invalid"}

    def car_fixture(attrs \\ %{}) do
      {:ok, car} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Motoring.create_car()

      car
    end

    test "list_cars/0 returns all cars" do
      car = car_fixture()
      assert Motoring.list_cars() == [car]
    end

    test "get_car!/1 returns the car with given id" do
      car = car_fixture()
      assert Motoring.get_car!(car.id) == car
    end

    test "create_car/1 with valid data creates a car" do
      assert {:ok, %Car{} = car} = Motoring.create_car(@valid_attrs)
      assert car.charge_status == :disconnected
      assert car.vin == "11111111111111111"
    end

    test "create_car/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Motoring.create_car(@invalid_attrs)
    end

    test "update_car/2 with valid data updates the car" do
      car = car_fixture()
      assert {:ok, %Car{} = car} = Motoring.update_car(car, @update_attrs)
      assert car.charge_status == :charging
      assert car.vin == "1M8GDM9AXKP042788"
    end

    test "update_car/2 with invalid data returns error changeset" do
      car = car_fixture()
      assert {:error, %Ecto.Changeset{}} = Motoring.update_car(car, @invalid_attrs)
      assert car == Motoring.get_car!(car.id)
    end

    test "delete_car/1 deletes the car" do
      car = car_fixture()
      assert {:ok, %Car{}} = Motoring.delete_car(car)
      assert_raise Ecto.NoResultsError, fn -> Motoring.get_car!(car.id) end
    end

    test "change_car/1 returns a car changeset" do
      car = car_fixture()
      assert %Ecto.Changeset{} = Motoring.change_car(car)
    end
  end

  describe "drivers" do
    alias Vin.Motoring.Driver

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def driver_fixture(attrs \\ %{}) do
      {:ok, driver} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Motoring.create_driver()

      driver
    end

    test "list_drivers/0 returns all drivers" do
      driver = driver_fixture()
      assert Motoring.list_drivers() == [driver]
    end

    test "get_driver!/1 returns the driver with given id" do
      driver = driver_fixture()
      assert Motoring.get_driver!(driver.id) == driver
    end

    test "create_driver/1 with valid data creates a driver" do
      assert {:ok, %Driver{} = driver} = Motoring.create_driver(@valid_attrs)
      assert driver.name == "some name"
    end

    test "create_driver/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Motoring.create_driver(@invalid_attrs)
    end

    test "update_driver/2 with valid data updates the driver" do
      driver = driver_fixture()
      assert {:ok, %Driver{} = driver} = Motoring.update_driver(driver, @update_attrs)
      assert driver.name == "some updated name"
    end

    test "update_driver/2 with invalid data returns error changeset" do
      driver = driver_fixture()
      assert {:error, %Ecto.Changeset{}} = Motoring.update_driver(driver, @invalid_attrs)
      assert driver == Motoring.get_driver!(driver.id)
    end

    test "delete_driver/1 deletes the driver" do
      driver = driver_fixture()
      assert {:ok, %Driver{}} = Motoring.delete_driver(driver)
      assert_raise Ecto.NoResultsError, fn -> Motoring.get_driver!(driver.id) end
    end

    test "change_driver/1 returns a driver changeset" do
      driver = driver_fixture()
      assert %Ecto.Changeset{} = Motoring.change_driver(driver)
    end
  end
end
