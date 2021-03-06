defmodule Airport.Arrival.ScheduleSubscriber.Endpoint do
  use Plug.Router
  require Logger

  alias GCPPS.Message

  plug Plug.Logger
  # NOTE: The line below is only necessary if you care about parsing JSON
  plug Plug.Parsers, parsers: [:json], json_decoder: Jason
  plug :match
  plug :dispatch

  ## Endpoints

  post "/" do
    conn.body_params
    |> GCPPS.Message.from_request!(parse_options())
    |> bot_speak()

    # if no error occured
    send_resp(conn, 200, "OK")
  end

  defp bot_speak(%Message{
         data: %Message.SchedulesData{} = data
       }) do
    data.command
    |> case do
      "news:latest" ->
        opts = []
        Command.News.latest(data.channel_id, opts)

      "work:start" ->
        opts = []
        Command.Notify.work_starts_batch()

      "work:end" ->
        opts = []
        Command.Notify.work_ends_batch()
    end
  end

  # option keyword list to pass to Message parser
  defp parse_options do
    [
      data_parser: &Message.SchedulesData.parse/1,
      attr_parser: &Message.Attributes.parse/1
    ]
  end
end
