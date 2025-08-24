defmodule PayfiWeb.ApiDocsController do
  use PayfiWeb, :controller

  def index(conn, _params) do
    yaml_path = Path.join(:code.priv_dir(:payfi), "static/openapi.yaml")

    conn
    |> put_resp_content_type("application/yaml")
    |> send_file(200, yaml_path)
  end
end
