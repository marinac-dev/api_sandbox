defmodule SandboxWeb.PageLive do
  use SandboxWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
