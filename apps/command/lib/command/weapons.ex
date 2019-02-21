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
        |> Enum.flat_map(fn
          %{user: %{bot: true}} -> []
          %{user: %{username: name}} -> [name]
        end)
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
          # footer: %Nostrum.Struct.Embed.Footer{icon_url: "", text: "Footer text"},
          # image: image,
          # thumbnail: thumbnail,
          # timestamp: DateTime.utc_now |> DateTime.to_unix |> to_string,
          title: "ブキランダム"
          # type: type,
          # url: url,
          # video: video
        }
      )
    else
      :error ->
        Command.Mention.Errors.not_in_voice_channel!(channel_id, author_id)
    end
  end

  def random_one(author_id, opts \\ []) when is_list(opts) do
    with {:ok, _dm_channel = %{id: dm_channel_id}} <- API.create_dm(author_id) do
      weapons = list(opts)

      API.create_message(
        dm_channel_id,
        weapons |> Enum.random()
      )
    else
      :error ->
        nil
        # Bot.Functions.ErrorMessages.not_in_voice_channel!(message)
    end
  end

  def list([]) do
    SplatoonData.Weapons.list_weapons(:all) |> Enum.map(& &1.name)
  end

  def list(opts) when is_list(opts) do
    SplatoonData.Weapons.list_weapons(opts) |> Enum.map(& &1.name)
  end
end
