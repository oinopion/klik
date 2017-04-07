defmodule Klik.Web.PageController do
  use Klik.Web, :controller

  @preloaded_resources [
    {"/css/app.css", "style"},
    {"/fonts/lato.woff2", "font"},
    {"/js/app.js", "script"},
  ]

  def index(conn, _params) do
    conn
    |> put_preload_header(@preloaded_resources)
    |> render("index.html")
  end
end
