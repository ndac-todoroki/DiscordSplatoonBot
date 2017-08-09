defmodule DiscordSplatoonBot.Command do
  alias DiscordSplatoonBot.Command.{Util, Splatoon, Guild}

  @bot_id Application.fetch_env!(:nostrum, :bot_id)
  @reply_prefix "<@#{@bot_id}>"

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

  def execute([@reply_prefix, "help"], msg), do: Util.help(msg, "help")
  def execute([@reply_prefix | []], msg), do: Util.help(msg, "ヘルプ")

  def execute([@reply_prefix, "ping"], msg) do
    Util.ping(msg)
  end

  def execute(["ブキランダム" | options], msg) do
    Splatoon.random_weapons(msg, options)
  end

  def execute([@reply_prefix | ["ブキランダム" | options]], msg) do
    Splatoon.random_weapon_one(msg, options)
  end

  def execute(["メンバーランダム" | options], msg) do
    Guild.random_members(msg, options)
  end

end
