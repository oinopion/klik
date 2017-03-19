defmodule Klik.Counters.Increment do
  use Klik.Schema

  schema "counters_increments" do
    field :value, :integer, default: 1
    field :counter_id, :binary_id

    timestamps()
  end
end
