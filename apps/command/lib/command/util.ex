defmodule Command.Util do
  @moduledoc """
  TODO: ヘルプに関してはマクロを使って@アトリビュートから取得するようにしたい
  """

  alias Nostrum.Api, as: API

  require Logger

  defmodule Help do
    defstruct [:title, :description, :fields]
  end

  def ping(msg) do
    API.create_message(msg.channel_id, "<@#{msg.author.id}> Pong")
  end

  def set_nickname(channel_id, nickname),
    do: API.request(:patch, Nostrum.Constants.guild_me_nick(channel_id), %{nick: nickname})

  # do: API.modify_current_user_nick(channel_id, nick: nickname)

  def help(msg, "ヘルプ") do
    desc = """
    SplatoonBot for Discord; プライベートマッチを便利にするツール
      created by U-dory/Todoroki twitter:@ndac_todoroki
    """

    fields =
      [
        %{
          title: "主なコマンド",
          text: """
          - `ブキランダム`
          - `メンバーランダム`
          すべてのコマンドを見るには `？コマンド` と打ってください。

          また、`？<コマンド名>` でそのコマンドのヘルプを見ることができます。 例: `？ブキランダム`
          """
        },
        %{
          title: "for English users",
          text: "Type `？help` for English help. Note that `？` isn't an ASCII letter `?`."
        }
      ]
      |> Enum.map(&create_embed_field/1)

    create_embeded_help(%Help{
      title: "ヘルプ",
      description: desc,
      fields: fields
    })
    |> send_embeded_help_message(msg.channel_id)
  end

  def help(msg, "help") do
    desc = """
    SplatoonBot for Discord; Enhance your team's private matches!
      created by U-dory/Todoroki twitter:@ndac_todoroki
    """

    fields =
      [
        %{
          title: "DISCLAMER",
          text: """
          This bot is currently mainly available in Japanese only.
          If you will to, please help me develop this Bot (including multi-language support), at [Github](https://github.com/ndac-todoroki/DiscordSplatoonBot).
          Just discussing is hyper-welcome!
          """
        },
        %{
          title: "Popular Commands",
          text: """
          - `ブキランダム`
          Type `？コマンド` to see all available commands.

          You can also request command-specific help by typing `？<command_name>`. ex: `？ブキランダム`
          """
        },
        %{
          title: "日本語ユーザーへ",
          text: "日本語のヘルプは `？ヘルプ` で見てください"
        }
      ]
      |> Enum.map(&create_embed_field/1)

    create_embeded_help(%Help{
      title: "SpatoonBot Help",
      description: desc,
      fields: fields
    })
    |> send_embeded_help_message(msg.channel_id)
  end

  def help(msg, "コマンド") do
    desc = """
    `ブキランダム` | `メンバーランダム` | `ハイカラニュース` | `ナワバリ情報` | `ガチマ情報` | `リグマ情報` | `バイト情報`

    `？<コマンド名>` でヘルプを表示できます。 例: `？ブキランダム`
    """

    create_embeded_help(%Help{
      title: "コマンド一覧",
      description: desc
    })
    |> send_embeded_help_message(msg.channel_id)
  end

  # "？ブキランダム" みたいなやつを対象にしよう
  def help(msg, "ブキランダム") do
    desc = """
    「コマンドを打った人が参加している通話」に参加している人(Bot以外)を対象に、ランダムでブキを割り振ります。`ブキランダム`のみでは全ブキからランダムになります。
    オプションにはブキの種類、ジャンル、購入可能レベルなどを指定することができ、「のみ」「以外」「以前」「以降」といった限定句をあとに続けることで絞り込みます。
    """

    fields =
      [
        %{
          title: "使いかた",
          text: "`ブキランダム　（[オプション ...]　[限定句]　[オプション ...]　[限定句]...）`"
        },
        %{
          title: "例",
          text: """
          `ブキランダム　シューター　以外`
          `ブキランダム　ヒーロー　のみ　ローラー　フデ　以外`
          `ブキランダム　ヒッセン　以外　25　以下`
          """
        }
      ]
      |> Enum.map(&create_embed_field/1)

    create_embeded_help(%Help{
      title: "ブキランダム",
      description: desc,
      fields: fields
    })
    |> send_embeded_help_message(msg.channel_id)
  end

  def help(msg, "メンバーランダム") do
    desc = """
    「コマンドを打った人が参加している通話」に参加している人(Bot以外)からランダムで誰かを選びます。
    数字を指定するとその人数ランダムで選びます。何も指定しなければ `1` と同じになります。
    """

    fields =
      [
        %{
          title: "使いかた",
          text: "`メンバーランダム　（半角数字）`"
        },
        %{
          title: "例",
          text: """
          `メンバーランダム`
          `メンバーランダム　3`
          """
        }
      ]
      |> Enum.map(&create_embed_field/1)

    create_embeded_help(%Help{
      title: "ブキランダム",
      description: desc,
      fields: fields
    })
    |> send_embeded_help_message(msg.channel_id)
  end

  def help(msg, "ハイカラニュース") do
    desc = """
    今のステージ情報をお知らせします。ハイカラニュースと中身は同じです。
    """

    fields =
      [
        %{
          title: "使いかた",
          text: "`ハイカラニュース`"
        }
      ]
      |> Enum.map(&create_embed_field/1)

    create_embeded_help(%Help{
      title: "ハイカラニュース",
      description: desc,
      fields: fields
    })
    |> send_embeded_help_message(msg.channel_id)
  end

  def help(msg, "ナワバリ情報") do
    desc = """
    今のステージを含め、３件のナワバリバトルのステージ情報をお知らせします。
    """

    fields =
      [
        %{
          title: "使いかた",
          text: "`ナワバリ情報`"
        }
      ]
      |> Enum.map(&create_embed_field/1)

    create_embeded_help(%Help{
      title: "ナワバリ情報",
      description: desc,
      fields: fields
    })
    |> send_embeded_help_message(msg.channel_id)
  end

  def help(msg, "ガチマ情報") do
    desc = """
    現在開催中のものを含めて３つ先までのガチマッチのステージ情報をお知らせします。
    """

    fields =
      [
        %{
          title: "使いかた",
          text: "`ガチマ情報`"
        }
      ]
      |> Enum.map(&create_embed_field/1)

    create_embeded_help(%Help{
      title: "ガチマ情報",
      description: desc,
      fields: fields
    })
    |> send_embeded_help_message(msg.channel_id)
  end

  def help(msg, "リグマ情報") do
    desc = """
    現在開催中のものを含めて３つ先までのリーグマッチのステージ情報をお知らせします。
    """

    fields =
      [
        %{
          title: "使いかた",
          text: "`リグマ情報`"
        }
      ]
      |> Enum.map(&create_embed_field/1)

    create_embeded_help(%Help{
      title: "リグマ情報",
      description: desc,
      fields: fields
    })
    |> send_embeded_help_message(msg.channel_id)
  end

  def help(msg, "バイト情報") do
    desc = """
    現在開催中のものを含めて２つ先までのサーモンランの情報をお知らせします。勤務地、及び支給ブキが表示されます。
    """

    fields =
      [
        %{
          title: "使いかた",
          text: "`バイト情報`"
        }
      ]
      |> Enum.map(&create_embed_field/1)

    create_embeded_help(%Help{
      title: "バイト情報",
      description: desc,
      fields: fields
    })
    |> send_embeded_help_message(msg.channel_id)
  end

  def help(msg, "スケジュール") do
    desc = """
    ある時刻や定期的な周期で `ハイカラニュース` などを自動的に発言させるためのスケジュールの作成をしたり、その削除をしたりできます。
    詳しい説明は「？スケジュール　作成」「？スケジュール　削除」で見ることができます。
    """

    fields =
      [
        %{
          title: "使いかた",
          text: """
          `スケジュール　作成　ハイカラニュース　* 1-23/2 * * *`
          `スケジュール　削除　548183915228168192`
          """
        }
      ]
      |> Enum.map(&create_embed_field/1)

    create_embeded_help(%Help{
      title: "スケジュール",
      description: desc,
      fields: fields
    })
    |> send_embeded_help_message(msg.channel_id)
  end

  def help(msg, "スケジュール作成") do
    desc = """
    定時、あるいは一定時間ごとにこのbotに自動発言させる設定をします。
    作成に成功した場合、そのスケジュールのIDをお知らせします。__スケジュールを削除する場合はそのIDを指定する必要があるのでメモしておいてください。__

    時刻や周期の設定は「unix-cron形式」「crontab形式」と呼ばれるもので指定します。
    詳しくはこの記事の「cronの書き方」に示してあります
    https://qiita.com/onomame/items/71646c5517a39bcd01cc#cron%E3%81%AE%E6%9B%B8%E3%81%8D%E6%96%B9
    """

    fields =
      [
        %{
          title: "使いかた",
          text: """
          _ # `ハイカラニュース`を毎日１時、３時、５時、…と２時間おきに呟かせる_
          **`スケジュール　作成　ハイカラニュース　* 1-23/2 * * *`**

          _ # 毎週月曜日の12:00、12:20、12:40に呟かせる_
          _ # 日曜日が`0`なので、月曜日は`1`_
          **`スケジュール　作成　ハイカラニュース　*/20 12 * * 1`**
          """
        },
        %{
          title: "unix-cron形式について",
          text: """
          分　時　日　月　曜日
          ＊　＊　＊　＊　＊

          `0 0 * * *`
          → 毎日深夜０時

          `* * * * *`
          → 毎分
          """
        }
      ]
      |> Enum.map(&create_embed_field/1)

    create_embeded_help(%Help{
      title: "スケジュール作成",
      description: desc,
      fields: fields
    })
    |> send_embeded_help_message(msg.channel_id)
  end

  def help(msg, "スケジュール削除") do
    desc = """
    作成したスケジュールを削除します。
    この操作には作成したときにお知らせしたIDが必要になります。
    """

    fields =
      [
        %{
          title: "使いかた",
          text: """
          _ # `548183915228168192`番スケジュールを削除_
          **`スケジュール　削除　548183915228168192`**
          """
        }
      ]
      |> Enum.map(&create_embed_field/1)

    create_embeded_help(%Help{
      title: "スケジュール削除",
      description: desc,
      fields: fields
    })
    |> send_embeded_help_message(msg.channel_id)
  end

  def help(msg, "スケジュール", [arg | _rest]) do
    arg
    |> String.trim()
    |> case do
      "作成" ->
        help(msg, "スケジュール作成")

      "削除" ->
        help(msg, "スケジュール削除")
    end
  end

  defp create_embed_field(%{title: title, text: text}, inline? \\ false) do
    %Nostrum.Struct.Embed.Field{
      inline: inline?,
      name: title,
      value: text
    }
  end

  defp create_embeded_help(h = %Help{}) do
    %Nostrum.Struct.Embed{
      color: 0x13579A,
      title: h.title,
      description: h.description,
      fields: h.fields
    }
  end

  defp send_embeded_help_message(embed = %Nostrum.Struct.Embed{}, channel_id) do
    API.create_message(channel_id,
      content: nil,
      embed: embed
    )
  end

  @doc """
  Returns the current voice channel of user, in the given server.
  Returns `:error` if one is not in a voice channel.

  ## Examples

      iex> DiscordSplatoonBot.Util.get_voice_channel_id(server, message.author.id)
      {:ok, 12346789}

  """
  @spec get_voice_channel_id(Nostrum.Struct.Guild.t(), integer) :: {:ok, integer} | :error
  def get_voice_channel_id(server, user_id) do
    server.voice_states
    |> Enum.find(%{}, fn map -> map.user_id == user_id end)
    |> Map.fetch(:channel_id)
    |> (fn
          {:ok, nil} -> :error
          other -> other
        end).()
  end
end
