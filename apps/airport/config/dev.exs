use Mix.Config

# Goth is used inside of Kane, and needs to read Google credentials
config :goth,
  json: "google_json_creds/discord_splatoon_bot.json" |> Path.expand(__DIR__) |> File.read!()
