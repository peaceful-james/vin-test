defmodule VinWeb.Schema.CarTest do
  use VinWeb.ConnCase, async: true
  import Vin.MotoringFixtures

  test "creating a car", %{conn: conn} do
    driver_name = "Sonic Gofast"
    driver = driver_fixture(%{name: driver_name})

    response =
      post conn, "/api", %{
        query: """
        mutation createCarMutation($createCarInput: CreateCarInput!){
          car: createCar(input: $createCarInput) {
            errors {
              key
              message
            }
            car {
              id
              vin
              chargeStatus
              driver {
                name
              }
            }
          }
        }
        """,
        variables: %{
          "createCarInput" => %{
            "vin" => "1111111111",
            "chargeStatus" => "DISCONNECTED",
            "driverId" => driver.id
          }
        }
      }

    assert %{"data" => %{"car" => %{"car" => car_data}}} =
             json_response(response, 200)
             |> IO.inspect()

    assert %{
             "id" => _car_id,
             "vin" => "1111111111",
             "chargeStatus" => "disconnected",
             "driver" => %{
               "name" => ^driver_name
             }
           } = car_data
  end

  test "deleting a car", %{conn: conn} do
    car = car_fixture()

    response =
      post conn, "/api", %{
        query: """
        mutation deleteCarMutation($id: ID!){
          car: deleteCar(id: $id) {
            errors {
              key
              message
            }
            car {
              id
            }
          }
        }
        """,
        variables: %{
          "id" => car.id
        }
      }

    assert %{"data" => %{"car" => %{"car" => car_data}}} =
             json_response(response, 200)
             |> IO.inspect()

    assert %{"id" => _car_id} = car_data
  end
end
