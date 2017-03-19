defmodule Klik.Counters.Counter do
  use Klik.Schema

  schema "counters_counters" do
    field :name, :string
    field :value, :integer, default: 0

    timestamps()
  end
end
