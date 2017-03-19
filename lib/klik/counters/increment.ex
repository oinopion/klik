defmodule Klik.Counters.Increment do
  use Klik.Schema
  alias Klik.Counters.Counter

  schema "counters_increments" do
    field :value, :integer, default: 1
    belongs_to :counter, Counter

    timestamps()
  end
end
