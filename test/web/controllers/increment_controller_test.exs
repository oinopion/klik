defmodule Klik.Web.IncrementControllerTest do
  use Klik.Web.ConnCase
  alias Klik.Counters

  def fixture(:counter) do
    {:ok, counter} = Counters.create_counter()
    counter
  end

  test "increments counter and redirects to the counter details page", %{conn: conn} do
    counter = fixture(:counter)
    conn = post conn, counter_increment_path(conn, :create, counter)

    assert redirected_to(conn) == counter_path(conn, :show, counter)
  end

end
