defmodule BargainTest do
  use ExUnit.Case
  doctest Bargain

  test "Generates headings" do
    assert Bargain.generate("# Heading")                == {:ok,"<h1>Heading</h1>"}
    assert Bargain.generate("## Heading Two")           == {:ok,"<h2>Heading Two</h2>"}
    assert Bargain.generate("### Heading Two Three")    == {:ok,"<h3>Heading Two Three</h3>"}
    assert Bargain.generate("#### Heading")             == {:ok,"<h4>Heading</h4>"}
    assert Bargain.generate("##### Heading")            == {:ok,"<h5>Heading</h5>"}
    assert Bargain.generate("###### Heading")           == {:ok,"<h6>Heading</h6>"}
  end

  test "Generates paragraphs" do
    assert Bargain.generate("This is a paragraph") == {:ok, "<p>This is a paragraph</p>"}
    assert Bargain.generate("This is a paragraph") == {:ok, "<p>This is a paragraph</p>"}
    assert Bargain.generate("This is a paragraph\nAnd another") == {:ok, "<p>This is a paragraph</p><p>And another</p>"}
  end

  test "Generates a heading and paragraphs" do
    test_string = "## This is a heading
    With a paragraph
    and another paragraph"
    assert Bargain.generate(test_string) == {:ok, "<h2>This is a heading</h2><p>With a paragraph</p><p>and another paragraph</p>"}
  end
end
