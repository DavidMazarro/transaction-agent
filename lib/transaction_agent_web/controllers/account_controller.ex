defmodule TransactionAgentWeb.AccountController do
  alias TransactionAgent.Repo
  use TransactionAgentWeb, :controller

  defp conn_with_status(conn, value) do
    case value do
      nil -> put_status(conn, :not_found)
      _ -> put_status(conn, :ok)
    end
  end

  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, _params) do
    accounts = Repo.all(TransactionAgent.Account)
    json conn_with_status(conn, accounts), accounts
  end

  def show(conn, %{"id" => id}) do
    account = Repo.get(TransactionAgent.Account, String.to_integer(id))
    json conn_with_status(conn, account), account
  end

  def create(conn, params) do
    changeset = TransactionAgent.Account.changeset(
      %TransactionAgent.Account{}, params)
    case Repo.insert(changeset) do
      {:ok, account} -> json put_status(conn, :created), account
      {:error, _changeset} ->
        json put_status(conn, :bad_request), %{errors: ["unable to create account"] }
    end
  end
end
