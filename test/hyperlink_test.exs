defmodule HyperlinkTest do
  use ExUnit.Case
  doctest Hyperlink

  test "smoke" do
    test_string = "hello this is a [link](http://google.com)"
    assert Hyperlink.convert(test_string) ==  "hello this is a <a href='http://google.com'>link</a>"
  end
end

