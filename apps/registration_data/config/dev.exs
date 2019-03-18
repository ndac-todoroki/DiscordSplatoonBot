use Mix.Config

config :registration_data, RegistrationData.Repo,
  database: "registration_data_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool_size: 10
