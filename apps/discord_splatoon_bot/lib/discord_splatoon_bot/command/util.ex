defmodule DiscordSplatoonBot.Command.Util do
  alias Nostrum.Api, as: API

  require Logger

  def ping(msg) do
    API.create_message(msg.channel_id, "<@#{msg.author.id}> Pong")
  end

  def help(msg, "ヘルプ") do
    help = """
    SplatoonBot created by twitter:@ndac_todoroki

    **主なコマンド / main commands:**
    - `ブキランダム`
    - `メンバーランダム`

    コマンドの前に `？` をつけるとコマンドのヘルプになります ex. `？ブキランダム`
    """
  end

  # "？ブキランダム" みたいなやつを対象にしよう
  def help(msg, "ブキランダム") do
    help = """
    __**【ブキランダム】**__
    **使いかた）**
      `ブキランダム　（[オプション ...]　[限定句]　[オプション ...]　[限定句]...）`
    **説明）**
      「コマンドを打った人が参加している通話」に参加している人(Bot以外)を対象に、
      ランダムでブキを割り振ります。`ブキランダム`のみでは全ブキからランダムになります。
      オプションにはブキの種類、ジャンル、購入可能レベルなどを指定することができ、
      「のみ」「以外」「以前」「以降」といった限定句をあとに続けることで絞り込みます。
    **例）**
      `ブキランダム　シューター　以外`
      `ブキランダム　ヒーロー　のみ　ローラー　フデ　以外`
    """

    API.create_message(msg.channel_id, help)
  end
end