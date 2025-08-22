defmodule Payfi.Repo do
  use Ecto.Repo,
    otp_app: :payfi,
    adapter: Ecto.Adapters.SQLite3
end
