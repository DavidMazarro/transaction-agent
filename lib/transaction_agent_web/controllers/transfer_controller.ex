defmodule TransactionAgentWeb.TransferController do
  alias TransactionAgent.Repo
  require Logger
  use TransactionAgentWeb, :controller

  defp conn_with_status(conn, value) do
    case value do
      nil -> put_status(conn, :not_found)
      _ -> put_status(conn, :ok)
    end
  end

  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, _params) do
    transfers = Repo.all(TransactionAgent.Transfer)
    json conn, transfers
  end

  def show(conn, %{"id" => id}) do
    transfer = Repo.get(TransactionAgent.Transfer, String.to_integer(id))
    json conn_with_status(conn, transfer), transfer
  end

  def create(conn, params) do
    changeset = TransactionAgent.Transfer.changeset(
      %TransactionAgent.Transfer{}, params)
    case Repo.insert(changeset) do
      {:ok, transfer} ->
        if transfer.amount > 0 do
          case update_balances transfer do
            :insufficient_balance ->
              json put_status(conn, :bad_request), %{errors: ["the origin account doesn't have enough funds for this transaction"]}
            :limit_surpassed ->
              json put_status(conn, :bad_request), %{errors: ["interbank transfers cannot surpass 1000€"]}
            :ok ->
              Logger.debug inspect(transfer)
              json put_status(conn, :created), transfer
          end
        else
          json put_status(conn, :bad_request), %{errors: ["the transferred amount must be greater than 0"]}
        end
      {:error, _changeset} ->
        json put_status(conn, :bad_request), %{errors: ["unable to create transfer"] }
    end
  end

  defp update_balances(transfer) do
    origin_account = TransactionAgent.Account
      |> Repo.get(transfer.origin_account_id)
    destination_account = TransactionAgent.Account
      |> Repo.get(transfer.destination_account_id)
    transfer_amount = Money.new(transfer.amount, :EUR)
    interbank_transfer = transfer.origin_bank_id == transfer.destination_bank_id
    commission_money = Money.new((if interbank_transfer, do: 5, else: 0), :EUR)
    total_amount = Money.add transfer_amount, commission_money
    case Money.compare total_amount, Money.new(origin_account.balance, :EUR) do
      1 -> :insufficient_balance
      _ ->
        if interbank_transfer and transfer.amount > 1000 do
          :limit_surpassed
        else
          origin_new_balance = Money.new(origin_account.balance, :EUR)
            |> Money.subtract(total_amount)
          destination_new_balance = Money.new(destination_account.balance, :EUR)
            |> Money.add(transfer_amount)
          origin_changeset = TransactionAgent.Account.changeset(
            origin_account, %{balance: origin_new_balance.amount}
          )
          destination_changeset = TransactionAgent.Account.changeset(
            destination_account, %{balance: destination_new_balance.amount}
          )
          Repo.update(origin_changeset)
          Repo.update(destination_changeset)
          :ok
        end
    end
  end
end
