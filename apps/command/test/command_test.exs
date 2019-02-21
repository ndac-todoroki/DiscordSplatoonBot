defmodule CommandTest do
  use ExUnit.Case
  doctest Command

  test "greets the world" do
    assert Command.hello() == :world
  end
end
