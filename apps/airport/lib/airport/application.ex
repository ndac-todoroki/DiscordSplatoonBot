defmodule Airport.Application do
  @moduledoc "The main OTP application for Airport"

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # List all child processes to be supervised
    children = [
      worker(Airport.Arrival.Subscriber.Endpoint, [])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Airport.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
