defmodule VinWeb.Resolvers.Motoring.Driver do
  alias Vin.Motoring
  alias Vin.Motoring.Driver

  import Absinthe.Resolution.Helpers, only: [on_load: 2]

  def get_driver(_, %{id: id}, %{context: %{loader: loader}}) do
    loader
    |> Dataloader.load(Motoring, Driver, id)
    |> on_load(fn loader ->
      {:ok, Dataloader.get(loader, Motoring, Driver, id)}
    end)
  end

  def create_driver(_, %{input: params}, _) do
    case Motoring.create_driver(params) do
      {:ok, driver} -> {:ok, %{driver: driver}}
      anything -> anything
    end
  end

  def list_drivers(_, _, _) do
    {:ok, Motoring.list_drivers()}
  end
end
