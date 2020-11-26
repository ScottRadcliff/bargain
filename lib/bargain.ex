defmodule Bargain do
  @moduledoc """
  Documentation for `Bargain`.
  """

  def generate(text) do
    case String.starts_with?(text, "#") do
      true -> {:ok, create_heading(text)}
      false -> {:ok, create_paragaph(text)}
    end
  end
  
  defp create_paragaph(text) do
    "<p>#{text}</p>"
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
