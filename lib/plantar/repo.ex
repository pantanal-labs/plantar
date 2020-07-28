defmodule Plantar.Repo do
  use Ecto.Repo,
    otp_app: :plantar,
    adapter: Ecto.Adapters.Postgres
end
