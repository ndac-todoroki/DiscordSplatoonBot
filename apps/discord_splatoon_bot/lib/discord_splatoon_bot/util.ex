defmodule DiscordSplatoonBot.Util do
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
