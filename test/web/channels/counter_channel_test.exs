defmodule Klik.Web.CounterChannelTest do
  use Klik.Web.ChannelCase, async: false

  alias Klik.Repo
  alias Klik.Counters
  alias Klik.Web.CounterChannel

  def fixture(:counter) do
    {:ok, counter} = Counters.create_counter(%{})
    counter
  end

  test "join assigns counter_id and returns current value" do
    counter = fixture(:counter)
    socket = socket()

    assert {:ok, payload, socket} = CounterChannel.join("counter:#{counter.id}", %{}, socket)
    assert socket.assigns.counter_id == counter.id
    assert %{"value" => counter.value} == payload
  end

  test "`increment_counter` increments counter and returns current value and increment" do
    counter = fixture(:counter)
    socket = joined_socket(counter)

    ref = push socket, "increment_counter", %{}
    assert_reply ref, :ok
    assert Repo.get_by(Counters.Counter, id: counter.id, value: 1)
  end

  defp joined_socket(counter) do
    channel_id = CounterChannel.id(counter)
    subscribe_and_join!(socket(), CounterChannel, channel_id, %{})
  end
end
