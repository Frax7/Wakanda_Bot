defmodule WakandaBotTest do
  use ExUnit.Case
  doctest WakandaBot

  test "greets the world" do
    assert WakandaBot.hello() == :world
  end
end
