defmodule Klik.Web.UserSocketTest do
  use Klik.Web.ConnCase

  alias Phoenix.Socket
  alias Klik.Web.UserSocket

  test "connect always succeeds" do
    socket = %Socket{}
    assert {:ok, ^socket} = UserSocket.connect(%{}, socket)
  end

  test "id returns nil" do
    assert UserSocket.id(%Socket{}) == nil
  end
end
