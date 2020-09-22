defmodule TransactionAgent.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :balance, :bigint, null: false
      add :holder_id, references "customers"
      add :associated_bank_id, references "banks"

      timestamps()
    end

  end
end
