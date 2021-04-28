defmodule VinWeb.Schema.Motoring.CarTypes do
  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers

  alias VinWeb.Resolvers.Motoring.Car

  object :car do
    field(:id, :id)
    field(:vin, :string)
    field(:charge_status, :charge_status)
    field(:driver, :driver, resolve: dataloader(Vin.Motoring))
  end

  enum :charge_status do
    value(:disconnected)
    value(:plugged_in)
    value(:charging)
  end

  input_object :create_car_input do
    field(:vin, :string)
    field(:charge_status, :charge_status)
    field(:driver_id, :id)
  end

  object :car_result do
    field :errors, list_of(:input_error)
    field :car, :car
  end

  object :car_mutations do
    @desc "create a car"
    field :create_car, type: :car_result do
      arg(:input, non_null(:create_car_input))

      resolve(&Car.create_car/3)
    end

    @desc "delete a car"
    field :delete_car, type: :car_result do
      arg(:id, non_null(:id))

      resolve(&Car.delete_car/3)
    end
  end
end
