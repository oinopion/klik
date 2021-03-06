# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :klik,
  ecto_repos: [Klik.Repo],
  counter_broadcasters: [Klik.Web.CounterChannelBroadcaster],
  csp: "default-src 'self'; object-src 'none'; " <>
      "connect-src ws:; style-src 'self' 'unsafe-inline'"

# Configures the endpoint
config :klik, Klik.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "WjJABSt3WabwbRrJ4ZfyPi/BuIWp6IIAyqBHr2rJKkS1y5/gr+5/ctiq7hXa+xe6",
  render_errors: [view: Klik.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Klik.PubSub, adapter: Phoenix.PubSub.PG2]

# Generated schemas will use UUID
config :klik, :generators,
  binary_id: true,
  sample_binary_id: "11111111-1111-1111-1111-111111111111"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
