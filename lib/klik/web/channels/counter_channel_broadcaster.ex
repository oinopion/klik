defmodule Klik.Web.CounterChannelBroadcaster do
  @behaviour Klik.Counters.Broadcaster

  alias Klik.Web.{Endpoint, CounterChannel}

  def counter_incremented(counter) do
    counter
    |> CounterChannel.id()
    |> Endpoint.broadcast!("counter_incremented", %{"value" => counter.value})
  end
end
