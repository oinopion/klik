defmodule Klik.Web.PageController do
  use Klik.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
