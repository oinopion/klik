defmodule Klik.Web.CounterChannelBroadcaster do
  @behaviour Klik.Counters.Broadcaster

  alias Klik.Web.{Endpoint, CounterChannel}

  def counter_incremented(counter, increment) do
    payload = %{
      "counter" => %{"value" => counter.value},
      "increment" => %{"id" => increment.id},
    }

    counter
    |> CounterChannel.id()
    |> Endpoint.broadcast!("counter_incremented", payload)
  end
end
