defmodule TransactionAgent.Transfer do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :amount, :destination_bank_id, :destination_account_id, :origin_bank_id, :origin_account_id, :succeeded]}
  schema "transfers" do
    field :amount, :integer
    field :destination_bank_id, :integer
    field :destination_account_id, :integer
    field :origin_bank_id, :integer
    field :origin_account_id, :integer
    field :succeeded, :boolean, default: true

    timestamps()
  end

  @doc false
  def changeset(transfer, attrs) do
    transfer
    |> cast(attrs, [:amount, :succeeded, :origin_bank_id, :origin_account_id, :destination_bank_id, :destination_account_id])
    |> validate_required([:amount, :succeeded, :origin_bank_id, :origin_account_id, :destination_bank_id, :destination_account_id])
  end
end
