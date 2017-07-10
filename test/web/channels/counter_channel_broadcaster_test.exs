defmodule Klik.Web.CounterChannelBroadcasterTest do
  use Klik.Web.ChannelCase, async: false

  alias Klik.Counters
  alias Klik.Web.{CounterChannel, CounterChannelBroadcaster}

  def fixture(:counter) do
    {:ok, counter} = Counters.create_counter(%{})
    counter
  end

  def fixture(:counter, :increment) do
    counter = fixture(:counter)
    {:ok, counter, increment} = Counters.increment_counter(counter)
    {counter, increment}
  end

  test "counter_incremented broadcasts current value of counter and the increment id" do
    {counter, increment} = fixture(:counter, :increment)
    joined_socket(counter)

    payload = %{
      "counter" => %{"value" => counter.value},
      "increment" => %{"id" => increment.id}
    }
    CounterChannelBroadcaster.counter_incremented(counter, increment)
    assert_broadcast "counter_incremented", ^payload
  end

  defp joined_socket(counter) do
    channel_id = CounterChannel.id(counter)
    subscribe_and_join!(socket(), CounterChannel, channel_id, %{})
  end
end
