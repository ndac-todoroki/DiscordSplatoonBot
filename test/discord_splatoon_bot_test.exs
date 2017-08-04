defmodule DiscordSplatoonBotTest do
  use ExUnit.Case
  doctest DiscordSplatoonBot

  test "greets the world" do
    assert DiscordSplatoonBot.hello() == :world
  end
end
