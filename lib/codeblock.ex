defmodule Codeblock do
  def convert(string) do
    result = string
           |> capture_sections
           |> build_code_block
           |> replace_code(string)
    {:ok, result}
  end

  defp replace_code([head | tail], text) do
    replace_code(tail, String.replace(text, matcher(), head, global: false))
  end

  defp replace_code([], string) do
    string
  end

  def build_code_block(captures) do
    Enum.map(captures, fn x -> 
      "<code>#{Enum.at(x, 1)}</code>"
    end)
  end
  

  defp capture_sections(string) do
    Regex.scan(matcher(), string, global: true)
  end

  defp matcher do
    ~r/```(.*?)```/s
  end
end

