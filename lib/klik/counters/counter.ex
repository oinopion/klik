defmodule Klik.Counters.Counter do
  use Klik.Schema
  alias Klik.Counters.Increment

  schema "counters_counters" do
    field :name, :string
    field :value, :integer, default: 0
    has_many :increments, Increment

    timestamps()
  end
end
