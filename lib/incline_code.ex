defmodule InlineCode do
  def convert({:ok, string}) do
    text = string
           |> capture_sections
           |> build_inline_code
           |> replace_inline_code(string)
    {:ok, text}
  end

  defp replace_inline_code([head | tail], text) do
    replace_inline_code(tail, String.replace(text, matcher(), head, global: false))
  end

  defp replace_inline_code([], string) do
    string
  end

  defp build_inline_code(captures) do
    Enum.map(captures, fn x -> 
      "<code>#{Enum.at(x, 1)}</code>"
    end)
  end

  defp capture_sections(string) do
    Regex.scan(matcher(), string, global: true)
  end

  # The matcher captures everything that contains
  #  a-z
  #  A-Z
  #  0-9
  #  \
  #  (
  #  )
  defp matcher do
    ~r/`(?<text>[a-zA-Z0-9\\\(\)\s]+)`/
  end
end

