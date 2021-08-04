defmodule Sandbox.Base.Repo do
  @doc """
  Wrapper around Cache.
  """
  alias Sandbox.Base.Cache

  def list_accounts(permission) do
    Cache.list_all()
    |> Enum.map(fn {required, data} ->
      if required <= permission, do: data, else: nil
    end)
    |> Enum.filter(&(&1 != nil))
  end

  def get_account(permission, account_id) do
    Cache.list_all()
    |> Enum.map(fn {required, acc} ->
      if permission >= required && account_id == acc.id, do: acc
    end)
    |> Enum.filter(&(&1 != nil))
  end

  def list_transactions(account_id) do
    Cache.list_all()
    |> Enum.map(fn {_, value} ->
      case value do
        {^account_id, data} -> data
        _ -> nil
      end
    end)
    |> Enum.filter(&(&1 != nil))
    |> Enum.sort(&(Date.compare(&1.date, &2.date) != :lt))
  end

  def get_transaction(account_id, transaction_id),
    do: transaction_id |> Cache.read() |> can_read(account_id)

  defp can_read([{_trx_id, {acc_id, data}}], account_id),
    do: if(acc_id == account_id, do: data, else: nil)
end
