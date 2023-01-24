defmodule BargainTest do
  use ExUnit.Case
  doctest Bargain

  test "Generates headings" do
    assert Bargain.generate("# Heading")                == {:ok, "<h1>Heading</h1>"}
    assert Bargain.generate("## Heading Two")           == {:ok, "<h2>Heading Two</h2>"}
    assert Bargain.generate("### Heading Two Three")    == {:ok, "<h3>Heading Two Three</h3>"}
    assert Bargain.generate("#### Heading")             == {:ok, "<h4>Heading</h4>"}
    assert Bargain.generate("##### Heading")            == {:ok, "<h5>Heading</h5>"}
    assert Bargain.generate("###### Heading")           == {:ok, "<h6>Heading</h6>"}
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

  test "Generates hyperlinks" do
    assert Bargain.generate("This is a paragraph and a [link](http://google.com)") == {:ok, "<p>This is a paragraph and a <a href='http://google.com'>link</a></p>"}
  end

  test "italicizes text" do
    assert Bargain.generate("there is some _text_ here") == {:ok, "<p>there is some <em>text</em> here</p>"}
    assert Bargain.generate("there is some _text_ here and _here too_") == {:ok, "<p>there is some <em>text</em> here and <em>here too</em></p>"}
    assert Bargain.generate("there _is some text here and here too_") == {:ok, "<p>there <em>is some text here and here too</em></p>"}
  end

  test "bold text" do
    assert Bargain.generate("there is some **text** here") == {:ok, "<p>there is some <strong>text</strong> here</p>"}
    assert Bargain.generate("there is some **text** here and **also here**") == {:ok, "<p>there is some <strong>text</strong> here and <strong>also here</strong></p>"}
  end

  test "blockquote" do
    assert Bargain.generate("> there is some text here") == {:ok, "<p><blockquote>there is some text here</blockquote></p>"}
  end

  test "inline code" do
    assert Bargain.generate("There is inline `code\2` here") == {:ok, "<p>There is inline <code>code\2</code> here</p>"}
    assert Bargain.generate("There is `def func()` here") == {:ok, "<p>There is <code>def func()</code> here</p>"}
  end
end
