defmodule Sandbox.Base.Transaction do
  @type t :: %__MODULE__{
          type: String.t(),
          running_balance: float(),
          links: map(),
          id: String.t(),
          description: String.t(),
          date: Date,
          amount: float(),
          account_id: Sandbox.Base.Account.id()
        }

  defstruct [:id, :amount, :type, :date, :description, :account_id, :running_balance, :links]

  def create(params) do
    %__MODULE__{
      type: params.type,
      running_balance: params.running_balance,
      links: params.links,
      id: params.id,
      description: params.description,
      date: params.date,
      amount: params.amount,
      account_id: params.account_id
    }
  end
end

defimpl Jason.Encoder, for: Sandbox.Base.Transaction do
  def encode(value, opts),
    do: Jason.Encode.map(Map.take(value, [:id, :amount, :type, :date, :description, :account_id, :running_balance, :links]), opts)
end
