defmodule Klik.Web.PageControllerTest do
  use Klik.Web.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Ninja Clicker"
  end
end
