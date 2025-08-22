defmodule PayfiWeb.PageController do
  use PayfiWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
