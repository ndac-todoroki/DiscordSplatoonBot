defmodule Airport.MixProject do
  use Mix.Project

  def project do
    [
      app: :airport,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Airport.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:kane, "~> 0.4.0"},
      {:plug_cowboy, "~> 2.0"},
      {:plug, "~> 1.3"},
      {:jason, "~> 1.0"},
      {:simple_schema, "~> 1.1"},
      {:command, in_umbrella: true}
    ]
  end
end
