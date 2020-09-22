defmodule TransactionAgentWeb.CustomerController do
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
    customers = Repo.all(TransactionAgent.Customer)
    json conn, customers
  end

  def show(conn, %{"id" => id}) do
    customer = Repo.get(TransactionAgent.Customer, String.to_integer(id))
    json conn_with_status(conn, customer), customer
  end

  def create(conn, params) do
    changeset = TransactionAgent.Customer.changeset(
      %TransactionAgent.Customer{}, params)
    case Repo.insert(changeset) do
      {:ok, customer} -> json put_status(conn, :created), customer
      {:error, _changeset} ->
        json put_status(conn, :bad_request), %{errors: ["unable to create customer"] }
    end
  end
end
