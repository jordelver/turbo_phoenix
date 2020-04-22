defmodule TurboPhoenixWeb.PageControllerTest do
  use TurboPhoenixWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Turbo signup"
  end
end
