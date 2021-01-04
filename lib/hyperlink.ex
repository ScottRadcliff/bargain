defmodule Hyperlink do
  # Given a string, look for a pattern of [text](url) and convert to
  # <a href=url>text</a>
  #
  # Takes a string, converts markdown to HTML link
  # syntax and returns the string
  def convert(string) do
    links = capture_link_segments(string)
           |> build_link

    replace_link(links, string)
  end

  defp replace_link([head | tail], text) do
    replace_link(tail, String.replace(text, ~r/\[\w+\]\(http:\/\/\w+\.com\)/, head, global: false))
  end

  defp replace_link([], string) do
    string
  end

  def capture_link_segments(markdown) do
    Regex.scan(~r/\[(?<text>\w+)\]\((?<url>http\:\/\/\w+\.\w+)\)/, markdown)
  end

  defp build_link(captures) do
    Enum.map(captures, fn x -> 
      "<a href='#{Enum.at(x, 2)}'>#{Enum.at(x, 1)}</a>"
    end)
  end 
end


