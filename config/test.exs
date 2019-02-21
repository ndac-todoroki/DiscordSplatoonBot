use Mix.Config

# Print only warnings and errors during test
config :logger, level: :warn

# Goth is used inside of Kane, and needs to read Google credentials
config :goth,
  json: "google_json_creds/discord_splatoon_bot.json" |> Path.expand(__DIR__) |> File.read!()

# Discord Bot Settings
config :nostrum,
  # The token of your bot as a string
  token: "MzQzNTg3OTExNTQwNjcwNDc0.D0wNSQ.bveLr_nVBkn2kk-3ua-wHEZLH44",
  # The number of shards you want to run your bot under, or :auto.
  num_shards: :auto,
  bot_id: 0
