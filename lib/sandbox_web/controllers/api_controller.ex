defmodule SandboxWeb.ApiController do
  use SandboxWeb, :controller
  alias Sandbox.Base.{Authorization, Repo}

  def accounts_index(conn, _params) do
    [_, _, level, _] = extract_key(conn)
    account = Repo.list_accounts(level)

    conn |> json(account)
  end

  def accounts_get(conn, %{"account_id" => id}) do
    [_, _, level, _] = extract_key(conn)

    case Repo.get_account(level, id) do
      [] -> conn |> forbidden()
      account -> conn |> json(account)
    end
  end

  def transactions_index(conn, %{"account_id" => id}) do
    [_seed1, seed2, _, _] = extract_key(conn)

    case verify_account_id(seed2, id) do
      true -> conn |> json(Repo.list_transactions(id))
      false -> conn |> forbidden()
    end
  end

  def transactions_get(conn, %{"account_id" => id, "transaction_id" => t_id}) do
    [_, seed2, _, _] = extract_key(conn)
    verify_account_id(seed2, id) |> handle_authz(conn, id, t_id)
  end

  # * Helpers

  defp extract_key(conn) do
    ["Basic " <> api_key] = conn |> get_req_header("authorization")

    api_key
    |> Base.decode64!()
    |> String.replace(":", "")
    |> Authorization.get_key_priviledge_level()
  end

  defp verify_account_id(seed, account_id), do: "test_acc_#{seed}" == account_id

  defp handle_authz(true, conn, acc_id, trx_id) do
    case Repo.get_transaction(acc_id, trx_id) do
      nil -> forbidden(conn)
      transaction -> conn |> json(transaction)
    end
  end

  defp handle_authz(false, conn, _, _), do: forbidden(conn)

  defp forbidden(conn), do: conn |> send_resp(403, "forbidden") |> halt()
end
