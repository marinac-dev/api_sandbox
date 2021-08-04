defmodule Mix.Tasks.GenApiKey do
  use Mix.Task

  @shortdoc "Generates a key for API."

  @impl Mix.Task
  def run(["--level", n]) do
    Mix.Task.run("app.start")
    Sandbox.Generator.Api.generate(n) |> IO.inspect()
  end

  def run(_) do
    IO.warn("Pass --level and a number between 1..3, as desired priviledge.")
  end
end
