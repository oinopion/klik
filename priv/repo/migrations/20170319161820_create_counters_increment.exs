defmodule Klik.Repo.Migrations.CreateKlik.Counters.Increment do
  use Ecto.Migration

  def change do
    create table(:counters_increments, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :value, :integer, default: 1, null: false
      add :counter_id,
        references(:counters_counters, on_delete: :nothing, type: :binary_id),
        null: false

      timestamps()
    end

    create index(:counters_increments, [:counter_id])
  end
end
