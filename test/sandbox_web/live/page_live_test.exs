defmodule SandboxWeb.PageLiveTest do
  use SandboxWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert render(page_live) =~ "API Sandbox"
  end
end
