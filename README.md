# TransactionAgent

## Installation

As a requierement, you need to have both [Elixir](https://elixir-lang.org/) and [PostgreSQL](https://www.postgresql.org/) installed in your system,
as well as `mix` and `iex` (which should come with your Elixir installation).
You will also need [Phoenix](https://hexdocs.pm/phoenix/installation.html);
the current version (1.5.5) can be installed with the following command:

```
mix archive.install hex phx_new 1.5.5
```

Then, you can get the necessary dependencies with:

```
mix deps.get
```
Now you should configure your PostgreSQL user and password in [/config/dev.exs](https://github.com/DavidMazarro/transaction-agent/blob/master/config/dev.exs).
After that, you can create the corresponding tables:

```
mix ecto.create
mix ecto.migrate
```

Optionally, you can populate them with a few test entries bundled with the project so you don't have to create them yourself, provided in [load_test_entries.ex](https://github.com/DavidMazarro/transaction-agent/blob/master/load_test_entries.ex):

```
iex -S mix
c "load_test_entries.ex"
```

Finally, to start the API server (which will default to `localhost:4000`), run:

```
mix phx.server
```

