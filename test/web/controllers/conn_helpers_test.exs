defmodule Klik.Web.ConnHelpersTest do
  use Klik.Web.ConnCase
  alias Klik.Web.ConnHelpers

  test "put_preload_header sets correct link header", %{conn: conn} do
    resources = [
      {"/css/app.css", "style"},
      {"/fonts/lato.woff2", "font"}
    ]

    conn = ConnHelpers.put_preload_header(conn, resources)
    assert [value] = get_resp_header(conn, "link")
    assert value == Enum.join([
      "</css/app.css>; rel=preload; as=style",
      "</fonts/lato.woff2>; rel=preload; crossorigin; as=font",
    ], ", ")
  end

end
