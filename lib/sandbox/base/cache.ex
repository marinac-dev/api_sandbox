defmodule Sandbox.Base.Cache do
  @doc """
  Since persistence is not allowed lets cache stuff :)
  """

  alias Sandbox.Generator.{Account, Transaction}
  alias Sandbox.Base.Authorization

  @table_name :api_cache
  @opts [:set, {:read_concurrency, true}, :public, :named_table]
  @days_back 90

  def init() do
    with _ <- :ets.new(@table_name, @opts) do
      Application.get_env(:sandbox, :api_token)
      |> Enum.map(fn api_key ->
        [_, seed, level, _] = api_key |> Authorization.get_key_priviledge_level()

        # Create account
        account = Account.generate(seed)
        write(level, account)
        balance = account.balances.available

        # Create transactions
        new_balance = transactions_chain(account, @days_back, balance)

        # Update account with transactions spend
        account = Sandbox.Base.Repo.get_account(level, account.id)

        new_account =
          Map.update!(account, :balances, fn old_balance ->
            %{available: new_balance, ledger: old_balance.ledger}
          end)

        write(level, new_account)
      end)
    end
  end

  defp transactions_chain(_account, 0, balance), do: balance

  defp transactions_chain(account, day, balance) do
    date = Date.utc_today() |> Date.add(-day)
    amount = (:rand.uniform(1500) + 30) * -1
    trx = Transaction.generate({account, date, balance + amount, amount})

    write(trx.id, {account.id, trx})

    transactions_chain(account, day - 1, balance + amount)
  end

  def read(key), do: :ets.lookup(@table_name, key)
  def write(key, value), do: :ets.insert(@table_name, {key, value})
  def list_all(), do: :ets.tab2list(@table_name)
end
