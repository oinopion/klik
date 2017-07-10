defmodule Klik.Counters.Broadcaster do
  @callback counter_incremented(%Klik.Counters.Counter{}, %Klik.Counters.Increment{}) :: none()
end
