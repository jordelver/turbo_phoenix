defmodule TurboPhoenixWeb.PageController do
  use TurboPhoenixWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
