defmodule BargainTest do
  use ExUnit.Case
  doctest Bargain

  test "greets the world" do
    assert Bargain.hello() == :world
  end
end
