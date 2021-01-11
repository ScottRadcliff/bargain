defmodule HyperlinkTest do
  use ExUnit.Case
  doctest Hyperlink

  test "replace one link" do
    test_string = "hello this is a [link](http://google.com)"
    assert Hyperlink.convert(test_string) ==  {:ok, "hello this is a <a href='http://google.com'>link</a>"}
  end

  test "replace multiple links" do
    test_string = "hello this is a [link](http://google.com) and [another](http://google.com)"
    assert Hyperlink.convert(test_string) ==  {:ok, "hello this is a <a href='http://google.com'>link</a> and <a href='http://google.com'>another</a>"}
  end
end

