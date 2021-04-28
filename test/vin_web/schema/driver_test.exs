defmodule VinWeb.Schema.DriverTest do
  use VinWeb.ConnCase, async: true

  test "creating a driver", %{conn: conn} do
    response =
      post conn, "/api", %{
        query: """
        mutation createDriverMutation($createDriverInput: CreateDriverInput!){
          driver: createDriver(input: $createDriverInput) {
            errors {
              key
              message
            }
            driver {
              id
              name
            }
          }
        }
        """,
        variables: %{
          "createDriverInput" => %{
            "name" => "Example Driver"
          }
        }
      }

    assert %{"data" => %{"driver" => %{"driver" => driver_data}}} = json_response(response, 200)

    assert %{
             "id" => _driver_id,
             "name" => "Example Driver"
           } = driver_data
  end
end
