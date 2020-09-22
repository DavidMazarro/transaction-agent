# TransactionAgent

mix ecto.create
mix ecto.migrate

iex -S mix
c "load_test_entries.ex"

mix phx.server

