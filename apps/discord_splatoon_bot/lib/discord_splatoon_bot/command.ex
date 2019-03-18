defmodule DiscordSplatoonBot.Command do
  alias Command.{Util, Weapons, Guild, News, Schedule}

  @bot_id Application.fetch_env!(:nostrum, :bot_id)
  @reply_prefix "<@#{@bot_id}>"
  @reply_nickname_prefix "<@!#{@bot_id}>"

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
  def execute(["？" <> method], msg), do: Util.help(msg, method)
  def execute(["？" <> method | args], msg), do: Util.help(msg, method, args)

  def execute([@reply_prefix | tail], msg), do: reply_execute(tail, msg)
  def execute([@reply_nickname_prefix | tail], msg), do: reply_execute(tail, msg)

  def execute(["ブキランダム" | options], msg),
    do: Weapons.random_all(msg.channel_id, msg.author.id, options)

  def execute(["ブキラン１" | options], msg) do
    if msg.guild_id,
      do: Weapons.random_one(msg.channel_id, msg.author.id, options),
      else: Weapons.dm_random_one(msg.channel_id, options)
  end

  def execute(["メンバーランダム" | options], msg),
    do: Guild.random_members(msg.channel_id, msg.author.id, options)

  def execute(["ハイカラニュース" | options], msg), do: News.latest(msg.channel_id, options)

  def execute(["ナワバリ情報" | options], msg), do: News.regular(msg.channel_id, options)

  def execute(["ガチマ情報" | options], msg), do: News.gachi(msg.channel_id, options)

  def execute(["リグマ情報" | options], msg), do: News.league(msg.channel_id, options)

  def execute(["バイト情報" | options], msg), do: News.salmon(msg.channel_id, options)

  def execute(["スケジュール", "作成", "ハイカラニュース" | options], msg),
    do: Schedule.latest_news(msg.channel_id, msg.id, msg.guild_id, options)

  def execute(["スケジュール", "作成", _other | options], msg), do: Schedule.not_yet_error(msg.channel_id)

  def execute(["スケジュール", "削除", id | _], msg),
    do: Schedule.delete(msg.channel_id, id, msg.guild_id)

  def execute(["通知", "登録", "バイト開始" | options], msg),
    do: Schedule.register(:work_start, msg.channel_id, options)

  def execute(["通知", "解除", "バイト開始" | options], msg),
    do: Schedule.unregister(:work_start, msg.channel_id, options)

  def execute(_, _), do: :noop

  def reply_execute(["help"], msg), do: Util.help(msg, "help")
  def reply_execute([], msg), do: Util.help(msg, "ヘルプ")
  def reply_execute(["ping"], msg), do: Util.ping(msg)

  def reply_execute(["あだな", nickname], msg),
    do: Util.set_nickname(msg.channel_id, nickname)

  def reply_execute(_, _), do: :noop
end
