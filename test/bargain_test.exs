defmodule BargainTest do
  use ExUnit.Case
  doctest Bargain

  test "Generates headings" do
    assert Bargain.generate("# Heading")      == {:ok,"<h1>Heading</h1>"}
    assert Bargain.generate("## Heading")     == {:ok,"<h2>Heading</h2>"}
    assert Bargain.generate("### Heading")    == {:ok,"<h3>Heading</h3>"}
    assert Bargain.generate("#### Heading")   == {:ok,"<h4>Heading</h4>"}
    assert Bargain.generate("##### Heading")  == {:ok,"<h5>Heading</h5>"}
    assert Bargain.generate("###### Heading") == {:ok,"<h6>Heading</h6>"}
  end
end
