defmodule Sandbox.Generator.Transaction do
  alias Sandbox.Base.{Account, Transaction}

  def generate({account, date, balance, amount}) do
    # ! Hard-coded reference to localhost so I can follow instructions
    acc_link = "http://localhost:4000/accounts/#{account.id}"
    id = "test_txn_#{rand_str()}"

    Transaction.create(%{
      type: "card_payment",
      running_balance: balance,
      links: %{
        self: "#{acc_link}/transactions/#{id}",
        account: acc_link
      },
      id: id,
      description: rand_merch(),
      date: date,
      amount: amount,
      account_id: account.id
    })
  end

  defp rand_str(), do: :crypto.strong_rand_bytes(6) |> Base.url_encode64(padding: false)
  defp rand_merch(), do: Account.all_merchants() |> Enum.random()
end
