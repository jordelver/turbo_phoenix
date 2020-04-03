defmodule TurboPhoenixWeb.PageController do
  use TurboPhoenixWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def foo(conn, _params) do
    render(conn, "foo.html")
  end

  def bar(conn, _params) do
    render(conn, "bar.html")
  end
end
