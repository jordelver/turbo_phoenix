defmodule TurboPhoenixWeb.PageView do
  use TurboPhoenixWeb, :view

  @fade_in_class "fade-in-right"

  @doc """
  Returns the correct CSS class for page transitions
  """
  def transition(%Plug.Conn{method: "GET"} = conn) do
    if is_nil(get_flash(conn, :signup_error)) do
      @fade_in_class
    end
  end

  @doc """
  Returns the correct CSS class for page transitions
  """
  def transition(%Plug.Conn{method: "POST"} = _conn), do: ""
end
