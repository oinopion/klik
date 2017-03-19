defmodule Klik.Web.CounterControllerTest do
  use Klik.Web.ConnCase

  alias Klik.Counters

  @create_attrs %{}
  @update_attrs %{name: "some updated name"}

  def fixture(:counter) do
    {:ok, counter} = Counters.create_counter(@create_attrs)
    counter
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, counter_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Counters"
  end

  test "creates counter and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, counter_path(conn, :create), counter: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == counter_path(conn, :show, id)

    conn = get conn, counter_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Counter"
  end

  test "renders form for editing chosen counter", %{conn: conn} do
    counter = fixture(:counter)
    conn = get conn, counter_path(conn, :edit, counter)
    assert html_response(conn, 200) =~ "Edit Counter"
  end

  test "updates chosen counter and redirects when data is valid", %{conn: conn} do
    counter = fixture(:counter)
    conn = put conn, counter_path(conn, :update, counter), counter: @update_attrs
    assert redirected_to(conn) == counter_path(conn, :show, counter)

    conn = get conn, counter_path(conn, :show, counter)
    assert html_response(conn, 200) =~ "some updated name"
  end

end
