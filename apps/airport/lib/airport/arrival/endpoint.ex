defmodule Airport.Arrival.Subscriber.Endpoint do
  @moduledoc """
  The root endpoint of the push subscriber.
  """

  # (System.get_env("PORT") || "8080") |> String.to_integer()
  @port 8080

  use Plug.Router
  use Plug.ErrorHandler
  require Logger

  alias Airport.Arrival

  plug Plug.Logger
  plug :match
  plug :dispatch

  def init(options) do
    options
  end

  def start_link do
    # FIXME: state port number in configs
    {:ok, _} = Plug.Cowboy.http(__MODULE__, [], port: @port)
  end

  # Base Routing
  forward "/_ah/push-handlers", to: Arrival.Subscriber.PubSubEndpoint

  match "/" do
    send_resp(conn, 200, "hello world")
  end

  # This can cause an injection attack, although for now it won't affect other pages.
  defp handle_errors(conn, %{kind: _kind, reason: reason, stack: stack} = error) do
    # call sentry first
    super(conn, error)

    Logger.error(inspect(reason))
    Logger.info(inspect(stack))

    send_resp(conn, conn.status, "Something went wrong")
  end
end
