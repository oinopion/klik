defmodule Klik.Web.CounterChannel do
  use Klik.Web, :channel
  alias Klik.Counters

  def id(counter) do
    "counter:#{counter.id}"
  end

  def join("counter:" <> counter_id, _params, socket) do
    counter = Counters.get_counter!(counter_id)
    {:ok, %{"value" => counter.value}, assign(socket, :counter_id, counter_id)}
  end

  def handle_in("increment_counter", attrs \\ %{}, socket) do
    counter = Counters.get_counter!(socket.assigns.counter_id)
    Counters.increment_counter(counter, attrs)
    {:reply, :ok, socket}
  end
end
