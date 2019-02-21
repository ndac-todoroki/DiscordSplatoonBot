defmodule Command.Guild do
  alias Nostrum.Api, as: API
  require Logger

  def random_members(message, []), do: random_members(message, ["1"])

  def random_members(message, [count_str | _]) do
    count = count_str |> String.to_integer()

    Logger.debug("count: #{count}")

    random_voice_members(message, count)
  end

  def random_guild_members(message), do: random_guild_members(message, 1)

  # NOTE: get_guild_members/2 にバグがあるのでとりあえずは動かない
  def random_guild_members(channel_id, count) when is_integer(count) and count > 0 do
    {:ok, channel = %{guild_id: guild_id}} = API.get_channel(channel_id)

    result =
      API.list_guild_members!(guild_id, limit: 100)
      |> elem(1)
      |> Enum.flat_map(fn
        %{user: %{bot: true}} -> []
        %{user: %{username: name}} -> [name]
      end)
      |> Enum.take_random(count)
      |> Enum.join("、")

    API.create_message(channel_id, result)
  end

  def random_voice_members(channel_id, author_id, count) when is_integer(count) and count > 0 do
    {:ok, channel = %{guild_id: guild_id}} = API.get_channel(channel_id)

    with {:ok, server} <- Nostrum.Cache.GuildCache.get(guild_id),
         {:ok, voice_channel_id} <-
           Command.Util.get_voice_channel_id(server, author_id) do
      me = self()

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
        %{user: %{username: name, id: id}} -> ["<@!#{id}>"]
      end)
      |> Enum.take_random(count)
      |> Enum.each(fn mention -> API.create_message(channel_id, mention) end)
    else
      :error ->
        Command.Mention.Errors.not_in_voice_channel!(channel_id, author_id)
    end
  end
end
