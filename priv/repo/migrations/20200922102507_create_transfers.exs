defmodule TransactionAgent.Repo.Migrations.CreateTransfers do
  use Ecto.Migration

  def change do
    create table(:transfers) do
      add :amount, :bigint, null: false
      add :succeeded, :boolean, default: false, null: false
      add :origin_account_id, references "accounts"
      add :origin_bank_id, references "banks"
      add :destination_account_id, references "accounts"
      add :destination_bank_id, references "banks"

      timestamps()
    end

  end
end
