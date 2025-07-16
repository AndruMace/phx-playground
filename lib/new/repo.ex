defmodule New.Repo do
  use Ecto.Repo,
    otp_app: :new,
    adapter: Ecto.Adapters.Postgres
end
