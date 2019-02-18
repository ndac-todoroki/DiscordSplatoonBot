defmodule SplatoonData.Application do
  @moduledoc """
  The SplatoonData Application Service.

  The splatoon_data system business domain lives in this application.

  Exposes API to clients such as the `SplatoonDataWeb` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link(
      [
        supervisor(SplatoonData.Repo, [])
      ],
      strategy: :one_for_one,
      name: SplatoonData.Supervisor
    )
  end
end
