defmodule Bargain do
  @moduledoc """
  Documentation for `Bargain`.
  """

  def generate(text) do
    parsed  = Enum.map(String.split(text, ~r/(\n)+/), fn x -> 
      String.trim(x)
      |> parse
    end)
    {:ok, Enum.join(parsed)}
  end

  defp parse(text) do
    cond do
      String.match?(text, ~r/^\#/)          -> create_heading(text)
      String.match?(text, ~r/^[[:alpha:]]/) -> create_paragaph(text)
      String.match?(text, ~r/^>/)           -> create_blockquote(text) 
    end
  end

  def create_blockquote(text) do
    replaced = String.replace_prefix(text, "> ", "<blockquote>") 
               |> String.replace_suffix("", "</blockquote>")
    "<p>#{replaced}</p>"
  end
  

  defp create_paragaph(text) do
    converted_text = Hyperlink.convert({:ok, text})
    |> Italics.convert
    |> Bold.convert
    |> elem(1)

    "<p>#{converted_text}</p>"
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
