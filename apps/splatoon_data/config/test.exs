use Mix.Config

# Configure your database
config :splatoon_data, SplatoonData.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "splatoon_data_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
