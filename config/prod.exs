use Mix.Config

config :klik, Klik.Web.Endpoint,
  on_init: {Klik.Web.Endpoint, :load_from_system_env, []},
  url: [host: "ninja-clicker.com", port: 80],
  cache_static_manifest: "priv/static/cache_manifest.json",
  secret_key_base: System.get_env("SECRET_KEY_BASE")

config :klik, Klik.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: {:system, "DATABASE_URL"},
  pool_size: 5,
  ssl: true

# Do not print debug messages in production
config :logger, level: :info
