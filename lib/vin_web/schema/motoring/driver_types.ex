defmodule VinWeb.Schema.Motoring.DriverTypes do
  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers

  alias VinWeb.Resolvers.Motoring.Driver

  object :driver do
    field(:id, :id)
    field(:name, :string)

    field(:cars, list_of(:car), resolve: dataloader(Vin.Motoring))
  end

  input_object :create_driver_input do
    field(:name, non_null(:string))
  end

  object :driver_result do
    field(:errors, list_of(:input_error))
    field(:driver, :driver)
  end

  object :driver_queries do
    @desc "list all drivers"
    field :drivers, list_of(:driver) do
      resolve(&Driver.list_drivers/3)
    end

    @desc "get a driver by id"
    field :driver, :driver do
      arg(:id, non_null(:id))
      resolve(&Driver.get_driver/3)
    end
  end

  object :driver_mutations do
    @desc "create a driver"
    field :create_driver, type: :driver_result do
      arg(:input, non_null(:create_driver_input))
      resolve(&Driver.create_driver/3)
    end
  end
end
