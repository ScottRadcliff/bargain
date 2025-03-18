defmodule Bargain do
  require Logger
  @moduledoc """
  The main entry point to for the application. It has one public function
  that will take the string, parse it and return it.

  Example:
    Bargain.generate("# Heading\nand some more text")
    {:ok, "<h1>Heading</h1><p>and some more text</p>"}
  """

  @spec generate(String.t()) :: {atom(), String.t()}
  def generate(text) do
    {:ok, parsed_for_code} = Codeblock.convert(text)
    parsed  = Enum.map(String.trim(parsed_for_code) |> String.split(~r/(\n)+/), fn x -> 
      parse(String.trim(x))
    end)
    {:ok, Enum.join(parsed)}
  end

  @spec parse(String.t()) :: String.t()
  defp parse(text) do
    cond do
      String.match?(text, ~r/^\#/)            -> create_heading(text)
      String.match?(text, ~r/^[[:alpha:]]/)   -> create_paragaph(text)
      String.match?(text, ~r/^\[.+\]/)        -> create_paragaph(text)
      String.match?(text, ~r/^>/)             -> create_blockquote(text) 
      String.match?(text, ~r/^---/)           -> create_horizontal_rule(text)
      # String.match?(text, ~r/<[\/]?code>/)  -> create_codeblock(text) 
      true -> text
    end
  end

  def create_horizontal_rule(_text) do
    "<hr>"
  end

  def create_codeblock(_text) do
    Logger.info("Codeblock has already been created.")
  end

  @spec create_blockquote(String.t()) :: String.t()
  def create_blockquote(text) do
    replaced = String.replace_prefix(text, "> ", "<blockquote>") 
               |> String.replace_suffix("", "</blockquote>")
    "<p>#{replaced}</p>"
  end

  @spec create_paragaph(String.t()) :: String.t()
  defp create_paragaph(text) do
    converted_text = Hyperlink.convert({:ok, text})
    |> Italics.convert
    |> Bold.convert
    |> InlineCode.convert
    |> elem(1)

    "<p>#{converted_text}</p>"
  end

  @spec create_heading(String.t()) :: String.t()
  defp create_heading(text) do
    [hd | tl] = heading_text(text)
    level = String.length(hd)
    "<h#{level}>#{Enum.join(tl, " ")}</h#{level}>"
  end

  @spec heading_text(String.t()) :: list()
  defp heading_text(text) do
    String.trim(text)
    |> String.split
  end
end
