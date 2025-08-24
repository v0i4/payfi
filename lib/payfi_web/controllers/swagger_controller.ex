defmodule PayfiWeb.SwaggerController do
  use PayfiWeb, :controller

  def index(conn, _params) do
    redirect(conn, external: "/swagger/index.html")
  end
end
