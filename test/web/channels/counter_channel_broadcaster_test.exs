defmodule Klik.Web.CounterChannelBroadcasterTest do
  use Klik.Web.ChannelCase, async: false

  alias Klik.Counters
  alias Klik.Web.{CounterChannel, CounterChannelBroadcaster}

  def fixture(:counter) do
    {:ok, counter} = Counters.create_counter(%{})
    counter
  end

  test "counter_incremented broadcasts current value of counter" do
    counter = fixture(:counter)
    joined_socket(counter)

    CounterChannelBroadcaster.counter_incremented(counter)
    assert_broadcast "counter_incremented", %{"value" => 0}
  end

  defp joined_socket(counter) do
    channel_id = CounterChannel.id(counter)
    subscribe_and_join!(socket(), CounterChannel, channel_id, %{})
  end
end
