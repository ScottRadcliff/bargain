defmodule Italics do
  @moduledoc """
  Convert markdown formatted as italicized to text within <em> html tags

  Example:

    Italics.convert({:ok, "this is _some_ text"})
    {:ok, "this is <em>some</em> text"}
  """
  def convert({:ok, string}) do
    text = string
           |> capture_sections
           |> build_emphasis
           |> replace_emphasis(string)
    {:ok, text}
  end

  defp replace_emphasis([head | tail], text) do
    replace_emphasis(tail, String.replace(text, matcher(), head, global: false))
  end

  defp replace_emphasis([], string) do
    string
  end

  defp capture_sections(string) do
    Regex.scan(matcher(), string, global: true)
  end

  defp build_emphasis(captures) do
    Enum.map(captures, fn x -> 
      "<em>#{Enum.at(x, 1)}</em>"
    end)
  end

  defp matcher do
    ~r/_(?<text>[a-zA-Z0-9\s]+)_/
  end
 
end

