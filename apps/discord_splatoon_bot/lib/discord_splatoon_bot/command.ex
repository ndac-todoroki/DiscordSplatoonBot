defmodule DiscordSplatoonBot.Command do
  alias Command.{Util, Weapons, Guild, News}

  @bot_id Application.fetch_env!(:nostrum, :bot_id)
  @reply_prefix "<@#{@bot_id}>"

  defp actionable_command?(msg) do
    msg.author.id != @bot_id
  end

  def handle(msg) do
    if actionable_command?(msg) do
      msg.content
      |> String.trim()
      |> String.split()
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
    Weapons.random_all(msg.channel_id, msg.author.id, options)
  end

  def execute([@reply_prefix | ["ブキランダム" | options]], msg) do
    Weapons.random_one(msg.author.id, options)
  end

  def execute(["メンバーランダム" | options], msg) do
    Guild.random_members(msg.channel_id, msg.author.id, options)
  end

  def execute(["ハイカラニュース" | options], msg) do
    News.latest(msg.channel_id, options)
  end

  def execute(["ナワバリ情報" | options], msg) do
    News.regular(msg.channel_id, options)
  end

  def execute(["ガチマ情報" | options], msg) do
    News.gachi(msg.channel_id, options)
  end

  def execute(["リグマ情報" | options], msg) do
    News.league(msg.channel_id, options)
  end

  def execute(["バイト情報" | options], msg) do
    News.salmon(msg.channel_id, options)
  end

  def execute(_, _) do
    :noop
  end
end
