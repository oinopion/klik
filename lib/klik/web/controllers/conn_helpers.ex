defmodule Klik.Web.ConnHelpers do
  @moduledoc false

  import Plug.Conn
  import Klik.Web.Router.Helpers

  def put_preload_header(conn, resources) do
    header_value = Enum.map_join resources, ", ", &preload_header_fragment/1
    put_resp_header conn, "link", header_value
  end

  defp preload_header_fragment({asset_path, "font"}), do:
    "<#{static_path(Klik.Web.Endpoint, asset_path)}>; rel=preload; crossorigin; as=font"
  defp preload_header_fragment({asset_path, role}), do:
    "<#{static_path(Klik.Web.Endpoint, asset_path)}>; rel=preload; as=#{role}"
end
