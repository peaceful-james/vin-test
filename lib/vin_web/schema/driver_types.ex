defmodule VinWeb.Schema.DriverTypes do
  use Absinthe.Schema.Notation

  alias VinWeb.Resolvers

  object :driver do
    field(:id, :id)
    field(:name, :string)

    field(:cars, list_of(:car)) do
      resolve(&Resolvers.Drivers.cars/3)
    end
  end

  object :car do
    field(:id, :id)
    field(:vin, :string)
    field(:charge_status, :charge_status)
  end

  enum :charge_status do
    value(:disconnected, as: "disconnected")
    value(:plugged_in, as: "plugged_in")
    value(:charging, as: "charging")
  end
end
