defmodule TurboPhoenixWeb.RandomSleep do
  import Plug.Conn

  def init(options), do: options

  def call(conn, _opts) do
    Enum.random(0..3000) |> Process.sleep()
    conn
  end
end
