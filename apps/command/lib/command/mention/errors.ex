defmodule Command.Mention.Errors do
  alias Nostrum.Api, as: API

  def not_in_voice_channel!(channel_id, author_id) do
    API.create_message(
      channel_id,
      "<@#{author_id}> ボイスチャンネルにいませんよ！"
    )
  end
end
