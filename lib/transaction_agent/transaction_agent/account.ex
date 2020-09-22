defmodule TransactionAgent.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :associated_bank_id, :balance, :holder_id]}
  schema "accounts" do
    field :associated_bank_id, :integer
    field :balance, :integer
    field :holder_id, :integer

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:balance, :holder_id, :associated_bank_id])
    |> validate_required([:balance, :holder_id, :associated_bank_id])
  end
end
