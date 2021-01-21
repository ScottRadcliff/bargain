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

  test "multiple words in link text" do
    test_string = "hello this is a [link to something](http://google.com) and [this is another](http://google.com)"
    assert Hyperlink.convert(test_string) ==  {:ok, "hello this is a <a href='http://google.com'>link to something</a> and <a href='http://google.com'>this is another</a>"}
  end

  test "secure url" do
    test_string = "hello this is a [link to something](https://google.com) and [this is another](http://google.com)"
    assert Hyperlink.convert(test_string) ==  {:ok, "hello this is a <a href='https://google.com'>link to something</a> and <a href='http://google.com'>this is another</a>"}
  end

  test ".net domain" do
    test_string = "hello this is a [link to something](https://google.net) and [this is another](http://google.com)"
    assert Hyperlink.convert(test_string) ==  {:ok, "hello this is a <a href='https://google.net'>link to something</a> and <a href='http://google.com'>this is another</a>"}
  end

  test ".engineer domain" do
    test_string = "hello this is a [link to something](https://google.engineer) and [this is another](http://google.com)"
    assert Hyperlink.convert(test_string) ==  {:ok, "hello this is a <a href='https://google.engineer'>link to something</a> and <a href='http://google.com'>this is another</a>"}
  end

  test "subdomains" do
    test_string = "hello this is a [link to something](https://sub.google.engineer) and [this is another](http://google.com)"
    assert Hyperlink.convert(test_string) ==  {:ok, "hello this is a <a href='https://sub.google.engineer'>link to something</a> and <a href='http://google.com'>this is another</a>"}
  end
end

