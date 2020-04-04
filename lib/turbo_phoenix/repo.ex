defmodule TurboPhoenix.Repo do
  use Ecto.Repo,
    otp_app: :turbo_phoenix,
    adapter: Ecto.Adapters.Postgres
end
