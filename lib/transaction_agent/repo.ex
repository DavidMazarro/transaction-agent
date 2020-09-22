defmodule TransactionAgent.Repo do
  use Ecto.Repo,
    otp_app: :transaction_agent,
    adapter: Ecto.Adapters.Postgres
end
