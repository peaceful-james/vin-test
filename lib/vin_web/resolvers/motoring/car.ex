defmodule VinWeb.Resolvers.Motoring.Car do
  alias Vin.Motoring

  def create_car(_, %{input: params}, _) do
    case Motoring.create_car(params) do
      {:ok, car} -> {:ok, %{car: car}}
      anything -> anything
    end
  end

  def delete_car(_, %{id: id}, _) do
    case Motoring.get_car(id) do
      nil ->
        {:error, "No such car"}

      car ->
        case Motoring.delete_car(car) do
          {:ok, _deleted_car} -> {:ok, %{car: car}}
          anything -> anything
        end
    end
  end
end
