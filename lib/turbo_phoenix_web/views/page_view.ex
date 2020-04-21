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

  @doc """
  The amount complete the progress bar should be
  """
  def amount_complete(%{request_path: "/signup/name"}), do: 20
  def amount_complete(%{request_path: "/signup/address"}), do: 40
  def amount_complete(%{request_path: "/signup/confirm"}), do: 60
  def amount_complete(%{request_path: "/signup/thanks"}), do: 80

  @doc """
  The textual percentage amount complete
  """
  def percentage_complete(%{request_path: "/signup/name"}), do: "25%"
  def percentage_complete(%{request_path: "/signup/address"}), do: "50%"
  def percentage_complete(%{request_path: "/signup/confirm"}), do: "75%"
  def percentage_complete(%{request_path: "/signup/thanks"}), do: "100%"

  @doc """
  Outputs the CSS class "complete" if the step is complete
  """
  def step_complete?(step, %Plug.Conn{request_path: path}), do: complete?(step, path)

  # name step
  def step_complete?(:name, "/signup/name"), do: "complete"
  def step_complete?(:name, "/signup/address"), do: "complete"
  def step_complete?(:name, "/signup/address"), do: "complete"
  def step_complete?(:name, "/signup/confirm"), do: "complete"
  def step_complete?(:name, "/signup/thanks"), do: "complete"

  # address step
  def step_complete?(:address, "/signup/address"), do: "complete"
  def step_complete?(:address, "/signup/address"), do: "complete"
  def step_complete?(:address, "/signup/confirm"), do: "complete"
  def step_complete?(:address, "/signup/thanks"), do: "complete"

  # confirm step
  def step_complete?(:confirm, "/signup/confirm"), do: "complete"
  def step_complete?(:confirm, "/signup/thanks"), do: "complete"

  # thanks step
  def step_complete?(:thanks, "/signup/thanks"), do: "complete"

  # step not complete
  def step_complete?(_step, _path), do: nil
end
