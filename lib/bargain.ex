defmodule Bargain do
  @moduledoc """
  Documentation for `Bargain`.
  """

  def generate(text) do
    case String.starts_with?(text, "#") do
      true -> {:ok, create_heading(text)}
    end
  end

  defp create_heading(text) do
    "<h1>#{heading_text(text)}</h1>"
  end

  defp heading_text(text) do
    String.trim(text)
    |> String.split
    |> tl
    |> Enum.join(" ")
  end
end
