defmodule Sandbox.Generator.Api do
  @doc """
  Generates a key for API.
  """

  def generate(level), do: level |> String.to_integer() |> generate_key()

  defp generate_key(level) when level > 0 and level <= 3,
    do: "test_#{rand_string(level * 2)}TEL#{rand_string(level * 4)}LER"

  defp generate_key(_), do: generate("1")

  defp rand_string(n),
    do: :crypto.strong_rand_bytes(n) |> Base.url_encode64(padding: false)
end
