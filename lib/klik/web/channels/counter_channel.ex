defmodule Klik.Web.CounterChannel do
  use Klik.Web, :channel

  def id(counter) do
    "counter:#{counter.id}"
  end

  def join("counter:" <> counter_id, _params, socket) do
    {:ok, assign(socket, :counter_id, counter_id)}
  end
end
