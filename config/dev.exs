use Mix.Config

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Goth is used inside of Kane, and needs to read Google credentials
config :goth,
  json: "google_json_creds/discord_splatoon_bot.json" |> Path.expand(__DIR__) |> File.read!()

# Discord Bot Settings
config :nostrum,
  # The token of your bot as a string
  token: "NTU3MDM4ODkxMzI1MDYzMTY5.D3CfBQ.nMWiRQ5FBkKQ2ybGiYOQZiuqC8M",
  # The number of shards you want to run your bot under, or :auto.
  num_shards: :auto,
  bot_id: 557_038_891_325_063_169
