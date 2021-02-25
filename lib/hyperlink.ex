defmodule Hyperlink do
  # Given a string, look for a pattern of [text](url) and convert to
  # <a href=url>text</a>
  #
  # Takes a string, converts markdown to HTML link
  # syntax and returns the string
  def convert({:ok, string}) do
    links = capture_link_segments(string)
           |> build_link

    {:ok, replace_link(links, string)}
  end

  defp replace_link([head | tail], text) do
    replace_link(tail, String.replace(text, matcher(), head, global: false))
  end

  defp replace_link([], string) do
    string
  end

  defp capture_link_segments(markdown) do
    Regex.scan(matcher(), markdown)
  end

  defp build_link(captures) do
    Enum.map(captures, fn x -> 
      "<a href='#{Enum.at(x, 2)}'>#{Enum.at(x, 1)}</a>"
    end)
  end 

  defp matcher do
    ~r/\[(?<text>[\w\.?\s]+)\]\((?<url>http[s]?\:\/\/\w+[\.\w+]+\w+)\)/
  end
  
end


