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

## Requesting the API

You can get all of the existing customers, banks, accounts or transfers by sending a GET request to `/api/customers`, `/api/banks/`, `/api/accounts/` or `/api/transfers` respectively. Furthermore, instead of asking for every entry, you can get the contents of a specific entry by providing appending the ID to the URL (i.e. a GET request to `/api/accounts/3` will return the information of the account with associated ID of 3).

You can add new customers, banks, accounts and transfers to the database by sending a POST request to `/api/customers`, `/api/banks/`, `/api/accounts/` or `/api/transfers` (same as before) with the body filled in with a JSON with the necessary fields, mirroring the ones in the [Examples](https://github.com/DavidMazarro/transaction-agent#examples) section.

When a new transfer is added to the database, the balances are updated according to the amount that was transferred.

### Examples 
#### customers
```JSON
{
    "name": "Kasumi"
}
```
#### banks
```JSON
{
    "name": "Leblanc"
}
```
#### accounts
```JSON
{
    "associated_bank_id": 1,
    "balance": 7100,
    "holder_id": 1
}
```
#### transfers
```JSON
{
    "amount": 1000,
    "destination_bank_id": 2,
    "destination_account_id": 2,
    "origin_bank_id": 1,
    "origin_account_id": 1,
}
```
