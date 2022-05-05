defmodule Bold do
  @moduledoc """
  Convert markdown formatted as bold to text within <strong> html tags

  Example:

    Bold.convert({:ok, "this is **some** text"})
    {:ok, "this is <strong>some</strong> text"}
  """

  def convert({:ok, string}) do
    text = string
           |> capture_sections
           |> build_bold_text
           |> replace_bold_text(string)
    {:ok, text}
  end

  defp replace_bold_text([head | tail], text) do
    replace_bold_text(tail, String.replace(text, matcher(), head, global: false))
  end

  defp replace_bold_text([], string) do
    string
  end

  defp capture_sections(string) do
    Regex.scan(matcher(), string, global: true)
  end

  defp build_bold_text(captures) do
    Enum.map(captures, fn x -> 
      "<strong>#{Enum.at(x, 1)}</strong>"
    end)
  end

  defp matcher do
    ~r/\*\*(?<text>[a-zA-Z0-9\s]+)\*\*/
  end
end

