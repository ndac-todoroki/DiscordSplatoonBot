use Mix.Config

# Configure your database
config :splatoon_data, SplatoonData.Repo,
  username: "postgres",
  password: "postgres",
  database: "splatoon_data_dev",
  hostname: "localhost",
  pool_size: 10
