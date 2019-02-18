use Mix.Config

config :splatoon_data, ecto_repos: [SplatoonData.Repo]

import_config "#{Mix.env()}.exs"
