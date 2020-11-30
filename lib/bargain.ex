defmodule Bargain do
  @moduledoc """
  Documentation for `Bargain`.
  """

  def generate(text) do
    parsed  = Enum.map(String.split(text, "\n"), fn x -> 
      String.trim(x)
      |> parse
    end)
    {:ok, Enum.join(parsed)}
  end

  defp parse(text) do
    cond do
      String.match?(text, ~r/^\#/)          -> create_heading(text)
      String.match?(text, ~r/^[[:alpha:]]/) -> create_paragaph(text)
    end
  end
  
  defp create_paragaph(text) do
    # new_text = String.replace(text, ~r/\[\w+\]\(.+\)/, fn x -> convert_hyperlink(x) end)
    String.replace(text, ~r/\[\w+\]/, fn x -> "<a href='/'>#{convert_hyperlink_text(x)}</a>" end)
    String.replace(text, ~r/\(.+\)/, fn x -> "<a href='/'>#{convert_hyperlink(x)}</a>" end)
    IO.puts(text)
    # find hyperlink syntax
    # replace
    "<p>#{text}</p>"
  end

  defp convert_hyperlink(text) do
    url = Regex.named_captures(~r/\((?<text>.+)\)/, text)
    url["text"]
  end

  defp convert_hyperlink_text(text) do
    # captures = Regex.named_captures(~r/\[(?<text>\w+)\]\((?<url>.+)\)/, text)
    title = Regex.named_captures(~r/\[(?<text>\w+)\]/, text)
    title["text"]
  end

  defp create_heading(text) do
    [hd | tl] = heading_text(text)
    level = String.length(hd)
    "<h#{level}>#{Enum.join(tl, " ")}</h#{level}>"
  end

  defp heading_text(text) do
    String.trim(text)
    |> String.split
  end
end
