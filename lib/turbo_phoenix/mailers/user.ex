defmodule TurboPhoenix.Mailers.User do
  import Swoosh.Email

  use Phoenix.Swoosh,
    view: TurboPhoenixWeb.EmailView,
    layout: {TurboPhoenixWeb.LayoutView, :email}

  @from {"Turbo Phoenix", "no-reply@turbo-phoenix.herokuapp.com"}

  @subject "Welcome!"

  def welcome(user) do
    new()
    |> to({name(user), user.email})
    |> from(@from)
    |> subject(@subject)
    |> render_body(:welcome, %{first_name: user.first_name})
  end

  defp name(user) do
    "#{user.first_name} #{user.last_name}"
  end
end
