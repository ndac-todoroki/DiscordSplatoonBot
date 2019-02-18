defmodule DiscordSplatoonBot.Command.Util do
  alias Nostrum.Api, as: API

  require Logger

  defmodule Help do
    defstruct [:title, :description, :fields]
  end

  def ping(msg) do
    API.create_message(msg.channel_id, "<@#{msg.author.id}> Pong")
  end

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
    `ブキランダム` | `メンバーランダム`

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
end
