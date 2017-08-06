defmodule DiscordSplatoonBot.Command.Splatoon do
  alias Nostrum.Api, as: API

  def random_weapons(message, opts\\[]) when is_list(opts) do
    with \
      {:ok, channel = %{"guild_id" => guild_id_str}} <- API.get_channel(message.channel_id),
      guild_id <- guild_id_str |> String.to_integer,
      {:ok, server} <- Nostrum.Cache.Guild.GuildServer.get(id: guild_id),
      {:ok, voice_channel_id} <- server.voice_states
        |> Enum.find(%{}, fn(map) -> map.user_id == message.author.id end)
        |> Map.fetch(:channel_id)
    do
      me = self()
      weapons = list_weapons(opts)

      fields = 
        server.voice_states
        |> Enum.filter(fn(map) -> map.channel_id == voice_channel_id end)
        |> Enum.map(fn (voice_state) ->
          {:ok, member} = API.get_member(guild_id, voice_state.user_id)
          spawn_link fn ->
            (send me, {member})
          end
        end)
        |> Enum.map(fn (_pid) ->
          receive do { result } -> result end
        end)
        |> Enum.flat_map(fn
          %{"user" => %{"bot" => true}} -> []
          %{"user" => %{"username" => name}} -> [name]
        end)
        |> Enum.map(fn(username) ->
          field = %Nostrum.Struct.Embed.Field{
            inline: true,
            name: username,
            value: weapons |> Enum.random
          }
          spawn_link fn ->
            (send me, {field})
          end
        end)
        |> Enum.map(fn (_pid) ->
          receive do { result } -> result end
        end)

      API.create_message(message.channel_id, [
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
          title: "ブキランダム",
          # type: type,
          # url: url,
          # video: video
        }
      ])
    else
      :error -> 
        Bot.Functions.ErrorMessages.not_in_voice_channel!(message)
    end
  end

  def list_weapons([]) do
    SplatoonData.Weapons.list_weapons(:all) |> Enum.map(&(&1.name))
  end

  def list_weapons(opts) when is_list(opts) do
    SplatoonData.Weapons.list_weapons(opts) |> Enum.map(&(&1.name))
  end
end