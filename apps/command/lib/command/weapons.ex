defmodule Command.Weapons do
  alias Nostrum.Api, as: API

  def random_all(channel_id, author_id, opts \\ []) when is_list(opts) do
    with {:ok, channel = %{guild_id: guild_id}} <- API.get_channel(channel_id),
         {:ok, server} <- Nostrum.Cache.GuildCache.get(guild_id),
         {:ok, voice_channel_id} <-
           DiscordSplatoonBot.Util.get_voice_channel_id(server, author_id) do
      me = self()
      weapons = list(opts)

      fields =
        server.voice_states
        |> Enum.filter(fn map -> map.channel_id == voice_channel_id end)
        |> Enum.map(fn voice_state ->
          {:ok, member} = API.get_guild_member(guild_id, voice_state.user_id)

          spawn_link(fn ->
            send(me, {member})
          end)
        end)
        |> Enum.map(fn _pid ->
          receive do
            {result} -> result
          end
        end)
        |> Enum.reject(fn %{user: %{bot: bot?}} -> bot? end)
        |> Enum.map(fn %{nick: nickname, user: %{username: name}} -> nickname || name end)
        |> Enum.map(fn username ->
          spawn_link(fn ->
            field = %Nostrum.Struct.Embed.Field{
              inline: true,
              name: username,
              value: weapons |> Enum.random()
            }

            send(me, {field})
          end)
        end)
        |> Enum.map(fn _pid ->
          receive do
            {result} -> result
          end
        end)

      API.create_message(channel_id,
        content: nil,
        embed: %Nostrum.Struct.Embed{
          # author: author,
          color: 0x13579A,
          description: opts |> Enum.join(" "),
          fields: fields,
          title: "ブキランダム"
        }
      )
    else
      :error ->
        Command.Mention.Errors.not_in_voice_channel!(channel_id, author_id)
    end
  end

  def random_one(channel_id, author_id, opts \\ []) when is_list(opts) do
    weapons = list(opts)
    weapon_name = weapons |> Enum.random()

    API.create_message(
      channel_id,
      content: "<@!#{author_id}> #{weapon_name}"
    )
  end

  def dm_random_one(channel_id, opts \\ []) when is_list(opts) do
    weapons = list(opts)
    weapon_name = weapons |> Enum.random()

    API.create_message(
      channel_id,
      content: weapon_name,
      embed: %Nostrum.Struct.Embed{
        image: %{
          url: "https://wikiwiki.jp/splatoon2mix/?plugin=ref&page=ブキ&src=メイン-#{weapon_name}.png"
        }
      }
    )
  end

  def list([]) do
    SplatoonData.Weapons.list_weapons(:all) |> Enum.map(& &1.name)
  end

  def list(opts) when is_list(opts) do
    SplatoonData.Weapons.list_weapons(opts) |> Enum.map(& &1.name)
  end
end
