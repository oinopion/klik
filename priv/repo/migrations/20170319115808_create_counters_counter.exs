defmodule Klik.Repo.Migrations.CreateKlik.Counters.Counter do
  use Ecto.Migration

  def change do
    create table(:counters_counters, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :value, :integer, default: 0, null: false

      timestamps()
    end

  end
end
