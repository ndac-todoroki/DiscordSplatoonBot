defmodule Command.MixProject do
  use Mix.Project

  def project do
    [
      app: :command,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:nostrum, git: "https://github.com/ndac-todoroki/nostrum.git", branch: "develop"},
      {:splatoon_data, in_umbrella: true},
      {:registration_data, in_umbrella: true},
      {:spla2_api, in_umbrella: true},
      {:scheduler, in_umbrella: true}
    ]
  end
end
