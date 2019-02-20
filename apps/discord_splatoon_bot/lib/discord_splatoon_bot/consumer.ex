defmodule DiscordSplatoonBot.Consumer do
  use Nostrum.Consumer
  import Logger

  alias DiscordSplatoonBot.Command

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:MESSAGE_CREATE, {msg}, _ws_state}) do
    Logger.debug(inspect(msg))
    Command.handle(msg)
  end

  # Default event handler, if you don't include this, your consumer WILL crash if
  # you don't have a method definition for each event type.
  def handle_event(_event) do
    :noop
  end
end
