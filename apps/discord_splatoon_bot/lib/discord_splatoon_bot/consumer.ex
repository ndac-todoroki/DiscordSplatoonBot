defmodule DiscordSplatoonBot.Consumer do
  use Nostrum.TaskedConsumer

  alias DiscordSplatoonBot.Command

  def start_link do
    TaskedConsumer.start_link(__MODULE__)
  end

  def handle_event({:MESSAGE_CREATE, {msg}, _ws_state}) do
    IO.inspect msg
    Command.handle(msg)
  end

  def handle_event(any) do
    IO.inspect any
    :noop
  end
end