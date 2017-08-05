defmodule DiscordSplatoonBot.Command do
  alias DiscordSplatoonBot.Command.{Util, Splatoon}

  @bot_id Application.fetch_env!(:nostrum, :bot_id)

  defp actionable_command?(msg) do
    msg.author.id != @bot_id
  end

  def handle(msg) do
    if actionable_command?(msg) do  
      msg.content
      |> String.trim
      |> String.split
      |> execute(msg)
    end
  end

  @doc """
  "？ブキランダム" の体を取るものはヘルプ表示
  """
  def execute(["？" <> method], msg) do
    Util.help(msg, method)
  end

  def execute(["ping"], msg) do
    Util.ping(msg)
  end
  
  def execute(["ブキランダム"], msg) do
    Splatoon.random_weapons(msg)
  end

  def execute(["ブキランダム", options], msg) do
    
  end

end
