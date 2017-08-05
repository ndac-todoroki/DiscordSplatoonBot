defmodule DiscordSplatoonBot.Command do
  alias DiscordSplatoonBot.Command.Util

  @bot_id Application.fetch_env!(:nostrum, :bot_id)

  defp actionable_command?(msg) do
    msg.author.id != @bot_id
  end

  def handle(msg) do
    if actionable_command?(msg) do  
      msg.content
      |> String.trim
      |> String.split
      |> tl
      |> execute(msg)
    end
  end

  def execute(["h", method], msg) do
    Util.help(msg, method)
  end

  def execute(["ping"], msg) do
    Util.ping(msg)
  end

  def execute(["i", to_eval], msg) do
    Util.inspect(msg, to_eval)
  end

end
