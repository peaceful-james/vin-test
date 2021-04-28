use Mix.Config

# Configure your database
config :vin, Vin.Repo,
  username: System.get_env("VIN_DB_USER", System.get_env("USER", "postgres")),
  password: System.get_env("VIN_DB_PASSWORD", ""),
  database: "vin_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: System.get_env("VIN_DB_HOSTNAME", "localhost"),
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :vin, VinWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
