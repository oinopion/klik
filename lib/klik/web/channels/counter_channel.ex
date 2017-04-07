defmodule Klik.Web.CounterChannel do
  use Klik.Web, :channel
  alias Klik.Counters

  def id(counter) do
    "counter:#{counter.id}"
  end

  def join("counter:" <> counter_id, _params, socket) do
    {:ok, assign(socket, :counter_id, counter_id)}
  end

  def handle_in("increment_counter", %{}, socket) do
    counter = Counters.get_counter!(socket.assigns.counter_id)
    Counters.increment_counter(counter)
    {:reply, :ok, socket}
  end
end
