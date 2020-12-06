defmodule Hyperlink do
  # Given a string, look for a pattern of [text](url) and convert to
  # <a href=url>text</a>
  #
  # Takes a string, converts markdown to HTML link
  # syntax and returns the string
  def convert(string) do
    link = capture_link_segments(string)
           |> build_link
    Regex.replace(~r/\[.+\]\(.+\)/, string, link)
  end

  defp capture_link_segments(markdown) do
    Regex.named_captures(~r/\[(?<text>\w+)\]\((?<url>.+)\)/, markdown)
  end

  defp build_link(captures_map) do
    "<a href='#{captures_map["url"]}'>#{captures_map["text"]}</a>"
  end 
end


