defmodule DiscordSplatoonBot.Command do
  alias Command.{Util, Weapons, Guild, News, Schedule}

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

  def execute(["？" <> method | args], msg) do
    Util.help(msg, method, args)
  end

  def execute([@reply_prefix, "help"], msg), do: Util.help(msg, "help")
  def execute([@reply_prefix | []], msg), do: Util.help(msg, "ヘルプ")

  def execute([@reply_prefix, "ping"], msg) do
    Util.ping(msg)
  end

  def execute(["ブキランダム" | options], msg) do
    Weapons.random_all(msg.channel_id, msg.author.id, options)
  end

  def execute(["ブキラン１" | options], msg) do
    if msg.guild_id,
      do: Weapons.random_one(msg.channel_id, msg.author.id, options),
      else: Weapons.dm_random_one(msg.channel_id, options)
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

  def execute(["スケジュール", "作成", "ハイカラニュース" | options], msg) do
    Schedule.latest_news(msg.channel_id, msg.id, msg.guild_id, options)
  end

  def execute(["スケジュール", "作成", _other | options], msg) do
    Schedule.not_yet_error(msg.channel_id)
  end

  def execute(["スケジュール", "削除", id | _], msg) do
    Schedule.delete(msg.channel_id, id, msg.guild_id)
  end

  def execute(_, _) do
    :noop
  end
end
