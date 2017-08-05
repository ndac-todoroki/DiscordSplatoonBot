defmodule Bot.Functions.ErrorMessages do
  alias Nostrum.Api, as: API
  
  def not_in_voice_channel!(message) do
    API.create_message(
      message.channel_id,
      "<@#{message.author.id}> ボイスチャンネルにいませんよ！"
    )
  end
end