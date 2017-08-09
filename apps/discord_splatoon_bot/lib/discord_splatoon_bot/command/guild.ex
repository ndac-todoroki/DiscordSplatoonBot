defmodule DiscordSplatoonBot.Command.Guild do
  alias Nostrum.Api, as: API

  def random_members(message, []), do: random_members(message, ["1"])
  def random_members(message, [count_str | _]) do
    count = count_str |> String.to_integer
    # {:ok, channel = %{"guild_id" => guild_id_str}} = API.get_channel(message.channel_id)
    # guild_id = guild_id_str |> String.to_integer
    # {:ok, server} = Nostrum.Cache.Guild.GuildServer.get(id: guild_id)
    
    # voice_channel? = 
    #   server.voice_states
    #   |> Enum.find(%{}, fn(map) -> map.user_id == message.author.id end)
    #   |> Kernel.!=(%{})

    # if voice_channel? do
      random_voice_members(message, count)
    # else
    #   random_guild_members(message, count)
    # end
  end
  
  def random_guild_members(message), do: random_guild_members(message, 1)
  
  # NOTE: get_guild_members/2 にバグがあるのでとりあえずは動かない
  def random_guild_members(message, count) when is_integer(count) and count > 0 do
    {:ok, channel = %{"guild_id" => guild_id}} = API.get_channel(message.channel_id)
    
    result = 
      API.get_guild_members(guild_id, limit: 100)
      |> elem(1)
      |> Enum.flat_map(fn
        %{"user" => %{"bot" => true}} -> []
        %{"user" => %{"username" => name}} -> [name]
      end)
      |> Enum.take_random(count)
      |> Enum.join("、")

    API.create_message(message.channel_id, result)
  end

  def random_voice_members(message, count) when is_integer(count) and count > 0 do
    {:ok, channel = %{"guild_id" => guild_id_str}} = API.get_channel(message.channel_id)
    guild_id = guild_id_str |> String.to_integer

    with {:ok, server} <- Nostrum.Cache.Guild.GuildServer.get(id: guild_id) do
      voice_channel_id = 
        server.voice_states
        |> Enum.find(%{}, fn(map) -> map.user_id == message.author.id end)
        |> Map.get(:channel_id)
        |> (fn
          {:ok, nil} -> :error
          other -> other
        end).()

      if voice_channel_id do
        me = self()

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
          %{"user" => %{"username" => name, "id" => id}} -> ["<@!#{id}>"]
        end)
        |> Enum.take_random(count)
        |> Enum.each(fn(mention) -> API.create_message(message.channel_id, mention) end)
      else
        Bot.Functions.ErrorMessages.not_in_voice_channel!(message)
      end
    end
  end
end