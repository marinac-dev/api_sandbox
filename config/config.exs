# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :sandbox, SandboxWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1WiHJAaAbdX1+/I+JZJiW+sDK9HGO/xWWiRgZo8ljt3mA7KncROaSQ9wvJu7U9EO",
  render_errors: [view: SandboxWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Sandbox.PubSub,
  live_view: [signing_salt: "OlAsf8AR"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :sandbox,
  api_token: [
    "test_y9cTELi8tV6wLER", # Level 1
    "test_cVFsdgTELMc_ueqdMyvILER", # Level 2
    "test_NNrW_9JfTELmQQI5SnwxDq84smNLER", # Level 3
  ]
