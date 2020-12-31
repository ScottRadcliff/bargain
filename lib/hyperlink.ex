defmodule Hyperlink do
  # Given a string, look for a pattern of [text](url) and convert to
  # <a href=url>text</a>
  #
  # Takes a string, converts markdown to HTML link
  # syntax and returns the string
  def convert(string) do
    links = capture_link_segments(string)
           |> build_link
    str = Enum.map_join(links, fn x -> 
      replace_link(string, x)
    end)
  end

  defp replace_link(markdown, links) when length(links) > 0 do
    IO.inspect(markdown, label: "")
    IO.inspect(links, label: "")
    link = List.pop_at(links, 0)
    replaced = Regex.replace(~r/\[\w+\]\(http:\/\/\w+\.com\)/, markdown, elem(link,0), global: false)
    # replace_link(replaced, elem(link,1))
  end

  defp replace_link(markdown, link) do
    Regex.replace(~r/\[\w+\]\(http:\/\/\w+\.com\)/, markdown, link, global: false)
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


