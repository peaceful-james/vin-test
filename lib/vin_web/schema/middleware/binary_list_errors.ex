defmodule VinWeb.Schema.Middleware.BinaryListErrors do
  @behaviour Absinthe.Middleware

  @doc """
  Moves "binary list" errors from the :errors property to the :value property.
  This prevents them "bubbling up", in ways we might have to control.
  It particularly is a safeguard against the user seeing them.
  """
  def call(res, _) do
    case res do
      %{errors: errors} when is_list(errors) ->
        if Enum.any?(errors) and Enum.all?(errors, &is_binary/1) do
          error_messages =
            errors
            |> Enum.with_index()
            |> Enum.map(fn {message, index} ->
            %{key: "error #{index}", message: message}
          end)

            %{res | value: %{errors: error_messages}, errors: []}
        else
          res
        end

      _ ->
        res
    end
  end
end
