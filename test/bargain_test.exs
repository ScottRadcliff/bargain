defmodule BargainTest do
  use ExUnit.Case
  doctest Bargain

  test "Generates HTML" do
    assert Bargain.generate("# Heading") == {:ok,"<h1>Heading</h1>"}
  end
end
