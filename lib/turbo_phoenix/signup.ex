defmodule TurboPhoenix.Signup do
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
  def validate_stage("name" = stage, params) do
    %Schema{}
    |> Schema.name_changeset(params) # TODO See what this looks like using `apply`
    |> Ecto.Changeset.apply_action(:update)
  end

  def validate_stage("address" = stage, params) do
    %Schema{}
    |> Schema.address_changeset(params) # TODO See what this looks like using `apply`
    |> Ecto.Changeset.apply_action(:update)
  end

  def create_signup(params) do
    # TODO Uses Ecto.Multi to create records within transaction
    #
    # Save records
    # * Names to a users table
    # * Addresses to an addresses table
    #
    params |> IO.inspect()
    {:ok, nil}
  end
end
