defmodule Klik.CountersTest do
  use Klik.DataCase

  alias Klik.Counters
  alias Klik.Counters.Counter

  @create_attrs %{}
  @update_attrs %{name: "some updated name"}

  def fixture(:counter, attrs \\ @create_attrs) do
    {:ok, counter} = Counters.create_counter(attrs)
    counter
  end

  test "list_counters/1 returns all counters" do
    counter = fixture(:counter)
    assert Counters.list_counters() == [counter]
  end

  test "get_counter! returns the counter with given id" do
    counter = fixture(:counter)
    assert Counters.get_counter!(counter.id) == counter
  end

  test "create_counter/1 with valid data creates a counter with default value" do
    assert {:ok, %Counter{} = counter} = Counters.create_counter(@create_attrs)
    assert counter.value == 0
  end

  test "update_counter/2 with valid data updates the counter" do
    counter = fixture(:counter)
    assert {:ok, counter} = Counters.update_counter(counter, @update_attrs)
    assert %Counter{} = counter
    assert counter.name == @update_attrs.name
    assert counter.value == 0
  end

  test "change_counter/1 returns a counter changeset" do
    counter = fixture(:counter)
    assert %Ecto.Changeset{} = Counters.change_counter(counter)
  end
end
