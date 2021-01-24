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
    "<p>#{elem(Hyperlink.convert(text),1)}</p>"
    |> Italics.convert
    |> elem(1)
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
