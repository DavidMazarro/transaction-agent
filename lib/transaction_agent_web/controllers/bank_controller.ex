defmodule TransactionAgentWeb.BankController do
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
    banks = Repo.all(TransactionAgent.Bank)
    json conn, banks
  end

  def show(conn, %{"id" => id}) do
    bank = Repo.get(TransactionAgent.Bank, String.to_integer(id))
    json conn_with_status(conn, bank), bank
  end

  def create(conn, params) do
    changeset = TransactionAgent.Bank.changeset(
      %TransactionAgent.Bank{}, params)
    case Repo.insert(changeset) do
      {:ok, bank} -> json put_status(conn, :created), bank
      {:error, _changeset} ->
        json put_status(conn, :bad_request), %{errors: ["unable to create bank"] }
    end
  end
end
