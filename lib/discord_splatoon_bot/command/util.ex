defmodule DiscordSplatoonBot.Command.Util do
  alias Nostrum.Api, as: API

  require Logger

  def ping(msg) do
    API.create_message(msg.channel_id, "Pong")
  end

  # "？ブキランダム" みたいなやつを対象にしよう
  def help(_msg, method) do
    method
    |> get_docs
    #|> print_docs
  end
end