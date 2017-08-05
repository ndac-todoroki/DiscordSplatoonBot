defmodule DiscordSplatoonBot.Mixfile do
  use Mix.Project

  def project do
    [
      app: :discord_splatoon_bot,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.4",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {DiscordSplatoonBot, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      {:nostrum, git: "https://github.com/ndac-todoroki/nostrum.git", branch: "add_voice_state_update"},
      {:splatoon_data, in_umbrella: true},
    ]
  end
end
