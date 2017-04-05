defmodule Klik.Web.CounterChannelTest do
  use Klik.Web.ConnCase, async: true

  alias Klik.Web.CounterChannel
  alias Phoenix.Socket

  test "join assigns counter_id" do
    socket = %Socket{assigns: %{}}
    assert {:ok, socket} = CounterChannel.join("counter:foux-du-fa-fa", %{}, socket)
    assert socket.assigns.counter_id == "foux-du-fa-fa"
  end
end
