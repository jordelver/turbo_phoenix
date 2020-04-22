defmodule TurboPhoenixWeb.PageView do
  use TurboPhoenixWeb, :view

  @stages [:name, :address, :confirm, :thanks]

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
  Outputs the CSS class "complete" if the stage is complete

  ## Examples

      iex> stage_complete?(:name, %Plug.Conn{request_path: "/signup/address"})
      "complete"

      iex> stage_complete?(:thanks, %Plug.Conn{request_path: "/signup/name"})
      nil

  """
  def stage_complete?(stage, %Plug.Conn{request_path: request_path}) do
    stage_complete?(stage, request_path)
  end

  def stage_complete?(stage, request_path) do
    current_stage =
      Path.split(request_path)
      |> List.last()
      |> String.to_existing_atom()

    if stage in completed_stages(current_stage), do: "complete"
  end

  @doc """
  Returns all the stages that have been completed _before_ and _including_ the
  given `stage` according to the stages listed in `@stages`.

  ## Examples

      iex> completed_stages(:thanks)
      [:name, :address, :confirm, :thanks]

      iex> completed_stages(:address)
      [:name, :address]

  """
  def completed_stages(current_stage) do
    Enum.take_while(@stages, fn completed_stage -> completed_stage != current_stage end)
    |> Enum.concat([current_stage])
  end
end
