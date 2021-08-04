defmodule Sandbox.Generator.Account do
  alias Sandbox.Base.Account

  def generate(seed) do
    <<account_number::32>> <> _ = seed |> Base.url_decode64!(padding: false)
    # ! Hard-coded reference to localhost so I can follow instructions
    self = "http://localhost:4000/accounts/test_acc_#{seed}"
    institution = rand_inst()

    Account.create(%{
      account_number: account_number,
      balances: %{
        available: round(account_number / 42),
        ledger: round(account_number / 42)
      },
      currency_code: "USD",
      enrollment_id: "test_enr_#{rand_str()}",
      id: "test_acc_#{seed}",
      institution: %{
        id: institution |> String.downcase() |> String.replace(" ", "_"),
        institution: institution
      },
      links: %{
        self: self,
        transactions: self <> "/transactions"
      },
      name: rand_name(),
      routing_numbers: %{
        arch: ceil(account_number * 2),
        wire: floor(account_number / 2)
      }
    })
  end

  defp rand_str(), do: :crypto.strong_rand_bytes(6) |> Base.url_encode64(padding: false)
  defp rand_inst(), do: Account.all_institutions() |> Enum.random()
  defp rand_name(), do: Account.all_names() |> Enum.random()
end
