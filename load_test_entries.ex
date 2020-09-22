defmodule LoadTestEntries do
  alias TransactionAgent.Repo
  alias TransactionAgent.Bank
  alias TransactionAgent.Customer
  alias TransactionAgent.Account
  alias TransactionAgent.Transfer

  Repo.insert %Bank{name: "Kamoshida"}
  Repo.insert %Bank{name: "Madarame"}
  Repo.insert %Bank{name: "Sae"}
  Repo.insert %Bank{name: "Shido"}
  Repo.insert %Customer{name: "Ryuji"}
  Repo.insert %Customer{name: "Ann"}
  Repo.insert %Customer{name: "Morgana"}
  Repo.insert %Customer{name: "Futaba"}
  Repo.insert %Account{associated_bank_id: 1, balance: 50000, holder_id: 1}
  Repo.insert %Account{associated_bank_id: 1, balance: 58600, holder_id: 2}
  Repo.insert %Account{associated_bank_id: 2, balance: 7100, holder_id: 2}
  Repo.insert %Account{associated_bank_id: 3, balance: 3500, holder_id: 3}
end
