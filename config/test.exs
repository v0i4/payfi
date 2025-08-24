import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :payfi, Payfi.Repo,
  username: "postgres",
  password: "postgres",
  database: "payfi_test",
  hostname: "localhost",
  port: 5500,
  pool_size: 5,
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :payfi, PayfiWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "IH3j0UbkEXnysGLIECAyiZA7lm8sNfs03u+z9mzdKEEf80wRDAPVvdpkL0ZQuSFX",
  server: false

# In test we don't send emails
config :payfi, Payfi.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Enable helpful, but potentially expensive runtime checks
config :phoenix_live_view,
  enable_expensive_runtime_checks: true

config :payfi, Oban, testing: :manual
