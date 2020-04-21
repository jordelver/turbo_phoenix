defmodule TurboPhoenix.Signup do
  alias TurboPhoenix.Mailer
  alias TurboPhoenix.Mailers
  alias TurboPhoenix.Repo
  alias TurboPhoenix.Schema.{Address, User}
  alias TurboPhoenix.Schema.Signup, as: Schema

  def new_signup(params \\ %{}) do
    Schema.changeset(%Schema{}, params)
  end

  # `apply_action(:update)` runs the validations we have within each
  # `*_changeset/1` functions which is how we validate each stage.
  #
  # From the Ecto documentation:
  #
  #   "Ecto automatically applies the action for you when you call
  #   Repo.insert/update/delete, but if you want to show errors manually you
  #   can also set the action yourself, either directly on the Ecto.Changeset
  #   struct field or by using Ecto.Changeset.apply_action/2."
  #
  def validate_stage("name" = _stage, params) do
    %Schema{}
    |> Schema.name_changeset(params)
    |> Ecto.Changeset.apply_action(:update)
  end

  def validate_stage("address" = _stage, params) do
    %Schema{}
    |> Schema.address_changeset(params)
    |> Ecto.Changeset.apply_action(:update)
  end

  def create_signup(params) do
    Ecto.Multi.new()
    |> Ecto.Multi.insert(:user, User.changeset(%User{}, params))
    |> Ecto.Multi.run(:address, fn _repo, %{user: user} ->
      Address.changeset_with_user(%Address{}, user, params)
      |> Repo.insert()
    end)
    |> Repo.transaction()
    |> case do
      {:ok, %{user: user, address: _address}} ->
        send_welcome_email(user)
        {:ok, :signup_created}

      {:error, _action, _changeset, _changes_so_far} ->
        {:error, :signup_failed}
    end
  end

  defp send_welcome_email(user) do
    Mailers.User.welcome(user)
    |> Mailer.deliver!()
  end
end
