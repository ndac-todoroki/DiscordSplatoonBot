defmodule Airport.Arrival.Subscriber.PubSubEndpoint do
  @moduledoc """
  Endpoints for GCP Pub/Sub using App Engine.
  """

  use Plug.Router
  require Logger

  alias Airport.Arrival

  plug Plug.Logger
  plug :match
  plug :dispatch

  def init(options) do
    options
  end

  # Base Routing
  forward "/schedules", to: Arrival.ScheduleSubscriber.Endpoint

  match "/" do
    send_resp(conn, 200, "gcp p/s")
  end
end
