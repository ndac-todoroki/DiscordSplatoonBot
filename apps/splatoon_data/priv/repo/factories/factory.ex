defmodule SplatoonData.Repo.Factory do
  # with Ecto
  use ExMachina.Ecto, repo: SplatoonData.Repo

  use SplatoonData.Repo.Factories.Weapons
end