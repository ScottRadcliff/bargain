defmodule CodeblockTest do
  use ExUnit.Case

  test "replace a block with code tags" do
    test_string = "```\ndef code do\nsomething\n\end\n```"
    assert Codeblock.convert(test_string) ==  {:ok, "<code>\ndef code do\nsomething\n\end\n</code>"}
  end

  test "replace a block in a larger section" do
    str = "This is a multiline string.\n\nand a\n\n```\ncode block\n```\n"
    assert Codeblock.convert(str) ==  {:ok, "This is a multiline string.\n\nand a\n\n<code>\ncode block\n</code>\n"}
  end

  test "replace multiple blocks with code tags" do
    str = "this is something\n\n```\ncode\n```\n\nAnd this\n\n```\nmore code\n```\n"
    assert Codeblock.convert(str) ==  {:ok, "this is something\n\n<code>\ncode\n</code>\n\nAnd this\n\n<code>\nmore code\n</code>\n"}
  end
end

