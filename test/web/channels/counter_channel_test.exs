defmodule Klik.Web.CounterChannelTest do
  use Klik.Web.ChannelCase, async: false

  alias Klik.Repo
  alias Klik.Counters
  alias Klik.Web.CounterChannel

  def fixture(:counter) do
    {:ok, counter} = Counters.create_counter(%{})
    counter
  end

  test "join assigns counter_id" do
    socket = socket()
    assert {:ok, socket} = CounterChannel.join("counter:foux-du-fa-fa", %{}, socket)
    assert socket.assigns.counter_id == "foux-du-fa-fa"
  end

  test "`increment_counter` increments counter and returns current value" do
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
