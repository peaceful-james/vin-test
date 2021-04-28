defmodule VinWeb.Schema do
  use Absinthe.Schema
  import_types(VinWeb.Schema.DriverTypes)

  alias VinWeb.Resolvers

  query do
    @desc "list all drivers"
    field :drivers, list_of(:driver) do
      resolve(&Resolvers.Drivers.list_drivers/3)
    end

    @desc "get a driver by id"
    field :driver, :driver do
      arg(:id, non_null(:id))

      resolve(&Resolvers.Drivers.get_driver/3)
    end
  end

  mutation do
    @desc "create a driver"
    field :create_driver, type: :driver do
      arg(:name, non_null(:string))

      resolve(&Resolvers.Drivers.create_driver/3)
    end

    @desc "create a car"
    field :create_car, type: :car do
      arg(:driver_id, :id)
      arg(:vin, :string)

      resolve(&Resolvers.Drivers.create_car/3)
    end

    @desc "delete a car"
    field :delete_car, type: :driver do
      arg(:driver_id, non_null(:id))
      arg(:id, non_null(:id))

      resolve(&Resolvers.Drivers.delete_car/3)
    end
  end
end
