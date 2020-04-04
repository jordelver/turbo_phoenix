defmodule TurboPhoenixWeb.PageController do
  use TurboPhoenixWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def name(conn, _params) do
    render(conn, "name.html")
  end

  def address(conn, _params) do
    render(conn, "address.html")
  end

  def confirm(conn, _params) do
    render(conn, "confirm.html")
  end

  def thanks(conn, _params) do
    render(conn, "thanks.html")
  end
end
