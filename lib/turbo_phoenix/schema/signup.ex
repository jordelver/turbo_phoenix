defmodule TurboPhoenix.Schema.Signup do
  # This Schema is "virtual", that is, not persisted, and does not actually map
  # to an underlying database table. We use it as a data structure to store the
  # data as we go through the signup process, and also somewhere to house
  # validation functions for each stage

  import Ecto.Changeset
  use Ecto.Schema

  embedded_schema do
    # name fields
    field :first_name, :string
    field :last_name, :string
    field :username, :string
    field :email, :string

    # address fields
    field :address1, :string
    field :address2, :string
    field :town, :string
    field :postcode, :string
    field :country, :string
  end

  def changeset(signup, params \\ %{}) do
    signup
    |> cast(params, [
      :first_name,
      :last_name,
      :username,
      :email,
      :address1,
      :address2,
      :town,
      :postcode,
      :country
    ])
  end

  def name_changeset(signup, params \\ %{}) do
    signup
    |> cast(params, [:first_name, :last_name, :username, :email])
    |> validate_required([:first_name, :last_name, :username, :email])
  end

  def address_changeset(signup, params \\ %{}) do
    signup
    |> cast(params, [:address1, :address2, :town, :postcode, :country])
    |> validate_required([:address1, :town, :postcode, :country])
  end
end
