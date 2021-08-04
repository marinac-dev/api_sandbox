defmodule Sandbox.Base.Authorization do
  def get_key_priviledge_level(
        "test_" <> <<seed_a::binary-size(3)>> <> "TEL" <> <<seed_b::binary-size(6)>> <> "LER" =
          api_key
      )
      when byte_size(api_key) == 20,
      do: [seed_a, seed_b, 1, api_key]

  def get_key_priviledge_level(
        "test_" <> <<seed_a::binary-size(6)>> <> "TEL" <> <<seed_b::binary-size(11)>> <> "LER" =
          api_key
      )
      when byte_size(api_key) == 28,
      do: [seed_a, seed_b, 2, api_key]

  def get_key_priviledge_level(
        "test_" <> <<seed_a::binary-size(8)>> <> "TEL" <> <<seed_b::binary-size(16)>> <> "LER" =
          api_key
      )
      when byte_size(api_key) == 35,
      do: [seed_a, seed_b, 3, api_key]

  def get_key_priviledge_level(_), do: :invalid_api_key
end
