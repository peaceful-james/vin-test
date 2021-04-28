# Vin

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

## Your Task

When you visit http://localhost:4000/, you should be redirected to a GraphQL
query interface.

The interface describes two entities:

* driver
* car

A driver has a name, and may have many cars. A car has a VIN as well as a
charging status. Right now, the API is stubbed, and will return some dummy data.
Try the following query:

```graphql
{
  drivers {
    id
    name
    cars {
      id
      vin
      chargeStatus
    }
  }
}
```

The API also includes some mutations:

* createDriver
* createCar
* deleteCar

Your task is to replace the static, dummy implementation with an interactive
implementation that can be used to demonstrate the API.

Additionally, each car's VIN should be checked for validity according to the
check digit calculation documented below:

https://en.wikipedia.org/wiki/Vehicle_identification_number#Check-digit_calculation

<!-- TODO @peaceful-james ask about -->
1. why delete_car mutation had driver_id input?
2. can I use Postgres?
3. should cars - drivers actually be many-to-many with a join table?
