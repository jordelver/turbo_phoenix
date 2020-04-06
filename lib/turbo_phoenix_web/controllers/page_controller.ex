defmodule TurboPhoenixWeb.PageController do
  use TurboPhoenixWeb, :controller

  alias TurboPhoenix.Signup

  @stages ~w(name address confirm thanks)

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def stage(conn, %{"stage" => stage}) do
    changeset = Signup.new_signup(saved_progress_or_new(conn))
    render(conn, template_name(stage), changeset: changeset)
  end

  def validate(conn, %{"stage" => stage, "signup" => signup_params}) do
    case Signup.validate_stage(stage, signup_params) do
      {:ok, signup} ->
        conn
        |> save_progress(signup)
        |> redirect_to_next_stage(stage)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, template_name(stage), changeset: changeset)
    end
  end

  def validate(conn, %{"stage" => "confirm" = stage}) do
    case Signup.create_signup(saved_progress_or_new(conn)) do
      {:ok, %{user: _user, address: _address}} ->
        conn
        |> clear_session
        |> redirect_to_next_stage(stage)

      {:error, _failed_operation, _failed_value, _changes_so_far} ->
        conn
        |> put_flash(:signup_error, "Error signing up")
        |> redirect(to: Routes.page_path(conn, :stage, :confirm))
    end
  end

  defp redirect_to_next_stage(conn, stage) do
    redirect(conn, to: Routes.page_path(conn, :stage, next_stage(stage)))
  end

  defp next_stage("name"), do: :address
  defp next_stage("address"), do: :confirm
  defp next_stage("confirm"), do: :thanks

  defp template_name(stage) when stage in @stages do
    "#{stage}.html"
  end

  defp template_name(_unknown), do: raise("Invalid stage")

  defp save_progress(conn, signup) do
    progress =
      Map.merge(
        saved_progress_or_new(conn),
        new_attributes(signup)
      )

    put_session(conn, :signup, progress)
  end

  defp new_attributes(signup) do
    Map.from_struct(signup)
    |> Enum.reject(fn {_, v} -> v == nil end)
    |> Enum.into(%{})
  end

  defp saved_progress_or_new(conn) do
    saved_progress(conn) || %{}
  end

  defp saved_progress(conn) do
    get_session(conn, :signup)
  end
end
