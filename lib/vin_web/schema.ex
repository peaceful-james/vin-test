defmodule VinWeb.Schema do
  use Absinthe.Schema
  alias VinWeb.Schema.Middleware

  import_types(__MODULE__.Motoring.CarTypes)
  import_types(__MODULE__.Motoring.DriverTypes)

  @desc "An error encountered trying to persist input"
  object :input_error do
    field(:key, non_null(:string))
    field(:message, non_null(:string))
  end

  def middleware(middleware, field, object) do
    middleware
    |> apply(:errors, field, object)
  end

  defp apply(middleware, :errors, _field, %{identifier: :mutation}) do
    middleware ++ [Middleware.ChangesetErrors, Middleware.BinaryListErrors]
  end

  defp apply(middleware, _, _, _) do
    middleware
  end

  def data, do: Dataloader.Ecto.new(Vin.Repo, query: &data_query/2)
  def data_query(queryable, _params), do: queryable

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Vin.Motoring, data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  query do
    import_fields(:driver_queries)
  end

  mutation do
    import_fields(:car_mutations)
    import_fields(:driver_mutations)
  end
end
