defmodule SandboxWeb.Auth do
  import Plug.Conn

  @realm "Basic realm=\"Sandbox\""

  def init(opts), do: opts

  def call(%Plug.Conn{} = conn, _default),
    do: conn |> get_req_header("authorization") |> handle_auth(conn)

  defp handle_auth(["Basic " <> auth_token], conn),
    do:
      Application.get_env(:sandbox, :api_token)
      |> Enum.map(fn api_key ->
        api_key
        |> prepare_tokens(auth_token)
        |> compare_tokens()
      end)
      |> Enum.filter(&(&1 == true))
      |> handle_auth(conn)

  defp handle_auth([true], conn), do: conn
  defp handle_auth(_, conn), do: unauthorized(conn)

  defp prepare_tokens("test_" <> _ = api_token, auth_token),
    do: {Base.url_encode64(api_token <> ":"), auth_token}

  defp prepare_tokens(_, _), do: {nil, nil}

  defp compare_tokens({nil, _}), do: false

  defp compare_tokens({auth_token, api_token}),
    do: Plug.Crypto.secure_compare(auth_token, api_token)

  defp unauthorized(conn) do
    conn
    |> put_resp_header("www-authenticate", @realm)
    |> send_resp(401, "unauthorized")
    |> halt()
  end
end
