defmodule CodeblockTest do
  use ExUnit.Case

  test "replace a block with code tags" do
    test_string = "```\ndef code do\nsomething\n\end\n```"
    assert Codeblock.convert(test_string) ==  {:ok, "<code>\ndef code do\nsomething\n\end\n</code>"}
  end

  test "replace multiple blocks with code tags" do
  end
end

